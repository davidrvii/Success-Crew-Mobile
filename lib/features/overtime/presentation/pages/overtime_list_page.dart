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
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        title: const Text('Daftar Lembur'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final c = widget.controller;

          if (c.isLoading && c.overtimes.isEmpty) {
            return const ListShimmerView();
          }

          if (c.errorMessage != null && c.overtimes.isEmpty) {
            return Center(
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
          }

          if (c.overtimes.isEmpty) {
            return const Center(
              child: Text('Belum ada data lembur.'),
            );
          }

          return RefreshIndicator(
            onRefresh: c.fetchOvertimes,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: c.overtimes.length,
              itemBuilder: (context, index) {
                final overtime = c.overtimes[index];
                return _OvertimeCard(overtime: overtime);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/overtime-add');
        },
        backgroundColor: const Color(0xFF1DB954),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _OvertimeCard extends StatelessWidget {
  final Overtime overtime;

  const _OvertimeCard({required this.overtime});

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
            Text('${overtime.startTime?.toString().substring(11, 16) ?? ''} s/d ${overtime.endTime?.toString().substring(11, 16) ?? ''}'),
            const SizedBox(height: 4),
            Text('Alasan: ${overtime.reason ?? '-'}'),
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
