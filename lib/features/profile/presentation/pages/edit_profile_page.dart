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
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Edit Profil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final c = widget.controller;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (c.errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.red.shade50,
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
                      padding: const EdgeInsets.symmetric(vertical: 16),
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
          );
        },
      ),
    );
  }
}
