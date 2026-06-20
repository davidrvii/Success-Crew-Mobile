/// File: lib/features/attendance/presentation/pages/attendance_page.dart
/// Generated Documentation for attendance_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/attendance_controller.dart';
import '../../domain/entities/attendance.dart';
import '../../../../core/widgets/hold_to_action_button.dart';

/// Class representing `AttendancePage`.
/// Auto-generated class documentation.
class AttendancePage extends StatefulWidget {
  final AttendanceController controller;

  const AttendancePage({super.key, required this.controller});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

/// Class representing `_AttendancePageState`.
/// Auto-generated class documentation.
class _AttendancePageState extends State<AttendancePage> {
  /// Getter for `c` returning `AttendanceController`.
  AttendanceController get c => widget.controller;
  late final ScrollController _scrollController;

  @override
  /// Method `initState` returning `void`.
  /// Handles logic operations related to `initState`.
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.init();
    });
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Method `_onScroll` returning `void`.
  /// Handles logic operations related to `_onScroll`.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      c.loadMore();
    }
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        final a = c.attendance;

        final canCheckIn = !c.isLoading && (a == null || !a.hasCheckedIn);
        final canCheckOut =
            !c.isLoading && (a != null && a.hasCheckedIn && !a.hasCheckedOut);

        final isRed = a == null || (!a.hasCheckedIn && !a.hasCheckedOut);
        final isGreen = a != null && a.hasCheckedIn && !a.hasCheckedOut;
        final isGrey = a != null && a.hasCheckedIn && a.hasCheckedOut;

        final gradientColors = isRed
            ? [const Color(0xFFEF4444), const Color(0xFFDC2626)]
            : isGreen
                ? [const Color(0xFF22C55E), const Color(0xFF10B981)]
                : [const Color(0xFF94A3B8), const Color(0xFF64748B)];

        final shadowColor = isRed
            ? const Color(0xFFEF4444)
            : isGreen
                ? const Color(0xFF22C55E)
                : const Color(0xFF94A3B8);

        return Scaffold(
          backgroundColor: const Color(0xFFFAFBFF),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: c.refresh,
              color: const Color(0xFF22C55E),
              child: ListView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  // 1. Top Bar / User Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(
                        color: Colors.black.withValues(alpha: 0.06),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          c.userName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          c.roleName,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),


                  // 2. Large Dynamic Card (Action card with fingerprint button)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor.withValues(alpha: 0.25),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Fingerprint button area
                        IgnorePointer(
                          ignoring: isGrey,
                          child: HoldToActionButton(
                            onTap: () async {
                              final messenger = ScaffoldMessenger.of(context);
                              if (canCheckIn) {
                                await c.checkIn();
                                if (c.errorMessage != null) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(c.errorMessage!),
                                      backgroundColor: const Color(0xFFEF4444),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              } else if (canCheckOut) {
                                if (DateTime.now().hour < 17) {
                                  messenger.showSnackBar(
                                    const SnackBar(
                                      content: Text("Tidak dapat check out sebelum jam pulang"),
                                      backgroundColor: Color(0xFFEF4444),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }
                                await c.checkOut();
                                if (c.errorMessage != null) {
                                  messenger.showSnackBar(
                                    SnackBar(
                                      content: Text(c.errorMessage!),
                                      backgroundColor: const Color(0xFFEF4444),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withValues(alpha: 0.08),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withValues(alpha: 0.18),
                                  ),
                                  alignment: Alignment.center,
                                  child: c.isLoading
                                      ? const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.fingerprint,
                                          color: Colors.white,
                                          size: 54,
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Check in / Check out times row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  _buildTimeText(a?.checkInAt),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Check In',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: a?.checkInAt == null ? 0.50 : 0.85),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 1.5,
                              height: 42,
                              color: Colors.white.withValues(alpha: 0.40),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  _buildTimeText(a?.checkOutAt),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Check Out',
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: a?.checkOutAt == null ? 0.50 : 0.85),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // 3. 2-row layout of statistics cards
                  Column(
                    children: [
                      Row(
                        children: [
                          _buildStatCard('Hadir', c.presentCount),
                          const SizedBox(width: 8),
                          _buildStatCard('Telat', c.lateCount),
                          const SizedBox(width: 8),
                          _buildStatCard('Lembur', c.overtimeCount),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Expanded(flex: 1, child: SizedBox()),
                          const SizedBox(width: 8),
                          _buildStatCard('Dinas', c.outOfOfficeCount, flex: 2),
                          const SizedBox(width: 8),
                          _buildStatCard('Cuti', c.leaveCount, flex: 2),
                          const SizedBox(width: 8),
                          const Expanded(flex: 1, child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 4. Riwayat Kehadiran Header
                  const Text(
                    'Riwayat Kehadiran',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 5. History items
                  if (c.history.isEmpty && !c.isLoading)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      child: const Text(
                        'Tidak ada riwayat kehadiran.',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else ...[
                    ...c.history.map((h) => _buildHistoryCard(h)),
                    if (c.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Color(0xFF22C55E),
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Method `_buildStatCard` returning `Widget`.
  /// Handles logic operations related to `_buildStatCard`.
  Widget _buildStatCard(String title, int count, {int flex = 1}) {
    final isAlertLeave = title == 'Cuti' && count >= 16;
    final valueColor = isAlertLeave ? const Color(0xFFEF4444) : const Color(0xFF0F172A);

    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.06),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              count.toString(),
              style: TextStyle(
                color: valueColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Method `_buildHistoryCard` returning `Widget`.
  /// Handles logic operations related to `_buildHistoryCard`.
  Widget _buildHistoryCard(Attendance h) {
    // Determine status color based on presence details
    final statusLower = (h.status ?? '').toLowerCase().trim();
    Color statusColor;
    if (statusLower == 'tepat waktu' || statusLower == 'hadir') {
      statusColor = const Color(0xFF1C85E8); // Biru (hadir)
    } else if (statusLower == 'telat') {
      statusColor = const Color(0xFFFACC15); // Kuning (telat)
    } else if (statusLower == 'lembur') {
      statusColor = const Color(0xFF22C55E); // Hijau (lembur)
    } else if (statusLower == 'dinas') {
      statusColor = const Color(0xFFF97316); // Orange (dinas)
    } else if (statusLower == 'cuti') {
      statusColor = const Color(0xFFEF4444); // Merah (cuti)
    } else if (statusLower == 'tidak hadir') {
      statusColor = const Color(0xFFEF4444); // Merah (tidak hadir)
    } else {
      statusColor = const Color(0xFF64748B); // Fallback gray
    }
    final overtimeHours = _getOvertimeHours(h);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDateIndonesian(h.attendanceDate),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    h.displayStatus,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Check In : ${h.checkInAt != null ? _formatTimeOnly(h.checkInAt) : '-'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Check Out : ${h.checkOutAt != null ? _formatTimeOnly(h.checkOutAt) : '-'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          if (overtimeHours > 0) ...[
            const SizedBox(height: 6),
            Text(
              'Lembur : $overtimeHours jam',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C85E8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Method `_getOvertimeHours` returning `int`.
  /// Handles logic operations related to `_getOvertimeHours`.
  int _getOvertimeHours(Attendance a) {
    if (a.overtime != null) return a.overtime!;
    if (a.checkInAt == null || a.checkOutAt == null) return 0;
    final diff = a.checkOutAt!.difference(a.checkInAt!);
    final hours = diff.inHours;
    return hours > 8 ? hours - 8 : 0;
  }
}

/// Method `_formatDateIndonesian` returning `String`.
/// Handles logic operations related to `_formatDateIndonesian`.
String _formatDateIndonesian(DateTime? dt) {
  if (dt == null) return '-';
  final wibDt = dt.toUtc().add(const Duration(hours: 7));
  const days = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];
  final dayIndex = wibDt.weekday - 1;
  final monthIndex = wibDt.month - 1;
  
  // Guard checks for index safety
  final dayName = (dayIndex >= 0 && dayIndex < days.length) ? days[dayIndex] : '';
  final monthName = (monthIndex >= 0 && monthIndex < months.length) ? months[monthIndex] : '';

  return '$dayName, ${wibDt.day} $monthName ${wibDt.year}';
}

/// Method `_formatTimeOnly` returning `String`.
/// Handles logic operations related to `_formatTimeOnly`.
String _formatTimeOnly(DateTime? dt) {
  if (dt == null) return '--:--';
  final wibDt = dt.toUtc().add(const Duration(hours: 7));
  return DateFormat('HH:mm').format(wibDt);
}

/// Method `_buildTimeText` returning `Widget`.
/// Handles logic operations related to `_buildTimeText`.
Widget _buildTimeText(DateTime? dt) {
  if (dt == null) {
    return Text(
      '-',
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.5),
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }
  final wibDt = dt.toUtc().add(const Duration(hours: 7));
  return Text(
    DateFormat('HH:mm:ss').format(wibDt),
    style: const TextStyle(
      color: Colors.white,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
  );
}
