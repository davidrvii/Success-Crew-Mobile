class HomeAttendanceResponse {
  final int present;
  final int late;
  final int leave;
  final int overtime;

  HomeAttendanceResponse({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
  });

  factory HomeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('present') || json.containsKey('late')) {
      return HomeAttendanceResponse(
        present: (json['present'] as num?)?.toInt() ?? 0,
        late: (json['late'] as num?)?.toInt() ?? 0,
        leave: (json['leave'] as num?)?.toInt() ?? 0,
        overtime: (json['overtime'] as num?)?.toInt() ?? 0,
      );
    }

    final history = json['crewAttendanceHistory'];
    int presentCount = 0;
    int lateCount = 0;
    int leaveCount = 0;
    int overtimeCount = 0;

    if (history is Map<String, dynamic>) {
      final attendances = history['attendances'];
      final now = DateTime.now();
      final currentYear = now.year;

      // Calculate leave count
      final leaves = history['leaves'];
      if (leaves is List) {
        for (final l in leaves) {
          if (l is Map<String, dynamic>) {
            final rawDate = l['leave_date'] ?? l['leaveDate'] ?? l['date'];
            if (rawDate is String) {
              final parsed = DateTime.tryParse(rawDate);
              if (parsed != null && parsed.toLocal().year == currentYear) {
                leaveCount++;
              }
            }
          }
        }
      }

      // Calculate attendance counts
      if (attendances is List) {
        for (final a in attendances) {
          if (a is Map<String, dynamic>) {
            final dateStr = a['attendance_date'] ?? a['attendanceDate'] ?? a['date'];
            if (dateStr is String) {
              final date = DateTime.tryParse(dateStr);
              if (date != null && date.toLocal().year == currentYear) {
                final checkInStr = a['attendance_in'] ?? a['checkIn'] ?? a['checkInAt'];
                final statusStr = (a['attendance_status'] ?? a['status'] ?? '').toString().toLowerCase().trim();

                final hasCheckIn = checkInStr != null && checkInStr.toString().isNotEmpty;

                if (hasCheckIn && statusStr != 'tidak hadir') {
                  presentCount++;
                }

                if (statusStr == 'telat') {
                  lateCount++;
                }

                // Overtime calculation
                final overtimes = a['overtimes'];
                int itemOvertimeHours = 0;
                if (overtimes is List) {
                  for (final o in overtimes) {
                    if (o is Map<String, dynamic>) {
                      final startStr = o['overtime_start'] ?? o['overtimeStart'];
                      final endStr = o['overtime_end'] ?? o['overtimeEnd'];
                      if (startStr is String && endStr is String) {
                        final start = DateTime.tryParse(startStr);
                        final end = DateTime.tryParse(endStr);
                        if (start != null && end != null) {
                          itemOvertimeHours += end.difference(start).inHours;
                        }
                      }
                    }
                  }
                }

                // Fallback to checkOut - checkIn minus 8 hours if no explicit overtime entries
                if (itemOvertimeHours == 0 && hasCheckIn) {
                  final checkOutStr = a['attendance_out'] ?? a['checkOut'] ?? a['checkOutAt'];
                  if (checkOutStr != null && checkOutStr.toString().isNotEmpty) {
                    final inDt = DateTime.tryParse(checkInStr);
                    final outDt = DateTime.tryParse(checkOutStr.toString());
                    if (inDt != null && outDt != null) {
                      final diff = outDt.difference(inDt).inHours;
                      if (diff > 8) {
                        itemOvertimeHours = diff - 8;
                      }
                    }
                  }
                }

                if (itemOvertimeHours > 0) {
                  overtimeCount += itemOvertimeHours;
                }
              }
            }
          }
        }
      }
    }

    return HomeAttendanceResponse(
      present: presentCount,
      late: lateCount,
      leave: leaveCount,
      overtime: overtimeCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'late': late,
      'leave': leave,
      'overtime': overtime,
    };
  }
}
