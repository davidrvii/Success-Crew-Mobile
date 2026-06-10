import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileController controller;

  const EditProfilePage({super.key, required this.controller});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(context, 'Ubah Profil'),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  final c = widget.controller;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (c.errorMessage != null) ...[
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  c.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            // Info
                            const Padding(
                              padding: EdgeInsets.only(bottom: 16.0),
                              child: Text(
                                'Ubah data profil Anda di bawah ini. Kosongkan kolom password jika tidak ingin mengubahnya.',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ),

                            // Form Fields
                            TextFormField(
                              controller: c.nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),
                            
                            TextFormField(
                              controller: c.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Email wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),
                            
                            TextFormField(
                              controller: c.passwordController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                labelText: 'Password Baru (Opsional)',
                                border: OutlineInputBorder(),
                              ),
                              // Optional, no validator required unless they start typing
                            ),
                            
                            const SizedBox(height: 32),
                            
                            ElevatedButton(
                              onPressed: c.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        final success = await c.submitUpdate();
                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Profil berhasil diperbarui')),
                                          );
                                          context.pop();
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1C5AA6),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: c.isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                      'Simpan Perubahan',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C5AA6), // Brand blue
        borderRadius: BorderRadius.circular(28), // Rounded rectangle shape
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 12,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () => Navigator.maybePop(context),
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
