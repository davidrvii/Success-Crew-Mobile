import 'package:flutter/material.dart';

import '../controllers/notification_controller.dart';
import '../../domain/entities/notification.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

class NotificationPage extends StatefulWidget {
  final NotificationController controller;

  const NotificationPage({super.key, required this.controller});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
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
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(context, 'Notifikasi'),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  final c = widget.controller;

                  if (c.isLoading && c.notifications.isEmpty) {
                    return const ListShimmerView();
                  }

                  if (c.errorMessage != null && c.notifications.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(c.errorMessage!),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: c.fetchNotifications,
                            child: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (c.notifications.isEmpty) {
                    return const Center(
                      child: Text('Belum ada notifikasi.'),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: c.fetchNotifications,
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: c.notifications.length,
                      itemBuilder: (context, index) {
                        final notif = c.notifications[index];
                        return _NotificationCard(notification: notif);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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

class _NotificationCard extends StatelessWidget {
  final AppNotification notification;

  const _NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    final isRead = notification.isRead;
    
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isRead ? Colors.white : const Color(0xFFF0F4FA),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isRead ? Colors.grey.shade200 : const Color(0xFF1C5AA6).withValues(alpha: 0.1),
          child: Icon(
            isRead ? Icons.notifications_none : Icons.notifications_active,
            color: isRead ? Colors.grey : const Color(0xFF1C5AA6),
          ),
        ),
        title: Text(
          notification.title ?? 'Notifikasi',
          style: TextStyle(
            fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(notification.description ?? ''),
            const SizedBox(height: 4),
            Text(
              notification.createdAt?.toString() ?? '',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
