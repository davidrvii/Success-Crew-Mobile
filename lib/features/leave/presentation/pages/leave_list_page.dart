/// File: lib/features/leave/presentation/pages/leave_list_page.dart
/// Generated Documentation for leave_list_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../controllers/leave_controller.dart';
import '../../domain/entities/leave.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

/// Class representing `LeaveListPage`.
/// Auto-generated class documentation.
class LeaveListPage extends StatefulWidget {
  final LeaveController controller;

  const LeaveListPage({super.key, required this.controller});

  @override
  State<LeaveListPage> createState() => _LeaveListPageState();
}

/// Class representing `_LeaveListPageState`.
/// Auto-generated class documentation.
class _LeaveListPageState extends State<LeaveListPage> {
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
  void didUpdateWidget(LeaveListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.controller.init();
      });
    }
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
          final displayLeaves = c.leaves;

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
                  return Dismissible(
                    key: Key('leave_${leave.id}'),
                    direction: leave.isPending ? DismissDirection.endToStart : DismissDirection.none,
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
                        'Hapus Pengajuan Cuti',
                        'Apakah Anda yakin ingin menghapus pengajuan cuti ini?',
                      );
                    },
                    onDismissed: (direction) async {
                      final success = await c.deleteLeave(leave.id);
                      if (success && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pengajuan cuti berhasil dihapus')),
                        );
                      }
                    },
                    child: _LeaveCard(leave: leave, controller: c),
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
                _buildCustomHeader(context, 'Cuti'),
                Expanded(child: body),
              ],
            ),
          ),
          floatingActionButton: c.isOwner
              ? null
              : FloatingActionButton(
                  onPressed: () async {
                    await context.push('/leave-add');
                    if (mounted) {
                      c.fetchLeaves();
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

/// Class representing `_LeaveCard`.
/// Auto-generated class documentation.
class _LeaveCard extends StatelessWidget {
  final Leave leave;
  final LeaveController controller;

  const _LeaveCard({required this.leave, required this.controller});

  @override
  Widget build(BuildContext context) {
    final statusText = _getStatusText(leave.status);
    final statusColor = _getStatusColor(leave.status);
    final hasButtons = controller.isOwner && leave.isPending;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.05),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    leave.userName ?? 'Nama Crew',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (!hasButtons)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      statusText.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _buildDetailRow('Tanggal Mulai', leave.startDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(leave.startDate!) : '-'),
            const SizedBox(height: 6),
            _buildDetailRow('Tanggal Selesai', leave.endDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(leave.endDate!) : '-'),
            const SizedBox(height: 6),
            _buildDetailRow('Keterangan', leave.reason ?? '-'),
            if (hasButtons) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildCircleActionButton(
                    onPressed: () => _showConfirmDialog(context, false),
                    icon: Icons.close,
                    color: Colors.red,
                  ),
                  const SizedBox(width: 16),
                  _buildCircleActionButton(
                    onPressed: () => _showConfirmDialog(context, true),
                    icon: Icons.check,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Text(
          ' : ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircleActionButton({
    required VoidCallback onPressed,
    required IconData icon,
    required Color color,
  }) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.5),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  void _showConfirmDialog(BuildContext context, bool approve) {
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(approve ? 'Terima Pengajuan' : 'Tolak Pengajuan', style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(approve
            ? 'Apakah Anda yakin ingin menyetujui pengajuan cuti ini?'
            : 'Apakah Anda yakin ingin menolak pengajuan cuti ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
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

  String _getStatusText(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return 'Diterima';
      case 'rejected':
        return 'Ditolak';
      default:
        return 'Pending';
    }
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

/// Method `_showDeleteConfirmDialog` returning `Future<bool?>`.
/// Handles logic operations related to `_showDeleteConfirmDialog`.
Future<bool?> _showDeleteConfirmDialog(BuildContext context, String title, String message) {
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
            child: const Text('Hapus', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}
