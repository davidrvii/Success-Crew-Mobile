/// File: lib/features/out_of_office/presentation/pages/out_of_office_list_page.dart
/// Generated Documentation for out_of_office_list_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../controllers/out_of_office_controller.dart';
import '../../domain/entities/out_of_office.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

/// Class representing `OutOfOfficeListPage`.
/// Auto-generated class documentation.
class OutOfOfficeListPage extends StatefulWidget {
  final OutOfOfficeController controller;

  const OutOfOfficeListPage({super.key, required this.controller});

  @override
  State<OutOfOfficeListPage> createState() => _OutOfOfficeListPageState();
}

/// Class representing `_OutOfOfficeListPageState`.
/// Auto-generated class documentation.
class _OutOfOfficeListPageState extends State<OutOfOfficeListPage> {
  @override
  /// Method `initState` returning `void`.
  /// Handles logic operations related to `initState`.
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.init();
    });
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) {
        final c = widget.controller;

        Widget body;
        if (c.isLoading && c.outOfOffices.isEmpty) {
          body = const ListShimmerView();
        } else if (c.errorMessage != null && c.outOfOffices.isEmpty) {
          body = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(c.errorMessage!),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: c.fetchOutOfOffices,
                  child: const Text('Coba Lagi'),
                ),
              ],
            ),
          );
        } else {
          final displayList = c.isOwner
              ? c.outOfOffices.where((o) => o.isPending).toList()
              : c.outOfOffices;

          if (displayList.isEmpty) {
            body = Center(
              child: Text(
                c.isOwner
                    ? 'Tidak ada pengajuan dinas luar.'
                    : 'Belum ada data dinas luar.',
              ),
            );
          } else {
            body = RefreshIndicator(
              onRefresh: c.fetchOutOfOffices,
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final item = displayList[index];
                  return Dismissible(
                    key: Key('ooo_${item.id}'),
                    direction: item.isPending
                        ? DismissDirection.endToStart
                        : DismissDirection.none,
                    background: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      return await _showDeleteConfirmDialog(
                        context,
                        'Hapus Pengajuan Dinas',
                        'Apakah Anda yakin ingin menghapus pengajuan dinas ini?',
                      );
                    },
                    onDismissed: (direction) async {
                      final success = await c.deleteOutOfOffice(item.id);
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pengajuan dinas berhasil dihapus'),
                          ),
                        );
                      }
                    },
                    child: _OutOfOfficeCard(item: item, controller: c),
                  );
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
                _buildCustomHeader(context, 'Dinas Luar'),
                Expanded(child: body),
              ],
            ),
          ),
          floatingActionButton: c.isOwner
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    final reload = await context.push('/out-of-office-add');
                    if (reload == true && mounted) {
                      c.fetchOutOfOffices();
                    }
                  },
                  backgroundColor: const Color(0xFF1C5AA6),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
        );
      },
    );
  }

  /// Method `_buildCustomHeader` returning `Widget`.
  /// Handles logic operations related to `_buildCustomHeader`.
  Widget _buildCustomHeader(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B5FA5),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.maybePop(context),
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0B5FA5), size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

/// Class representing `_OutOfOfficeCard`.
/// Auto-generated class documentation.
class _OutOfOfficeCard extends StatelessWidget {
  final OutOfOffice item;
  final OutOfOfficeController controller;

  const _OutOfOfficeCard({required this.item, required this.controller});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          'Dinas Luar',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            if (controller.isOwner) ...[
              Text(
                'Crew: ${item.userName ?? '(ID: ${item.userId})'}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              'Tanggal: ${item.startDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(item.startDate!) : ''} s/d ${item.endDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(item.endDate!) : ''}',
            ),
            const SizedBox(height: 4),
            Text('Keterangan: ${item.description ?? '-'}'),
            if (controller.isOwner && item.isPending) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => _showConfirmDialog(context, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
            color: _statusColor(item.status).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            item.status?.toUpperCase() ?? 'PENDING',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: _statusColor(item.status),
            ),
          ),
        ),
      ),
    );
  }

  /// Method `_showConfirmDialog` returning `void`.
  /// Handles logic operations related to `_showConfirmDialog`.
  void _showConfirmDialog(BuildContext context, bool approve) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(approve ? 'Terima Pengajuan' : 'Tolak Pengajuan'),
        content: Text(
          approve
              ? 'Apakah Anda yakin ingin menyetujui pengajuan dinas ini?'
              : 'Apakah Anda yakin ingin menolak pengajuan dinas ini?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogCtx);
              final success = await controller.updateStatus(
                item.id,
                approve ? 'approved' : 'rejected',
              );
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? (approve
                              ? 'Pengajuan dinas berhasil disetujui'
                              : 'Pengajuan dinas berhasil ditolak')
                          : (controller.errorMessage ??
                              'Gagal memperbarui status'),
                    ),
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

  Color _statusColor(String? status) {
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

/// Method `_showDeleteConfirmDialog` returning `Future<bool?>`.
/// Handles logic operations related to `_showDeleteConfirmDialog`.
Future<bool?> _showDeleteConfirmDialog(
  BuildContext context,
  String title,
  String message,
) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Hapus',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
