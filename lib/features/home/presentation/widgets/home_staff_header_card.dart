/// File: lib/features/home/presentation/widgets/home_staff_header_card.dart
/// Generated Documentation for home_staff_header_card.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/home_attendance_summary.dart';
import '../../../../core/widgets/hold_to_action_button.dart';

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
  final bool isLoading;

  const HomeStaffHeaderCard({
    super.key,
    required this.name,
    required this.role,
    required this.unreadCount,
    this.todayAbsence,
    this.onTapNotifications,
    this.onTapCheckIn,
    this.onTapProfile,
    this.isLoading = false,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    // Retrieve today's attendance details passed from the parent widget
    final today = todayAbsence;
    final bool hasCheckedIn = today != null && today.hasCheckedIn;
    final bool hasCheckedOut = today is HomeTodayAbsenceCheckedIn && today.hasCheckedOut;

    // Determine the check-in and check-out display strings and opacities
    String checkInStr = 'Check In';
    bool hasCheckIn = false;
    String checkOutStr = 'Check Out';
    bool hasCheckOut = false;

    if (today is HomeTodayAbsenceCheckedIn) {
      final checkInTime = today.checkInAt;
      final checkOutTime = today.checkOutAt;
      if (checkInTime != null) {
        checkInStr = DateFormat('HH.mm').format(checkInTime.toLocal());
        hasCheckIn = true;
      }
      if (checkOutTime != null) {
        checkOutStr = DateFormat('HH.mm').format(checkOutTime.toLocal());
        hasCheckOut = true;
      }
    }

    // Determine action text, button color, and clickability depending on status:
    // 1. Not checked in: 'Check In', Red, Clickable.
    // 2. Checked in: 'Check Out', Green, Clickable.
    // 3. Checked out: 'Selesai', Grey, Clickable disabled (unclickable).
    Color btnColor = const Color(0xFFEF4444); // Red initially
    bool isClickable = true;

    if (hasCheckedIn) {
      if (hasCheckedOut) {
        btnColor = const Color(0xFF94A3B8); // Grey
        isClickable = false;
      } else {
        btnColor = const Color(0xFF22C55E); // Green
      }
    }

    if (isLoading) {
      isClickable = false;
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ─── Rounded Rectangle 2: Bottom Card (biru muda, dibelakang) ───
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF4D88CD),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                blurRadius: 18,
                offset: const Offset(0, 10),
                color: Colors.black.withValues(alpha: 0.08),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Spacer to push content below the overlapping top card
              const SizedBox(height: 84),
              // Bottom content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                child: Row(
                  children: [
                    // Check In Time / Placeholder
                    Text(
                      checkInStr,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: hasCheckIn ? 1.0 : 0.5),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Divider Line
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      height: 24,
                      width: 1.2,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    // Check Out Time / Placeholder
                    Expanded(
                      child: Text(
                        checkOutStr,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: hasCheckOut ? 1.0 : 0.5),
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Absen Fingerprint Button (rounded rectangle, pressed 3s)
                    IgnorePointer(
                      ignoring: !isClickable || isLoading,
                      child: HoldToActionButton(
                        onTap: onTapCheckIn ?? () {},
                        child: Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: btnColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: btnColor.withValues(alpha: 0.4),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: isLoading
                              ? const Center(
                                  child: SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                )
                              : const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                  size: 32,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // ─── Rounded Rectangle 1: Top Card (biru tema, didepan) ───
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            decoration: BoxDecoration(
              color: const Color(0xFF135CAE),
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
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
                _IconChip(
                  icon: Icons.person_outline_rounded,
                  onTap: onTapProfile,
                ),
              ],
            ),
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
