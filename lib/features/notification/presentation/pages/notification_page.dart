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
