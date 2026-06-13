import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../controllers/crew_controller.dart';
import '../../domain/entities/crew_member.dart';

class CrewPage extends StatefulWidget {
  final CrewController controller;

  const CrewPage({super.key, required this.controller});

  @override
  State<CrewPage> createState() => _CrewPageState();
}

class _CrewPageState extends State<CrewPage> {
  CrewController get c => widget.controller;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFF),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: c,
          builder: (context, _) {
            if (c.isLoading && c.crewList.isEmpty) {
              return _buildShimmerGrid();
            }

            if (c.errorMessage != null && c.crewList.isEmpty) {
              return _buildErrorView();
            }

            final filteredList = c.crewList.where((m) {
              final name = m.userName.toLowerCase();
              final role = m.roleName.toLowerCase();
              final office = m.officeName.toLowerCase();
              final q = _searchQuery.toLowerCase();
              return name.contains(q) || role.contains(q) || office.contains(q);
            }).toList();

            return RefreshIndicator(
              onRefresh: c.refresh,
              color: const Color(0xFF1C85E8),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Search Bar Header
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.06),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.015),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              _searchQuery = val;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari karyawan atau posisi...',
                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            prefixIcon: const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF94A3B8),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 14.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  if (filteredList.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          _searchQuery.isEmpty
                              ? 'Tidak ada data karyawan.'
                              : 'Karyawan tidak ditemukan.',
                          style: const TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.all(20.0),
                      sliver: SliverToBoxAdapter(
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: filteredList.map((member) {
                            final cardWidth = (MediaQuery.of(context).size.width - 56) / 2;
                            return SizedBox(
                              width: cardWidth,
                              child: _buildCrewCard(member),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCrewCard(CrewMember m) {
    final avatar = _resolveAvatar(m.userPhoto);
    final String initials = m.userName.trim().isNotEmpty
        ? m.userName.trim().split(' ').map((e) => e[0]).take(2).join().toUpperCase()
        : '?';

    // Generates a unique gradient background index for avatars
    final int colorIndex = m.userId % 5;
    final List<List<Color>> gradients = [
      [const Color(0xFF1E88FF), const Color(0xFF0C5AA6)],
      [const Color(0xFF22C55E), const Color(0xFF10B981)],
      [const Color(0xFFF97316), const Color(0xFFEA580C)],
      [const Color(0xFF6366F1), const Color(0xFF4F46E5)],
      [const Color(0xFFEC4899), const Color(0xFFD946EF)],
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar circle
          CircleAvatar(
            radius: 38,
            backgroundColor: const Color(0xFFF1F5F9),
            backgroundImage: avatar,
            child: avatar == null
                ? Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: gradients[colorIndex],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 12),

          // Name
          Text(
            m.userName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),

          // Role (Posisi) Chip
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _getRoleBgColor(m.roleName),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              m.roleName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: _getRoleTextColor(m.roleName),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Office Location
          Text(
            m.officeName,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleBgColor(String role) {
    final r = role.toLowerCase().trim();
    if (r == 'owner') return const Color(0xFFEEF2FF);
    if (r == 'teknisi') return const Color(0xFFECFDF5);
    if (r == 'sales') return const Color(0xFFFFF7ED);
    return const Color(0xFFF1F5F9);
  }

  Color _getRoleTextColor(String role) {
    final r = role.toLowerCase().trim();
    if (r == 'owner') return const Color(0xFF4F46E5); // Indigo
    if (r == 'teknisi') return const Color(0xFF059669); // Green
    if (r == 'sales') return const Color(0xFFEA580C); // Orange
    return const Color(0xFF475569); // Slate
  }

  ImageProvider? _resolveAvatar(String? photo) {
    if (photo == null || photo.trim().isEmpty) return null;
    final s = photo.trim();

    if (s.startsWith('http://') || s.startsWith('https://')) {
      return NetworkImage(s);
    }

    if (s.startsWith('data:image')) {
      final idx = s.indexOf('base64,');
      if (idx != -1) {
        final b64 = s.substring(idx + 'base64,'.length);
        try {
          return MemoryImage(base64Decode(b64));
        } catch (_) {}
      }
    }

    final base64Like = RegExp(r'^[A-Za-z0-9+/=\s]+$').hasMatch(s) && s.length > 80;
    if (base64Like) {
      try {
        return MemoryImage(base64Decode(s));
      } catch (_) {}
    }

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

  Widget _buildShimmerGrid() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: List.generate(6, (index) {
          final cardWidth = (MediaQuery.of(context).size.width - 56) / 2;
          return SizedBox(
            width: cardWidth,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.black.withValues(alpha: 0.04),
                  width: 1.2,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 38,
                    backgroundColor: Color(0xFFF1F5F9),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 90,
                    height: 14,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 60,
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: 70,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Color(0xFFEF4444),
              size: 48,
            ),
            const SizedBox(height: 14),
            Text(
              c.errorMessage ?? 'Gagal memuat data crew.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: c.load,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Coba Lagi'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1C85E8),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
