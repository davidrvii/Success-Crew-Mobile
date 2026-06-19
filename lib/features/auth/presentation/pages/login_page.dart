/// File: lib/features/auth/presentation/pages/login_page.dart
/// Generated Documentation for login_page.dart

import 'package:flutter/material.dart';

import '../controllers/login_controller.dart';

/// Class representing `LoginPage`.
/// Auto-generated class documentation.
class LoginPage extends StatefulWidget {
  final LoginController controller;

  final bool disposeController;

  final void Function()? onLoginSuccess;

  const LoginPage({
    super.key,
    required this.controller,
    this.disposeController = false,
    this.onLoginSuccess,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// Class representing `_LoginPageState`.
/// Auto-generated class documentation.
class _LoginPageState extends State<LoginPage> {
  /// Getter for `c` returning `LoginController`.
  LoginController get c => widget.controller;

  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  @override
  /// Method `initState` returning `void`.
  /// Handles logic operations related to `initState`.
  void initState() {
    super.initState();
    c.addListener(_onChanged);

    _emailC.addListener(c.clearError);
    _passC.addListener(c.clearError);
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _emailC.dispose();
    _passC.dispose();

    c.removeListener(_onChanged);
    if (widget.disposeController) c.dispose();
    super.dispose();
  }

  /// Method `_onChanged` returning `void`.
  /// Handles logic operations related to `_onChanged`.
  void _onChanged() {
    if (!mounted) return;
    setState(() {});
  }

  /// Method `_submit` returning `Future<void>`.
  /// Handles logic operations related to `_submit`.
  Future<void> _submit() async {
    final ok = await c.login(email: _emailC.text, password: _passC.text);

    if (!mounted) return;

    if (ok) {
      widget.onLoginSuccess?.call();
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(c.errorMessage ?? 'Login gagal.')));
    }
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7FB);
    const blue = Color(0xFF1C5AA6);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            margin: const EdgeInsets.symmetric(horizontal: 22),
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            decoration: BoxDecoration(
              color: blue,
              borderRadius: BorderRadius.circular(22),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 20,
                  offset: Offset(0, 12),
                  color: Color(0x22000000),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Welcome Crew',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),

                _Label('Email'),
                const SizedBox(height: 6),
                TextField(
                  controller: _emailC,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(color: Colors.black87),
                  decoration: _fieldDecoration(hint: 'Email'),
                ),

                const SizedBox(height: 12),
                _Label('Password'),
                const SizedBox(height: 6),
                TextField(
                  controller: _passC,
                  obscureText: c.obscurePassword,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submit(),
                  style: const TextStyle(color: Colors.black87),
                  decoration: _fieldDecoration(
                    hint: 'Password',
                    suffix: IconButton(
                      onPressed: c.toggleObscure,
                      icon: Icon(
                        c.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),
                ),

                if (c.errorMessage != null) ...[
                  const SizedBox(height: 10),
                  Text(
                    c.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFFFE1E1),
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],

                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: c.isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1C5AA6),
                    elevation: 6,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 26,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: c.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black45),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      suffixIcon: suffix,
    );
  }
}

/// Class representing `_Label`.
/// Auto-generated class documentation.
class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 13,
        ),
      ),
    );
  }
}
