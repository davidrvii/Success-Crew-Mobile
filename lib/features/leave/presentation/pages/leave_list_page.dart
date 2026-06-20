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
                    final reload = await context.push('/leave-add');
                    if (reload == true && mounted) {
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
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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
                'Crew: ${leave.userName ?? '-'}${leave.userName != null ? '' : ' (ID: ${leave.userId})'}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
            ],
            Text(
              '${leave.startDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(leave.startDate!) : ''} s/d ${leave.endDate != null ? DateFormat('dd MMMM yyyy', 'id_ID').format(leave.endDate!) : ''}',
            ),
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

  /// Method `_showConfirmDialog` returning `void`.
  /// Handles logic operations related to `_showConfirmDialog`.
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
