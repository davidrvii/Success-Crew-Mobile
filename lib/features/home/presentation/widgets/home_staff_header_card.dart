/// File: lib/features/home/presentation/widgets/home_staff_header_card.dart
/// Generated Documentation for home_staff_header_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/home_attendance_summary.dart';

/// Class representing `HomeStaffHeaderCard`.
/// Auto-generated class documentation.
class HomeStaffHeaderCard extends StatelessWidget {
  final String name;
  final String role;
  final int unreadCount;
  final HomeTodayAbsence? todayAbsence;
  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapCheckIn;
  final VoidCallback? onTapProfile;

  const HomeStaffHeaderCard({
    super.key,
    required this.name,
    required this.role,
    required this.unreadCount,
    this.todayAbsence,
    this.onTapNotifications,
    this.onTapCheckIn,
    this.onTapProfile,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    // Retrieve today's attendance details passed from the parent widget
    final today = todayAbsence;
    final bool hasCheckedIn = today != null && today.hasCheckedIn;
    final bool hasCheckedOut = today is HomeTodayAbsenceCheckedIn && today.hasCheckedOut;

    // Determine the formatted time to display:
    // - Displays check-out time if checked out.
    // - Displays check-in time if checked in.
    // - Defaults to '--.--' if not checked in yet.
    String timeStr = '--.--';
    if (today is HomeTodayAbsenceCheckedIn) {
      final checkInTime = today.checkInAt;
      final checkOutTime = today.checkOutAt;
      if (hasCheckedOut && checkOutTime != null) {
        timeStr = DateFormat('HH.mm').format(checkOutTime.toLocal());
      } else if (checkInTime != null) {
        timeStr = DateFormat('HH.mm').format(checkInTime.toLocal());
      }
    }

    // Determine action text, button color, and clickability depending on status:
    // 1. Not checked in: 'Check In', Red, Clickable.
    // 2. Checked in: 'Check Out', Green, Clickable.
    // 3. Checked out: 'Selesai', Grey, Clickable disabled (unclickable).
    String statusText = 'Check In';
    Color btnColor = const Color(0xFFEF4444); // Red initially
    bool isClickable = true;

    if (hasCheckedIn) {
      if (hasCheckedOut) {
        statusText = 'Selesai';
        btnColor = const Color(0xFF94A3B8); // Grey
        isClickable = false;
      } else {
        statusText = 'Check Out';
        btnColor = const Color(0xFF22C55E); // Green
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // Clips the child Containers' corners inside the rounded border
      child: Column(
        children: [
          // ─── Top Portion (Dark Blue Header) ───
          // Displays user info and utility action chips (Notifications, Profile)
          Container(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            color: const Color(0xFF135CAE),
            child: Row(
              children: [
                Expanded(
                  child: Column(
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
                      const SizedBox(height: 4),
                      Text(
                        role,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFE2E8F0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                // _IconChip(
                //   icon: Icons.notifications_none_rounded,
                //   badge: unreadCount > 0 ? unreadCount : null,
                //   onTap: onTapNotifications,
                // ),
                // const SizedBox(width: 8),
                _IconChip(
                  icon: Icons.person_outline_rounded,
                  onTap: onTapProfile,
                ),
              ],
            ),
          ),
          // ─── Bottom Portion (Medium/Light Blue Status Bar) ───
          // Displays check-in/out times, check-in status, and the fingerprint trigger button
          Material(
            color: const Color(0xFF4D88CD),
            child: InkWell(
              onTap: isClickable ? onTapCheckIn : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  children: [
                    // Attendance Action Time
                    Text(
                      timeStr,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    // Divider Line
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 36,
                      width: 1.2,
                      color: Colors.white.withOpacity(0.5),
                    ),
                    // Action / Status Text
                    Expanded(
                      child: Text(
                        statusText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Fingerprint Button
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: btnColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: btnColor.withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Center(child: Icon(icon, color: const Color(0xFF1C5AA6), size: 22)),
              if (badge != null)
                Positioned(
                  right: -4,
                  top: -4,
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
