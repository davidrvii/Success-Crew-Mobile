class Validators {
  Validators._();

  static String? requiredField(
    String? value, {
    String fieldName = 'This field',
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return '$fieldName is required.';
    return null;
  }

  static String? email(
    String? value, {
    String message = 'Invalid email address.',
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email is required.';
    final regex = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!regex.hasMatch(v)) return message;
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    final v = value ?? '';
    if (v.trim().isEmpty) return '${fieldName ?? "This field"} is required.';
    if (v.length < min) {
      return '${fieldName ?? "This field"} must be at least $min characters.';
    }
    return null;
  }

  static String? maxLength(String? value, int max, {String? fieldName}) {
    final v = value ?? '';
    if (v.length > max) {
      return '${fieldName ?? "This field"} must be at most $max characters.';
    }
    return null;
  }

  /// Password policy (adjustable):
  /// - min 8 chars
  /// - at least 1 uppercase, 1 lowercase, 1 digit (optional strict)
  static String? password(String? value, {int min = 8, bool strict = true}) {
    final v = value ?? '';
    if (v.isEmpty) return 'Password is required.';
    if (v.length < min) return 'Password must be at least $min characters.';

    if (strict) {
      final hasUpper = RegExp(r'[A-Z]').hasMatch(v);
      final hasLower = RegExp(r'[a-z]').hasMatch(v);
      final hasDigit = RegExp(r'\d').hasMatch(v);

      if (!hasUpper || !hasLower || !hasDigit) {
        return 'Password must include uppercase, lowercase, and a number.';
      }
    }
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    final v = value ?? '';
    if (v.isEmpty) return 'Confirm password is required.';
    if (v != original) return 'Passwords do not match.';
    return null;
  }

  static String? numeric(String? value, {String fieldName = 'This field'}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return '$fieldName is required.';
    if (num.tryParse(v) == null) return '$fieldName must be a number.';
    return null;
  }

  /// Indonesia-ish phone validator (simple):
  /// Allows: +62 / 62 / 0 prefix, 9-15 digits total (after normalization)
  static String? phone(
    String? value, {
    String message = 'Invalid phone number.',
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Phone number is required.';

    // normalize
    var s = v.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (s.startsWith('+')) s = s.substring(1);

    // accept 62... or 0...
    if (!(s.startsWith('62') || s.startsWith('0'))) return message;

    // digits only
    if (!RegExp(r'^\d+$').hasMatch(s)) return message;

    // length check
    if (s.length < 9 || s.length > 15) return message;

    return null;
  }

  /// Example for dropdown/spinner: ensure not null/empty and not "Select..."
  static String? selection(
    String? value, {
    String message = 'Please select an option.',
  }) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return message;
    if (v.toLowerCase().contains('select')) return message;
    return null;
  }
}
