import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  // Date & Time

  /// Format: 29 Dec 2025
  static String dateShort(DateTime date, {String locale = 'en_US'}) {
    return DateFormat('dd MMM yyyy', locale).format(date);
  }

  /// Format: 29 December 2025
  static String dateLong(DateTime date, {String locale = 'en_US'}) {
    return DateFormat('dd MMMM yyyy', locale).format(date);
  }

  /// Format: 29 Dec 2025, 14:30
  static String dateTimeShort(DateTime date, {String locale = 'en_US'}) {
    return DateFormat('dd MMM yyyy, HH:mm', locale).format(date);
  }

  /// Format: 14:30
  static String time24h(DateTime date, {String locale = 'en_US'}) {
    return DateFormat('HH:mm', locale).format(date);
  }

  /// Safe parse ISO string -> DateTime?
  static DateTime? tryParseDate(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  // Currency & Number

  /// Format: Rp 1.250.000
  static String idr(
    num value, {
    int decimalDigits = 0,
    String locale = 'id_ID',
  }) {
    final fmt = NumberFormat.currency(
      locale: locale,
      symbol: 'Rp ',
      decimalDigits: decimalDigits,
    );
    return fmt.format(value);
  }

  /// Format number with grouping separators
  static String number(
    num value, {
    String pattern = '#,##0',
    String locale = 'id_ID',
  }) {
    return NumberFormat(pattern, locale).format(value);
  }

  // Text helpers

  static String capitalize(String input) {
    final s = input.trim();
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  /// "hello world" -> "Hello World"
  static String titleCase(String input) {
    final words = input.trim().split(RegExp(r'\s+'));
    return words
        .where((w) => w.isNotEmpty)
        .map((w) => w[0].toUpperCase() + w.substring(1).toLowerCase())
        .join(' ');
  }

  /// Get initials from name: "John Doe" -> "JD"
  static String initials(String input, {int maxLetters = 2}) {
    final parts = input
        .trim()
        .split(RegExp(r'\s+'))
        .where((p) => p.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '';
    final letters = parts.map((p) => p[0].toUpperCase()).toList();
    return letters.take(maxLetters).join();
  }

  /// Mask phone: 081234567890 -> 0812****7890
  static String maskPhone(String input, {int showStart = 4, int showEnd = 4}) {
    final s = input.replaceAll(RegExp(r'\s+'), '');
    if (s.length <= showStart + showEnd) return s;
    final start = s.substring(0, showStart);
    final end = s.substring(s.length - showEnd);
    return '$start****$end';
  }

  // Relative time (simple)

  /// Returns: "just now", "5m ago", "2h ago", "3d ago"
  static String relativeTime(DateTime date, {DateTime? now}) {
    final base = now ?? DateTime.now();
    final diff = base.difference(date);

    if (diff.inSeconds < 10) return 'just now';
    if (diff.inMinutes < 1) return '${diff.inSeconds}s ago';
    if (diff.inHours < 1) return '${diff.inMinutes}m ago';
    if (diff.inDays < 1) return '${diff.inHours}h ago';
    if (diff.inDays < 30) return '${diff.inDays}d ago';

    // fallback to date
    return dateShort(date);
  }
}
