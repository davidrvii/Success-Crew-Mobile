import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/user_detail.dart';
import '../controllers/profile_controller.dart';

class EditProfilePage extends StatefulWidget {
  final UserDetail detail;
  final ProfileController controller;

  const EditProfilePage({
    super.key,
    required this.detail,
    required this.controller,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  DateTime? _selectedBirthDate;

  @override
  void initState() {
    super.initState();
    final d = widget.detail;
    _nameController = TextEditingController(text: d.userName);
    _emailController = TextEditingController(text: d.userEmail);
    _phoneController = TextEditingController(text: d.userPhone ?? '');
    _selectedBirthDate = d.userBirth;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(BuildContext context, ProfileController c) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      c.setSelectedPhoto(File(picked.path));
    }
  }

  ImageProvider? _buildAvatarProvider(ProfileController c) {
    if (c.selectedPhoto != null) return FileImage(c.selectedPhoto!);
    final userPhoto = c.detail?.userPhoto;
    if (userPhoto == null || userPhoto.trim().isEmpty) return null;

    final s = userPhoto.trim();

    // URL
    if (s.startsWith('http://') || s.startsWith('https://')) {
      return NetworkImage(s);
    }

    // data uri base64
    if (s.startsWith('data:image')) {
      final idx = s.indexOf('base64,');
      if (idx != -1) {
        final b64 = s.substring(idx + 'base64,'.length);
        try {
          return MemoryImage(base64Decode(b64));
        } catch (_) {}
      }
    }

    // raw base64
    final base64Like =
        RegExp(r'^[A-Za-z0-9+/=\s]+$').hasMatch(s) && s.length > 80;
    if (base64Like) {
      try {
        return MemoryImage(base64Decode(s));
      } catch (_) {}
    }

    // kemungkinan "[1,2,3]"
    if (s.startsWith('[') && s.endsWith(']')) {
      try {
        final parsed = jsonDecode(s);
        if (parsed is List) {
          final bytes = Uint8List.fromList(
            parsed.whereType<num>().map((e) => e.toInt()).toList(),
          );
          if (bytes.isNotEmpty) return MemoryImage(bytes);
        }
      } catch (_) {}
    }

    return null;
  }

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

                            // Photo Picker
                            Center(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 54,
                                    backgroundColor: const Color(0xFFE5E6EA),
                                    backgroundImage: _buildAvatarProvider(c),
                                    child: _buildAvatarProvider(c) == null
                                        ? const Icon(Icons.person, size: 44, color: Color(0xFF9AA0A6))
                                        : null,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: GestureDetector(
                                      onTap: () => _pickImage(context, c),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF1C5AA6),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),


                            // Form Fields
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),
                            
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Email wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Telepon',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Telepon wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Tanggal Lahir (DatePicker)
                            InkWell(
                              onTap: () async {
                                final now = DateTime.now();
                                final picked = await showDatePicker(
                                  context: context,
                                  initialDate: _selectedBirthDate ?? DateTime(1995, 1, 1),
                                  firstDate: DateTime(1950),
                                  lastDate: now,
                                );
                                if (picked != null) {
                                  setState(() {
                                    _selectedBirthDate = picked;
                                  });
                                }
                              },
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Tanggal Lahir',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today_rounded),
                                ),
                                child: Text(
                                  _selectedBirthDate != null
                                      ? DateFormat('dd MMM yyyy').format(_selectedBirthDate!)
                                      : 'Pilih Tanggal Lahir',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedBirthDate != null ? Colors.black : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 32),
                            
                            ElevatedButton(
                              onPressed: c.isLoading
                                  ? null
                                  : () async {
                                      if (_formKey.currentState!.validate()) {
                                        c.nameController.text = _nameController.text;
                                        c.emailController.text = _emailController.text;
                                        c.phoneController.text = _phoneController.text;
                                        c.birthDate = _selectedBirthDate;

                                        final success = await c.submitUpdate();
                                        if (success && context.mounted) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Profil berhasil diperbarui')),
                                          );
                                          context.pop(true);
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
