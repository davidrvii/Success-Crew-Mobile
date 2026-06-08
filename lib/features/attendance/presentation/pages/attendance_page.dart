import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controllers/attendance_controller.dart';

class AttendancePage extends StatefulWidget {
  final AttendanceController controller;

  const AttendancePage({super.key, required this.controller});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  AttendanceController get c => widget.controller;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        final a = c.attendance;

        final canCheckIn = !c.isLoading && (a == null || !a.hasCheckedIn);
        final canCheckOut =
            !c.isLoading && (a != null && a.hasCheckedIn && !a.hasCheckedOut);

        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: c.refresh,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                children: [
                  _TopBar(
                    title: 'Attendance',
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(height: 14),

                  if (c.errorMessage != null) ...[
                    _ErrorBanner(message: c.errorMessage!),
                    const SizedBox(height: 14),
                  ],

                  _Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hari ini',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0B1B3A),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _kv(
                          'Attendance ID',
                          c.todayAttendanceId?.toString() ?? '-',
                        ),
                        _kv('Tanggal', _formatDate(a?.attendanceDate)),
                        _kv(
                          'Status',
                          a?.displayStatus ??
                              (c.todayAttendanceId == null
                                  ? 'Belum Check In'
                                  : '-'),
                        ),
                        const SizedBox(height: 8),
                        _TimeRow(
                          inText: _formatTime(a?.checkInAt),
                          outText: _formatTime(a?.checkOutAt),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: canCheckIn ? c.checkIn : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0C5AA6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: c.isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Check In',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          height: 54,
                          child: ElevatedButton(
                            onPressed: canCheckOut ? c.checkOut : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF04444),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 0,
                            ),
                            child: c.isLoading
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Check Out',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, height: 1.35),
          children: [
            TextSpan(
              text: '$k : ',
              style: const TextStyle(
                color: Color(0xFF6E7AA8),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: v,
              style: const TextStyle(
                color: Color(0xFF6E7AA8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final VoidCallback onBack;

  const _TopBar({required this.title, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Material(
          color: const Color(0xFF0C5AA6),
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: onBack,
            child: const SizedBox(
              height: 38,
              width: 38,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String? inText;
  final String? outText;

  const _TimeRow({required this.inText, required this.outText});

  @override
  Widget build(BuildContext context) {
    final inVal = (inText == null || inText!.trim().isEmpty)
        ? '-'
        : inText!.trim();
    final outVal = (outText == null || outText!.trim().isEmpty)
        ? '-'
        : outText!.trim();

    return Row(
      children: [
        Expanded(
          child: _TimeChip(label: 'IN', value: inVal),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _TimeChip(label: 'OUT', value: outVal),
        ),
      ],
    );
  }
}

class _TimeChip extends StatelessWidget {
  final String label;
  final String value;

  const _TimeChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3FA),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF0C5AA6),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF0B1B3A),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE1E1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFF8B0000),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

String _formatDate(DateTime? dt) {
  if (dt == null) return '-';
  return DateFormat('dd MMM yyyy').format(dt);
}

String _formatTime(DateTime? dt) {
  if (dt == null) return '-';
  return DateFormat('HH:mm').format(dt);
}
