/// File: lib/features/home/data/models/home_attendance_response.dart
/// Generated Documentation for home_attendance_response.dart

/// Class representing `HomeAttendanceResponse`.
/// Auto-generated class documentation.
class HomeAttendanceResponse {
  final int present;
  final int late;
  final int leave;
  final int overtime;
  final int outOfOffice;

  HomeAttendanceResponse({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
    required this.outOfOffice,
  });

  factory HomeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('present') || json.containsKey('late')) {
      return HomeAttendanceResponse(
        present: (json['present'] as num?)?.toInt() ?? 0,
        late: (json['late'] as num?)?.toInt() ?? 0,
        leave: (json['leave'] as num?)?.toInt() ?? 0,
        overtime: (json['overtime'] as num?)?.toInt() ?? 0,
        outOfOffice: (json['outOfOffice'] as num?)?.toInt() ?? (json['out_of_office'] as num?)?.toInt() ?? 0,
      );
    }

    final history = json['crewAttendanceHistory'];
    int presentCount = 0;
    int lateCount = 0;
    int leaveCount = 0;
    int overtimeCount = 0;
    int outOfOfficeCount = 0;

    if (history is Map<String, dynamic>) {
      final now = DateTime.now();
      final currentYear = now.year;

      // 1. Calculate approved leave count
      final leaves = history['leaves'] ?? history['leave'];
      if (leaves is List) {
        for (final l in leaves) {
          if (l is Map<String, dynamic>) {
            final rawDate = l['leave_start'] ?? l['start_date'] ?? l['startDate'] ?? l['leave_date'] ?? l['leaveDate'] ?? l['date'];
            if (rawDate is String) {
              final parsed = DateTime.tryParse(rawDate);
              if (parsed != null && parsed.toLocal().year == currentYear) {
                final statusStr = (l['status'] ?? l['leave_status'] ?? l['leaveStatus'] ?? '').toString().toLowerCase().trim();
                if (statusStr == 'approved' || statusStr == 'diterima') {
                  leaveCount++;
                }
              }
            }
          }
        }
      }

      // 2. Calculate approved outOfOffice count and leave count from history list
      final historyList = history['history'];
      if (historyList is List) {
        for (final h in historyList) {
          if (h is Map<String, dynamic>) {
            final typeStr = (h['type'] ?? '').toString().trim().toLowerCase();
            if (typeStr == 'out_of_office') {
              final dateStr = h['date'] ?? h['details']?['out_of_office_start'] ?? h['details']?['outofoffice_start'] ?? h['details']?['out_of_office_date'] ?? h['details']?['outofoffice_date'];
              if (dateStr is String) {
                final parsed = DateTime.tryParse(dateStr);
                if (parsed != null && parsed.toLocal().year == currentYear) {
                  final statusStr = (h['status'] ?? '').toString().toLowerCase().trim();
                  if (statusStr == 'approved' || statusStr == 'diterima') {
                    outOfOfficeCount++;
                  }
                }
              }
            } else if (typeStr == 'leave' && leaveCount == 0) {
              final dateStr = h['date'] ?? h['details']?['leave_start'] ?? h['details']?['start_date'] ?? h['details']?['leave_date'];
              if (dateStr is String) {
                final parsed = DateTime.tryParse(dateStr);
                if (parsed != null && parsed.toLocal().year == currentYear) {
                  final statusStr = (h['status'] ?? '').toString().toLowerCase().trim();
                  if (statusStr == 'approved' || statusStr == 'diterima') {
                    leaveCount++;
                  }
                }
              }
            }
          }
        }
      }

      // 3. Fallback or use server counts for present, late, overtime
      final tAtt = history['total_attendance'] ?? history['totalAttendance'];
      final tLate = history['total_late'] ?? history['totalLate'];
      final tOvertime = history['total_overtime'] ?? history['totalOvertime'];

      if (tAtt != null || tLate != null || tOvertime != null) {
        presentCount = (tAtt as num?)?.toInt() ?? 0;
        lateCount = (tLate as num?)?.toInt() ?? 0;
        overtimeCount = (tOvertime as num?)?.toInt() ?? 0;
      } else {
        final attendances = history['attendances'];
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
    }

    return HomeAttendanceResponse(
      present: presentCount + outOfOfficeCount,
      late: lateCount,
      leave: leaveCount,
      overtime: overtimeCount,
      outOfOffice: outOfOfficeCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'late': late,
      'leave': leave,
      'overtime': overtime,
      'outOfOffice': outOfOffice,
    };
  }
}
