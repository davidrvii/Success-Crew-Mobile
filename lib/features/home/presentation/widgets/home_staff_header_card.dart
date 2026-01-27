import 'package:flutter/material.dart';

class HomeStaffHeaderCard extends StatelessWidget {
  final String name;
  final String role;
  final int unreadCount;
  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapCheckIn;

  const HomeStaffHeaderCard({
    super.key,
    required this.name,
    required this.role,
    required this.unreadCount,
    this.onTapNotifications,
    this.onTapCheckIn,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 10),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFFE5E7EB),
                child: Icon(
                  Icons.person_outline_rounded,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _Identity(name: name, role: role),
              ),
              const SizedBox(width: 10),
              _BellButton(
                badge: unreadCount > 0 ? unreadCount : null,
                onTap: onTapNotifications,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CheckInButton(onTap: onTapCheckIn),
        ],
      ),
    );
  }
}

class _Identity extends StatelessWidget {
  final String name;
  final String role;

  const _Identity({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          role,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

class _BellButton extends StatelessWidget {
  final int? badge;
  final VoidCallback? onTap;

  const _BellButton({this.badge, this.onTap});

  @override
  Widget build(BuildContext context) {
    const blue = Color(0xFF1C5AA6);

    return Material(
      color: blue,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: Colors.white,
                ),
              ),
              if (badge != null)
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF3B30),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      badge! > 99 ? '99+' : badge.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CheckInButton extends StatelessWidget {
  final VoidCallback? onTap;

  const _CheckInButton({this.onTap});

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF22C55E);

    return Material(
      color: green,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Check In',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              Icon(Icons.fingerprint_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
