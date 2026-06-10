import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/home/presentation/widgets/app_error_view.dart';
import '../../../../core/widgets/home_shimmer_view.dart';

import '../controllers/home_controller.dart';
import '../widgets/home_owner_header_card.dart';
import '../widgets/home_staff_header_card.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  final bool disposeController;

  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapProfile;

  final VoidCallback? onTapCheckIn;
  final VoidCallback? onTapLeave;
  final VoidCallback? onTapOvertime;

  const HomePage({
    super.key,
    required this.controller,
    this.disposeController = false,
    this.onTapNotifications,
    this.onTapProfile,
    this.onTapCheckIn,
    this.onTapLeave,
    this.onTapOvertime,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get c => widget.controller;

  @override
  void initState() {
    super.initState();
    c.addListener(_onControllerChanged);

    c.init();
  }

  @override
  void dispose() {
    c.removeListener(_onControllerChanged);
    if (widget.disposeController) {
      c.dispose();
    }
    super.dispose();
  }

  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Widget _buildHeaderCard(bool isOwner) {
    if (isOwner) {
      return HomeOwnerHeaderCard(
        name: c.userName,
        role: c.roleName,
        unreadCount: c.unreadNotif,
        onTapNotifications: widget.onTapNotifications,
        onTapProfile: widget.onTapProfile,
      );
    }

    return HomeStaffHeaderCard(
      name: c.userName,
      role: c.roleName,
      unreadCount: c.unreadNotif,
      onTapNotifications: widget.onTapNotifications,
      onTapCheckIn: widget.onTapCheckIn ?? () => context.go('/absence'),
      onTapProfile: widget.onTapProfile,
    );
  }

  List<Widget> _buildOwnerContent() {
    return [
      const _SectionTitle('Ringkasan Pengunjung'),
      const SizedBox(height: 12),
      _OwnerSummaryGrid(
        visitorsToday: c.visitorsToday,
        walkIn: c.walkInToday,
        callIn: c.callInToday,
        chatIn: c.chatInToday,
      ),
      const SizedBox(height: 24),

      const _SectionTitle('Pengajuan'),
      const SizedBox(height: 12),
      Row(
        children: [
          Expanded(
            child: _RequestPill(
              title: 'Cuti',
              count: c.pendingLeave,
              background: const Color(0xFFEF4444), // Red
              onTap: widget.onTapLeave,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _RequestPill(
              title: 'Lembur',
              count: c.pendingOvertime,
              background: const Color(0xFF22C55E), // Green
              onTap: widget.onTapOvertime,
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),

      const _SectionTitle('Pemasukkan'),
      const SizedBox(height: 12),
      const _MockChartCard(),
      const SizedBox(height: 24),

      const _SectionTitle('Rata-rata Penyelesaian'),
      const SizedBox(height: 12),
      const _MockChartCard(),
      const SizedBox(height: 24),

      const _SectionTitle('Jam Datang'),
      const SizedBox(height: 12),
      const _MockChartCard(),
    ];
  }

  List<Widget> _buildStaffContent() {
    return [
      const _SectionTitle('Ringkasan Kinerja'),
      const SizedBox(height: 12),
      _BusinessSummaryGrid(
        visitors: c.visitorsToday,
        approachingDeadline: 16, // Dummy for now
        passedDeadline: 12, // Dummy for now
        complaints: 8, // Dummy for now
      ),
      const SizedBox(height: 24),

      const _SectionTitle('Kehadiran Karyawan'),
      const SizedBox(height: 12),
      _OwnerAttendanceCard(
        present: c.present,
        late: c.late,
        leave: c.leave,
        overtime: c.overtime,
      ),
      const SizedBox(height: 24),

      const _SectionTitle('Service Melewati Batas'),
      const SizedBox(height: 12),
      const _ServiceList(isOverdue: true),

      const SizedBox(height: 24),
      const _SectionTitle('Service Mendekati Batas'),
      const SizedBox(height: 12),
      const _ServiceList(isOverdue: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    const bg = Color(0xFFF6F7FB);

    if (!c.hasData && c.hasError && !c.isLoading) {
      return Scaffold(
        backgroundColor: bg,
        body: SafeArea(
          child: AppErrorView(
            title: 'Gagal memuat Home',
            message: c.errorMessage ?? 'Terjadi kesalahan.',
            onRetry: c.retry,
          ),
        ),
      );
    }

    if (c.isInitialLoading) {
      return const Scaffold(
        backgroundColor: bg,
        body: SafeArea(child: HomeShimmerView()),
      );
    }

    final isOwner = c.roleName.trim().toLowerCase() == 'owner';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE), // Light background
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: c.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderCard(isOwner),
                      const SizedBox(height: 24),

                      // ==========================================
                      // CONDITIONAL RENDERING BASED ON ROLE
                      // ==========================================
                      if (isOwner)
                        ..._buildOwnerContent()
                      else
                        ..._buildStaffContent(),

                      if (c.hasData && c.hasError) ...[
                        const SizedBox(height: 14),
                        _InlineWarning(
                          text: c.errorMessage ?? 'Gagal memperbarui data.',
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
            ],
          ),
        ),
      ),
    );
  }
}



class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0F172A),
      ),
    );
  }
}

// ============================================================================
// OWNER WIDGETS
// ============================================================================

class _OwnerSummaryGrid extends StatelessWidget {
  final int visitorsToday;
  final int walkIn;
  final int callIn;
  final int chatIn;

  const _OwnerSummaryGrid({
    required this.visitorsToday,
    required this.walkIn,
    required this.callIn,
    required this.chatIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OwnerGridCard(
                  title: 'Pengunjung\nHari Ini',
                  value: visitorsToday.toString(),
                  color: const Color(0xFF1E88FF), // Blue
                  icon: Icons.people_alt_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OwnerGridCard(
                  title: 'Walk-In\n',
                  value: walkIn.toString(),
                  color: const Color(0xFF2ED3A2), // Green
                  icon: Icons.schedule_rounded,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OwnerGridCard(
                  title: 'Call-In\n',
                  value: callIn.toString(),
                  color: const Color(0xFF5B5FEA), // Indigo
                  icon: Icons.error_outline_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OwnerGridCard(
                  title: 'Chat-In\n',
                  value: chatIn.toString(),
                  color: const Color(0xFF9A7BFF), // Purple
                  icon: Icons.check_circle_outline_rounded,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OwnerGridCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _OwnerGridCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 22),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OwnerAttendanceCard extends StatelessWidget {
  final int present;
  final int late;
  final int leave;
  final int overtime;

  const _OwnerAttendanceCard({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1), // Indigo
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x336366F1),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _AttItem(label: 'Hadir', value: present),
          _VLine(),
          _AttItem(label: 'Telat', value: late),
          _VLine(),
          _AttItem(label: 'Cuti', value: leave),
          _VLine(),
          _AttItem(label: 'Lembur', value: overtime),
        ],
      ),
    );
  }
}

class _AttItem extends StatelessWidget {
  final String label;
  final int value;

  const _AttItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xDFFFFFFF),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _VLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      color: Colors.white.withValues(alpha: 0.5),
    );
  }
}

class _RequestPill extends StatelessWidget {
  final String title;
  final int count;
  final Color background;
  final VoidCallback? onTap;

  const _RequestPill({
    required this.title,
    required this.count,
    required this.background,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
              Text(
                count.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MockChartCard extends StatelessWidget {
  const _MockChartCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: CustomPaint(
        painter: _ChartPainter(),
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = const Color(0xFF3B82F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final paint2 = Paint()
      ..color = const Color(0xFFF97316)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path1 = Path();
    path1.moveTo(20, size.height - 40);
    path1.lineTo(size.width * 0.3, size.height * 0.4);
    path1.lineTo(size.width * 0.5, size.height * 0.7);
    path1.lineTo(size.width * 0.7, size.height * 0.2);
    path1.lineTo(size.width * 0.9, size.height * 0.6);

    final path2 = Path();
    path2.moveTo(20, size.height - 20);
    path2.lineTo(size.width * 0.4, size.height * 0.3);
    path2.lineTo(size.width * 0.6, size.height * 0.6);
    path2.lineTo(size.width * 0.8, size.height * 0.3);
    path2.lineTo(size.width * 0.9, size.height * 0.5);

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);

    // Draw dots
    final paintDot1 = Paint()..color = const Color(0xFF3B82F6);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.6), 4, paintDot1);

    final paintDot2 = Paint()..color = const Color(0xFFF97316);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.5), 4, paintDot2);
    
    // Axes
    final axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2;
    canvas.drawLine(Offset(20, 20), Offset(20, size.height - 20), axisPaint);
    canvas.drawLine(Offset(20, size.height - 20), Offset(size.width - 20, size.height - 20), axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// STAFF WIDGETS
// ============================================================================

class _BusinessSummaryGrid extends StatelessWidget {
  final int visitors;
  final int approachingDeadline;
  final int passedDeadline;
  final int complaints;

  const _BusinessSummaryGrid({
    required this.visitors,
    required this.approachingDeadline,
    required this.passedDeadline,
    required this.complaints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _GridCard(
                title: 'Pengunjung\nHari Ini',
                value: visitors.toString(),
                color: const Color(0xFF3B82F6), // Blue
                icon: Icons.people_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GridCard(
                title: 'Mendekati\nBatas',
                value: approachingDeadline.toString(),
                color: const Color(0xFFFACC15), // Yellow
                icon: Icons.access_time,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _GridCard(
                title: 'Melewati\nBatas',
                value: passedDeadline.toString(),
                color: const Color(0xFFEF4444), // Red
                icon: Icons.error_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _GridCard(
                title: 'Komplain',
                value: complaints.toString(),
                color: const Color(0xFF6366F1), // Indigo
                icon: Icons.thumb_down_alt_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _GridCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _GridCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  height: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ServiceList extends StatelessWidget {
  final bool isOverdue;

  const _ServiceList({required this.isOverdue});

  @override
  Widget build(BuildContext context) {
    // Dummy UI
    return Column(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Printer - Epson G3730',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Budi Suheru',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Text(
                      'Kerusakan : Tidak Menyala',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const Text(
                      'Status : Diagnosa',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isOverdue ? 'Batas dilewati : ${index + 1} hari' : 'Batas waktu : ${index + 2} hari lagi',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isOverdue ? const Color(0xFFEF4444) : const Color(0xFFFACC15),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _InlineWarning extends StatelessWidget {
  final String text;
  const _InlineWarning({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFFECACA)),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: Color(0xFFDC2626), size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF991B1B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
