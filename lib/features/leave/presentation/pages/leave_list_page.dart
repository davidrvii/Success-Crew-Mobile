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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Daftar Cuti'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final c = widget.controller;

          if (c.isLoading && c.leaves.isEmpty) {
            return const ListShimmerView();
          }

          if (c.errorMessage != null && c.leaves.isEmpty) {
            return Center(
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
          }

          if (c.leaves.isEmpty) {
            return const Center(
              child: Text('Belum ada data cuti.'),
            );
          }

          return RefreshIndicator(
            onRefresh: c.fetchLeaves,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: c.leaves.length,
              itemBuilder: (context, index) {
                final leave = c.leaves[index];
                return _LeaveCard(leave: leave);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/leave-add');
        },
        backgroundColor: const Color(0xFF1C5AA6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _LeaveCard extends StatelessWidget {
  final Leave leave;

  const _LeaveCard({required this.leave});

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
            Text('${leave.startDate?.toString().substring(0, 10) ?? ''} s/d ${leave.endDate?.toString().substring(0, 10) ?? ''}'),
            const SizedBox(height: 4),
            Text('Alasan: ${leave.reason ?? '-'}'),
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
