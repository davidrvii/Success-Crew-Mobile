/// File: lib/features/home/presentation/widgets/home_owner_header_card.dart
/// Generated Documentation for home_owner_header_card.dart

import 'package:flutter/material.dart';

/// Class representing `HomeOwnerHeaderCard`.
/// Auto-generated class documentation.
class HomeOwnerHeaderCard extends StatelessWidget {
  final String name;
  final String role;
  final int unreadCount;
  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapProfile;

  const HomeOwnerHeaderCard({
    super.key,
    required this.name,
    required this.role,
    required this.unreadCount,
    this.onTapNotifications,
    this.onTapProfile,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    const blue = Color(0xFF1C5AA6);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 10),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _HeaderIdentity(name: name, role: role),
          ),
          const SizedBox(width: 12),
          // _IconChip(
          //   icon: Icons.notifications_none_rounded,
          //   badge: unreadCount > 0 ? unreadCount : null,
          //   onTap: onTapNotifications,
          // ),
          // const SizedBox(width: 10),
          _IconChip(icon: Icons.person_outline_rounded, onTap: onTapProfile),
        ],
      ),
    );
  }
}

/// Class representing `_HeaderIdentity`.
/// Auto-generated class documentation.
class _HeaderIdentity extends StatelessWidget {
  final String name;
  final String role;

  const _HeaderIdentity({required this.name, required this.role});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          role,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xDFFFFFFF),
          ),
        ),
      ],
    );
  }
}

/// Class representing `_IconChip`.
/// Auto-generated class documentation.
class _IconChip extends StatelessWidget {
  final IconData icon;
  final int? badge;
  final VoidCallback? onTap;

  const _IconChip({required this.icon, this.badge, this.onTap});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 44,
          height: 44,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(child: Icon(icon, color: const Color(0xFF1C5AA6))),
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
                        fontWeight: FontWeight.w700,
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
