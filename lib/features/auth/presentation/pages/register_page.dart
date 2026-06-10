import 'package:flutter/material.dart';

import '../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  final RegisterController controller;

  final bool disposeController;

  final void Function()? onRegisterSuccess;

  const RegisterPage({
    super.key,
    required this.controller,
    this.disposeController = false,
    this.onRegisterSuccess,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController get c => widget.controller;

  final _nameC = TextEditingController();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();

  int? _officeId;
  int? _roleId;

  static const _offices = <_Option>[
    _Option(id: 1, label: 'Cibubur'),
    _Option(id: 2, label: 'Bogor'),
  ];

  static const _roles = <_Option>[
    _Option(id: 1, label: 'Owner'),
    _Option(id: 2, label: 'Manager'),
    _Option(id: 3, label: 'Teknisi'),
    _Option(id: 4, label: 'Sales'),
    _Option(id: 5, label: 'Admin Service'),
    _Option(id: 6, label: 'Kasir'),
    _Option(id: 7, label: 'Driver'),
  ];

  @override
  void initState() {
    super.initState();
    c.addListener(_onChanged);

    _nameC.addListener(c.clearError);
    _emailC.addListener(c.clearError);
    _passC.addListener(c.clearError);
  }

  @override
  void dispose() {
    _nameC.dispose();
    _emailC.dispose();
    _passC.dispose();

    c.removeListener(_onChanged);
    if (widget.disposeController) c.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _submit() async {
    final ok = await c.register(
      name: _nameC.text,
      email: _emailC.text,
      password: _passC.text,
      officeId: _officeId,
      roleId: _roleId,
    );

    if (!mounted) return;

    if (ok) {
      widget.onRegisterSuccess?.call();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(c.errorMessage ?? 'Registrasi gagal.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7FB);
    const blue = Color(0xFF1C5AA6);

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 18),
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
                    'New Crew',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 14),

                  _Label('Name'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: _nameC,
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(color: Colors.black87),
                    decoration: _fieldDecoration(hint: 'Name'),
                  ),

                  const SizedBox(height: 12),
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
                    textInputAction: TextInputAction.next,
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

                  const SizedBox(height: 12),
                  _Label('Office'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    initialValue: _officeId,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    items: _offices
                        .map(
                          (o) => DropdownMenuItem<int>(
                            value: o.id,
                            child: Text(o.label, style: const TextStyle(color: Colors.black87)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      setState(() => _officeId = v);
                      c.clearError();
                    },
                    decoration: _dropdownDecoration(hint: 'Office'),
                    icon: const Icon(Icons.expand_more_rounded),
                  ),

                  const SizedBox(height: 12),
                  _Label('Role'),
                  const SizedBox(height: 6),
                  DropdownButtonFormField<int>(
                    initialValue: _roleId,
                    style: const TextStyle(color: Colors.black87, fontSize: 16),
                    items: _roles
                        .map(
                          (r) => DropdownMenuItem<int>(
                            value: r.id,
                            child: Text(r.label, style: const TextStyle(color: Colors.black87)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      setState(() => _roleId = v);
                      c.clearError();
                    },
                    decoration: _dropdownDecoration(hint: 'Role'),
                    icon: const Icon(Icons.expand_more_rounded),
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
                      foregroundColor: Colors.black,
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
                            'Regist',
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                  ),
                ],
              ),
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

  InputDecoration _dropdownDecoration({required String hint}) {
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
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
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

class _Option {
  final int id;
  final String label;
  const _Option({required this.id, required this.label});
}
