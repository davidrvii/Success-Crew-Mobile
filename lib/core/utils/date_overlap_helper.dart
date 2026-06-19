/// File: lib/core/utils/date_overlap_helper.dart
/// Generated Documentation for date_overlap_helper.dart

/// Helper class to detect overlapping dates or date ranges.
/// Normalizes inputs to midnight local time to prevent hour/minute precision mismatch.
/// Class representing `DateOverlapHelper`.
/// Auto-generated class documentation.
class DateOverlapHelper {
  /// Normalizes a DateTime to midnight (year, month, day) in local time.
  /// This ensures date comparisons are purely date-based, ignoring time components.
  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Checks if a [date] falls within the range of [start] and [end] inclusive.
  /// Normalizes all arguments to ignore time components.
  static bool isDateInRange(DateTime date, DateTime start, DateTime end) {
    final d = normalize(date);
    final s = normalize(start);
    final e = normalize(end);
    return (d.isAfter(s) || d.isAtSameMomentAs(s)) &&
           (d.isBefore(e) || d.isAtSameMomentAs(e));
  }

  /// Checks if two date ranges [start1, end1] and [start2, end2] overlap.
  /// Normalizes all arguments to ignore time components.
  static bool areRangesOverlapping(DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    final s1 = normalize(start1);
    final e1 = normalize(end1);
    final s2 = normalize(start2);
    final e2 = normalize(end2);
    return (s1.isBefore(e2) || s1.isAtSameMomentAs(e2)) &&
           (e1.isAfter(s2) || e1.isAtSameMomentAs(s2));
  }
}
