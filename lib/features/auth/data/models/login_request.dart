/// File: lib/features/auth/data/models/login_request.dart
/// Generated Documentation for login_request.dart

/// Class representing `LoginRequest`.
/// Auto-generated class documentation.
class LoginRequest {
  final String email;
  final String password;

  const LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}
