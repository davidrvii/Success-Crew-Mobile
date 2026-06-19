class DateOverlapHelper {
  /// Normalizes a DateTime to just the date components (year, month, day) in local time.
  static DateTime normalize(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Checks if a target date is within a range [start, end] inclusive (ignoring hours/minutes/seconds).
  static bool isDateInRange(DateTime date, DateTime start, DateTime end) {
    final d = normalize(date);
    final s = normalize(start);
    final e = normalize(end);
    return (d.isAfter(s) || d.isAtSameMomentAs(s)) &&
           (d.isBefore(e) || d.isAtSameMomentAs(e));
  }

  /// Checks if two date ranges [start1, end1] and [start2, end2] overlap (ignoring hours/minutes/seconds).
  static bool areRangesOverlapping(DateTime start1, DateTime end1, DateTime start2, DateTime end2) {
    final s1 = normalize(start1);
    final e1 = normalize(end1);
    final s2 = normalize(start2);
    final e2 = normalize(end2);
    return (s1.isBefore(e2) || s1.isAtSameMomentAs(e2)) &&
           (e1.isAfter(s2) || e1.isAtSameMomentAs(s2));
  }
}
