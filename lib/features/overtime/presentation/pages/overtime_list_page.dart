import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/overtime_controller.dart';
import '../../domain/entities/overtime.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

class OvertimeListPage extends StatefulWidget {
  final OvertimeController controller;

  const OvertimeListPage({super.key, required this.controller});

  @override
  State<OvertimeListPage> createState() => _OvertimeListPageState();
}

class _OvertimeListPageState extends State<OvertimeListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final c = widget.controller;

        Widget body;
        if (c.isLoading && c.overtimes.isEmpty) {
          body = const ListShimmerView();
        } else if (c.errorMessage != null && c.overtimes.isEmpty) {
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(c.errorMessage!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: c.fetchOvertimes,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        } else {
          final displayOvertimes = c.isOwner
              ? c.overtimes.where((o) => o.isPending).toList()
              : c.overtimes;

          if (displayOvertimes.isEmpty) {
            body = Center(
              child: Text(c.isOwner
                  ? 'Tidak ada pengajuan lembur.'
                  : 'Belum ada data lembur.'),
            );
          } else {
            body = RefreshIndicator(
              onRefresh: c.fetchOvertimes,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: displayOvertimes.length,
                itemBuilder: (context, index) {
                  final overtime = displayOvertimes[index];
                  return _OvertimeCard(overtime: overtime, controller: c);
                },
              ),
            );
          }
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF6F7FB),
          body: SafeArea(
            child: Column(
              children: [
                _buildCustomHeader(context, 'Lembur'),
                Expanded(child: body),
              ],
            ),
          ),
          floatingActionButton: c.isOwner
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    context.push('/overtime-add');
                  },
                  backgroundColor: const Color(0xFF1DB954),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
        );
      },
    );
  }

  Widget _buildCustomHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C5AA6), // Brand blue
        borderRadius: BorderRadius.circular(28), // Rounded rectangle shape
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 12,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () => Navigator.maybePop(context),
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _OvertimeCard extends StatelessWidget {
  final Overtime overtime;
  final OvertimeController controller;

  const _OvertimeCard({required this.overtime, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          overtime.overtimeDate?.toString().substring(0, 10) ?? 'Tanggal Lembur',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            if (controller.isOwner) ...[
              Text(
                'Karyawan: ${overtime.userName ?? '-'}${overtime.userName != null ? '' : ' (ID: ${overtime.userId})'}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
            ],
            Text('${overtime.startTime?.toString().substring(11, 16) ?? ''} s/d ${overtime.endTime?.toString().substring(11, 16) ?? ''}'),
            const SizedBox(height: 4),
            Text('Alasan: ${overtime.reason ?? '-'}'),
            if (controller.isOwner && overtime.isPending) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => _showConfirmDialog(context, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Tolak'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _showConfirmDialog(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Terima'),
                  ),
                ],
              ),
            ],
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: _getStatusColor(overtime.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            overtime.status?.toUpperCase() ?? 'PENDING',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(overtime.status),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, bool approve) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(approve ? 'Terima Pengajuan' : 'Tolak Pengajuan'),
        content: Text(approve
            ? 'Apakah Anda yakin ingin menyetujui pengajuan lembur ini?'
            : 'Apakah Anda yakin ingin menolak pengajuan lembur ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              final success = await controller.updateStatus(
                overtime.id,
                approve ? 'approved' : 'rejected',
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? (approve
                            ? 'Pengajuan lembur berhasil disetujui'
                            : 'Pengajuan lembur berhasil ditolak')
                        : (controller.errorMessage ?? 'Gagal memperbarui status')),
                  ),
                );
              }
            },
            child: Text(
              approve ? 'Terima' : 'Tolak',
              style: TextStyle(
                color: approve ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
