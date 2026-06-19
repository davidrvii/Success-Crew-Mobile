import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../controllers/profile_controller.dart';

class ProfilePage extends StatefulWidget {
  final ProfileController controller;

  const ProfilePage({super.key, required this.controller});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileController c;

  @override
  void initState() {
    super.initState();
    c = widget.controller;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.init();
    });
  }

  @override
  void dispose() {
    c.disposeControllers();
    super.dispose();
  }

  Future<void> _onLogout() async {
    await c.logout();
    if (!mounted) return;

    // Clear entire navigation stack and go to login
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F6FA),
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: c.refresh,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                children: [
                  _TopProfileCard(
                    onBack: () => Navigator.of(context).maybePop(),
                    onEdit: () async {
                      if (c.detail == null) return;
                      c.setEditing(true); // Populate text controllers
                      final reload = await context.push('/edit-profile', extra: c.detail);
                      if (reload == true && mounted) {
                        c.refresh();
                      }
                    },
                    avatar: _buildAvatarProvider(
                      c.detail?.userPhoto,
                      fallbackFile: c.selectedPhoto,
                    ),
                    name: c.displayName,
                    role: c.displayRole,
                    statusText: c.displayEmploymentStatus,
                  ),
                  const SizedBox(height: 14),

                  if (c.errorMessage != null) ...[
                    _ErrorBanner(message: c.errorMessage!),
                    const SizedBox(height: 14),
                  ],

                  _SectionCard(
                    title: 'Personal',
                    children: [
                      _kv('Email', c.displayEmail),
                      _kv('Telepon', c.displayPhone),
                      _kv('Tanggal Lahir', c.displayBirthDate),
                      _kv('Mulai Bekerja', c.displayStartWorkDate),
                      _kv('Selesai Bekerja', c.displayEndWorkDate),
                    ],
                  ),
                  const SizedBox(height: 14),

                  _SectionCard(
                    title: 'Pekerjaan',
                    children: [
                      _kv('Posisi', c.displayPosition),
                      _kv('Lokasi', c.displayLocation),
                    ],
                  ),
                  const SizedBox(height: 18),

                  _LogoutButton(onPressed: c.isLoading ? null : _onLogout),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, height: 1.35),
          children: [
            TextSpan(
              text: '$k : ',
              style: const TextStyle(
                color: Color(0xFF6E7AA8),
                fontWeight: FontWeight.w700,
              ),
            ),
            TextSpan(
              text: v,
              style: const TextStyle(
                color: Color(0xFF6E7AA8),
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImageProvider? _buildAvatarProvider(String? userPhoto, {File? fallbackFile}) {
    if (fallbackFile != null) return FileImage(fallbackFile);
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
}

class _TopProfileCard extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback onEdit;
  final ImageProvider? avatar;
  final String name;
  final String role;
  final String statusText;

  const _TopProfileCard({
    required this.onBack,
    required this.onEdit,
    required this.avatar,
    required this.name,
    required this.role,
    required this.statusText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _BackButton(onPressed: onBack),
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, color: Color(0xFF0C5AA6)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CircleAvatar(
            radius: 56,
            backgroundColor: const Color(0xFFE5E6EA),
            backgroundImage: avatar,
            child: avatar == null
                ? const Icon(Icons.person, size: 44, color: Color(0xFF9AA0A6))
                : null,
          ),
          const SizedBox(height: 14),
          Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            role,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9AA0A6),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            statusText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9AA0A6),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _BackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF0B5FA5),
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0B1B3A),
            ),
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const _LogoutButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF04444),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Icon(Icons.logout, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;
  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE1E1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFF8B0000),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
