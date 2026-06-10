import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/leave_controller.dart';
import '../../domain/entities/leave.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

class LeaveListPage extends StatefulWidget {
  final LeaveController controller;

  const LeaveListPage({super.key, required this.controller});

  @override
  State<LeaveListPage> createState() => _LeaveListPageState();
}

class _LeaveListPageState extends State<LeaveListPage> {
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
        if (c.isLoading && c.leaves.isEmpty) {
          body = const ListShimmerView();
        } else if (c.errorMessage != null && c.leaves.isEmpty) {
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(c.errorMessage!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: c.fetchLeaves,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        } else {
          final displayLeaves = c.isOwner
              ? c.leaves.where((l) => l.isPending).toList()
              : c.leaves;

          if (displayLeaves.isEmpty) {
            body = Center(
              child: Text(c.isOwner
                  ? 'Tidak ada pengajuan cuti.'
                  : 'Belum ada data cuti.'),
            );
          } else {
            body = RefreshIndicator(
              onRefresh: c.fetchLeaves,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: displayLeaves.length,
                itemBuilder: (context, index) {
                  final leave = displayLeaves[index];
                  return _LeaveCard(leave: leave, controller: c);
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
                _buildCustomHeader(context, 'Cuti'),
                Expanded(child: body),
              ],
            ),
          ),
          floatingActionButton: c.isOwner
              ? null
              : FloatingActionButton(
                  onPressed: () {
                    context.push('/leave-add');
                  },
                  backgroundColor: const Color(0xFF1C5AA6),
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

class _LeaveCard extends StatelessWidget {
  final Leave leave;
  final LeaveController controller;

  const _LeaveCard({required this.leave, required this.controller});

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
          leave.leaveType ?? 'Cuti',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            if (controller.isOwner) ...[
              Text(
                'Karyawan: ${leave.userName ?? '-'}${leave.userName != null ? '' : ' (ID: ${leave.userId})'}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
            ],
            Text('${leave.startDate?.toString().substring(0, 10) ?? ''} s/d ${leave.endDate?.toString().substring(0, 10) ?? ''}'),
            const SizedBox(height: 4),
            Text('Alasan: ${leave.reason ?? '-'}'),
            if (controller.isOwner && leave.isPending) ...[
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
            color: _getStatusColor(leave.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            leave.status?.toUpperCase() ?? 'PENDING',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _getStatusColor(leave.status),
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
            ? 'Apakah Anda yakin ingin menyetujui pengajuan cuti ini?'
            : 'Apakah Anda yakin ingin menolak pengajuan cuti ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              final success = await controller.updateStatus(
                leave.id,
                approve ? 'approved' : 'rejected',
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? (approve
                            ? 'Pengajuan cuti berhasil disetujui'
                            : 'Pengajuan cuti berhasil ditolak')
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
