import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/crew_member.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../controllers/crew_detail_controller.dart';

class CrewDetailPage extends StatefulWidget {
  final CrewMember member;
  final CrewDetailController controller;

  const CrewDetailPage({
    super.key,
    required this.member,
    required this.controller,
  });

  @override
  State<CrewDetailPage> createState() => _CrewDetailPageState();
}

class _CrewDetailPageState extends State<CrewDetailPage> {
  late final ScrollController _scrollController;
  CrewDetailController get c => widget.controller;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      c.init(widget.member.userId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      c.loadMore();
    }
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
              onRefresh: () => c.refresh(widget.member.userId),
              color: const Color(0xFF1C85E8),
              child: c.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF1C85E8),
                      ),
                    )
                  : c.errorMessage != null
                      ? _buildErrorView()
                      : SingleChildScrollView(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 1. Top profile card layout
                              _TopProfileCard(
                                onBack: () => Navigator.of(context).maybePop(),
                                avatar: _buildAvatarProvider(c.detail?.userPhoto ?? widget.member.userPhoto),
                                name: c.displayName.isNotEmpty ? c.displayName : widget.member.userName,
                                role: c.displayRole.isNotEmpty ? c.displayRole : widget.member.roleName,
                                statusText: c.displayEmploymentStatus,
                              ),
                              const SizedBox(height: 14),

                              // 2. Personal Section Card
                              _SectionCard(
                                title: 'Personal',
                                children: [
                                  _kv('ID Pegawai', c.displayEmployeeId),
                                  _kv('Email', c.displayEmail.isNotEmpty ? c.displayEmail : widget.member.userEmail),
                                  _kv('Telepon', c.displayPhone),
                                  _kv('Tanggal Lahir', c.displayBirthDate),
                                  _kv('Mulai Bekerja', c.displayStartWorkDate),
                                ],
                              ),
                              const SizedBox(height: 14),

                              // 3. Pekerjaan Section Card
                              _SectionCard(
                                title: 'Pekerjaan',
                                children: [
                                  _kv('Divisi', c.displayDivision),
                                  _kv('Posisi', c.displayPosition),
                                  _kv('Lokasi', c.displayLocation.isNotEmpty ? c.displayLocation : widget.member.officeName),
                                ],
                              ),
                              const SizedBox(height: 18),

                              // 4. Statistics Row (Hadir, Telat, Cuti, Lembur)
                              Row(
                                children: [
                                  _buildStatCard('Hadir', c.presentCount),
                                  const SizedBox(width: 8),
                                  _buildStatCard('Telat', c.lateCount),
                                  const SizedBox(width: 8),
                                  _buildStatCard('Cuti', c.leaveCount),
                                  const SizedBox(width: 8),
                                  _buildStatCard('Lembur', c.overtimeCount),
                                ],
                              ),
                              const SizedBox(height: 24),

                              // 5. Riwayat Kehadiran Header
                              const Text(
                                'Riwayat Kehadiran',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // 6. Paginated History list
                              if (c.displayedHistory.isEmpty)
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 40),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Tidak ada riwayat kehadiran.',
                                    style: TextStyle(
                                      color: Color(0xFF64748B),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              else ...[
                                ...c.displayedHistory.map((h) => _buildHistoryCard(h)),
                                if (c.isLoadingMore)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 16),
                                    child: Center(
                                      child: SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: Color(0xFF1C85E8),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
            ),
          ),
        );
      },
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
              c.errorMessage ?? 'Gagal memuat detail crew.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => c.init(widget.member.userId),
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

  Widget _buildStatCard(String title, int count) {
    final isAlertLeave = title == 'Cuti' && count >= 16;
    final valueColor = isAlertLeave ? const Color(0xFFEF4444) : const Color(0xFF0F172A);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF94A3B8),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              count.toString(),
              style: TextStyle(
                color: valueColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(Attendance h) {
    final statusLower = (h.status ?? '').toLowerCase().trim();
    Color statusColor;
    if (statusLower == 'tepat waktu' || statusLower == 'hadir') {
      statusColor = const Color(0xFF22C55E); // Green
    } else if (statusLower == 'telat') {
      statusColor = const Color(0xFFFACC15); // Yellow
    } else if (statusLower == 'cuti') {
      statusColor = const Color(0xFF3B82F6); // Blue
    } else if (statusLower == 'tidak hadir') {
      statusColor = const Color(0xFFEF4444); // Red
    } else if (statusLower == 'lembur') {
      statusColor = const Color(0xFFF97316); // Orange
    } else {
      statusColor = const Color(0xFF64748B); // Fallback gray
    }
    final overtimeHours = _getOvertimeHours(h);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDateIndonesian(h.attendanceDate),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    h.displayStatus,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Check In : ${h.checkInAt != null ? _formatTimeOnly(h.checkInAt) : '-'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Check Out : ${h.checkOutAt != null ? _formatTimeOnly(h.checkOutAt) : '-'}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          if (overtimeHours > 0) ...[
            const SizedBox(height: 6),
            Text(
              'Lembur : $overtimeHours jam',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C85E8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  int _getOvertimeHours(Attendance a) {
    if (a.overtime != null) return a.overtime!;
    if (a.checkInAt == null || a.checkOutAt == null) return 0;
    final diff = a.checkOutAt!.difference(a.checkInAt!);
    final hours = diff.inHours;
    return hours > 8 ? hours - 8 : 0;
  }

  ImageProvider? _buildAvatarProvider(String? userPhoto) {
    if (userPhoto == null || userPhoto.trim().isEmpty) return null;
    final s = userPhoto.trim();

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

  String _formatDateIndonesian(DateTime? dt) {
    if (dt == null) return '-';
    final wibDt = dt.toUtc().add(const Duration(hours: 7));
    const days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli',
      'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final dayIndex = wibDt.weekday - 1;
    final monthIndex = wibDt.month - 1;
    final dayName = (dayIndex >= 0 && dayIndex < days.length) ? days[dayIndex] : '';
    final monthName = (monthIndex >= 0 && monthIndex < months.length) ? months[monthIndex] : '';
    return '$dayName, ${wibDt.day} $monthName ${wibDt.year}';
  }

  String _formatTimeOnly(DateTime? dt) {
    if (dt == null) return '--:--';
    final wibDt = dt.toUtc().add(const Duration(hours: 7));
    return DateFormat('HH:mm').format(wibDt);
  }
}

class _TopProfileCard extends StatelessWidget {
  final VoidCallback onBack;
  final ImageProvider? avatar;
  final String name;
  final String role;
  final String statusText;

  const _TopProfileCard({
    required this.onBack,
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
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: _BackButton(onPressed: onBack),
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
    return Material(
      color: const Color(0xFF0C5AA6),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: const SizedBox(
          height: 38,
          width: 38,
          child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
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
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 8),
            color: Colors.black.withValues(alpha: 0.06),
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
