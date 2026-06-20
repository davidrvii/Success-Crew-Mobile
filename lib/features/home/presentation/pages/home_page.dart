/// File: lib/features/home/presentation/pages/home_page.dart
/// Generated Documentation for home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/home/presentation/widgets/app_error_view.dart';
import '../../../../core/widgets/home_shimmer_view.dart';

import '../controllers/home_controller.dart';
import '../widgets/home_owner_header_card.dart';
import '../widgets/home_staff_header_card.dart';

/// Class representing `HomePage`.
/// Auto-generated class documentation.
class HomePage extends StatefulWidget {
  final HomeController controller;

  final bool disposeController;

  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapProfile;

  final VoidCallback? onTapCheckIn;
  final VoidCallback? onTapLeave;
  final VoidCallback? onTapOutOfOffice;
  final VoidCallback? onTapOvertime;

  const HomePage({
    super.key,
    required this.controller,
    this.disposeController = false,
    this.onTapNotifications,
    this.onTapProfile,
    this.onTapCheckIn,
    this.onTapLeave,
    this.onTapOutOfOffice,
    this.onTapOvertime,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Class representing `_HomePageState`.
/// Auto-generated class documentation.
class _HomePageState extends State<HomePage> {
  /// Getter for `c` returning `HomeController`.
  HomeController get c => widget.controller;

  @override
  /// Method `initState` returning `void`.
  /// Handles logic operations related to `initState`.
  void initState() {
    super.initState();
    c.addListener(_onControllerChanged);

    c.init();
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    c.removeListener(_onControllerChanged);
    if (widget.disposeController) {
      c.dispose();
    }
    super.dispose();
  }

  /// Method `_onControllerChanged` returning `void`.
  /// Handles logic operations related to `_onControllerChanged`.
  void _onControllerChanged() {
    if (!mounted) return;
    setState(() {});
  }

  /// Method `_buildHeaderCard` returning `Widget`.
  /// Handles logic operations related to `_buildHeaderCard`.
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
      todayAbsence: c.todayAbsence,
      onTapNotifications: widget.onTapNotifications,
      onTapCheckIn: widget.onTapCheckIn ?? () => context.go('/absence'),
      onTapProfile: widget.onTapProfile,
    );
  }

  /// Method `_buildVisitorCharts` returning `List<Widget>`.
  /// Handles logic operations related to `_buildVisitorCharts`.
  List<Widget> _buildVisitorCharts() {
    final weeklyCount = c.visitStats?.weeklyCount ?? [];
    final xLabelsWeekly = weeklyCount.map((e) => _formatDateAbbr(e.date)).toList();
    final yValuesWeekly = weeklyCount.map((e) => e.totalVisit.toDouble()).toList();

    final rushHour = c.visitStats?.rushHour ?? [];
    final xLabelsRush = rushHour.map((e) => e.hour.replaceAll(':', '.')).toList();
    final yValuesRush = rushHour.map((e) => e.totalVisit.toDouble()).toList();

    final productSold = c.visitStats?.productSoldWeekly ?? [];
    final xLabelsProduct = productSold.map((e) => _formatDateAbbr(e.date)).toList();
    final yValuesProduct = productSold.map((e) => e.totalProductSold.toDouble()).toList();

    final unitService = c.visitStats?.unitServiceWeekly ?? [];
    final xLabelsService = unitService.map((e) => _formatDateAbbr(e.date)).toList();
    final yValuesService = unitService.map((e) => e.totalUnitService.toDouble()).toList();

    return [
      _ChartCard(
        title: 'Pengunjung Harian',
        xLabels: xLabelsWeekly,
        yValues: yValuesWeekly,
        lineColor: const Color(0xFF1E88FF),
        gradientColors: [
          const Color(0xFF1E88FF).withValues(alpha: 0.15),
          const Color(0xFF1E88FF).withValues(alpha: 0.0),
        ],
      ),
      const SizedBox(height: 24),

      _ChartCard(
        title: 'Jam Sibuk',
        xLabels: xLabelsRush,
        yValues: yValuesRush,
        lineColor: const Color(0xFF9A7BFF),
        gradientColors: [
          const Color(0xFF9A7BFF).withValues(alpha: 0.15),
          const Color(0xFF9A7BFF).withValues(alpha: 0.0),
        ],
      ),
      const SizedBox(height: 24),

      _ChartCard(
        title: 'Produk Terjual',
        xLabels: xLabelsProduct,
        yValues: yValuesProduct,
        lineColor: const Color(0xFFEF4444),
        gradientColors: [
          const Color(0xFFEF4444).withValues(alpha: 0.15),
          const Color(0xFFEF4444).withValues(alpha: 0.0),
        ],
      ),
      const SizedBox(height: 24),

      _ChartCard(
        title: 'Unit Service',
        xLabels: xLabelsService,
        yValues: yValuesService,
        lineColor: const Color(0xFFF97316),
        gradientColors: [
          const Color(0xFFF97316).withValues(alpha: 0.15),
          const Color(0xFFF97316).withValues(alpha: 0.0),
        ],
      ),
    ];
  }

  /// Method `_buildOwnerContent` returning `List<Widget>`.
  /// Handles logic operations related to `_buildOwnerContent`.
  List<Widget> _buildOwnerContent() {
    return [
      const _SectionTitle('Kinerja Minggu Ini'),
      const SizedBox(height: 12),
      _OwnerSummaryGrid(
        visitorsToday: c.visitorsToday,
        walkIn: c.walkInToday,
        callIn: c.callInToday,
        chatIn: c.chatInToday,
        totalServices: c.totalServicesThisWeek,
        totalProducts: c.totalProductsSoldThisWeek,
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
          const SizedBox(width: 8),
          Expanded(
            child: _RequestPill(
              title: 'Dinas',
              count: c.pendingOutOfOffice,
              background: const Color(0xFFF97316), // Orange
              onTap: widget.onTapOutOfOffice,
            ),
          ),
          const SizedBox(width: 8),
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

      ..._buildVisitorCharts(),
    ];
  }

  /// Method `_buildStaffContent` returning `List<Widget>`.
  /// Handles logic operations related to `_buildStaffContent`.
  List<Widget> _buildStaffContent() {
    return [
      const _SectionTitle('Kinerja Minggu Ini'),
      const SizedBox(height: 12),
      _OwnerSummaryGrid(
        visitorsToday: c.visitorsToday,
        walkIn: c.walkInToday,
        callIn: c.callInToday,
        chatIn: c.chatInToday,
        totalServices: c.totalServicesThisWeek,
        totalProducts: c.totalProductsSoldThisWeek,
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
          const SizedBox(width: 8),
          Expanded(
            child: _RequestPill(
              title: 'Dinas',
              count: c.pendingOutOfOffice,
              background: const Color(0xFFF97316), // Orange
              onTap: widget.onTapOutOfOffice,
            ),
          ),
          const SizedBox(width: 8),
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

      const _SectionTitle('Kehadiran Crew'),
      const SizedBox(height: 12),
      _OwnerAttendanceCard(
        present: c.present,
        late: c.late,
        leave: c.leave,
        overtime: c.overtime,
        outOfOffice: c.outOfOffice,
      ),
      const SizedBox(height: 24),

      ..._buildVisitorCharts(),
    ];
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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



/// Class representing `_SectionTitle`.
/// Auto-generated class documentation.
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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

/// Class representing `_OwnerSummaryGrid`.
/// Auto-generated class documentation.
class _OwnerSummaryGrid extends StatelessWidget {
  final int visitorsToday;
  final int walkIn;
  final int callIn;
  final int chatIn;
  final int totalServices;
  final int totalProducts;

  const _OwnerSummaryGrid({
    required this.visitorsToday,
    required this.walkIn,
    required this.callIn,
    required this.chatIn,
    required this.totalServices,
    required this.totalProducts,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: _OwnerGridCard(
                  title: 'Pengunjung\n',
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
                  icon: Icons.directions_walk_rounded,
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
                  icon: Icons.call_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OwnerGridCard(
                  title: 'Chat-In\n',
                  value: chatIn.toString(),
                  color: const Color(0xFF9A7BFF), // Purple
                  icon: Icons.chat_rounded,
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
                  title: 'Unit Service\n',
                  value: totalServices.toString(),
                  color: const Color(0xFFF97316), // Orange
                  icon: Icons.build_rounded,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OwnerGridCard(
                  title: 'Produk Terjual\n',
                  value: totalProducts.toString(),
                  color: const Color(0xFFEF4444), // Red
                  icon: Icons.shopping_bag_rounded,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Class representing `_OwnerGridCard`.
/// Auto-generated class documentation.
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
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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

/// Class representing `_OwnerAttendanceCard`.
/// Auto-generated class documentation.
class _OwnerAttendanceCard extends StatelessWidget {
  final int present;
  final int late;
  final int leave;
  final int overtime;
  final int outOfOffice;

  const _OwnerAttendanceCard({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
    required this.outOfOffice,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Row 1: Displays core presence counters (Hadir, Telat, Lembur)
        Row(
          children: [
            _buildStatCard('Hadir', present),
            const SizedBox(width: 8),
            _buildStatCard('Telat', late),
            const SizedBox(width: 8),
            _buildStatCard('Lembur', overtime),
          ],
        ),
        const SizedBox(height: 8),
        // Row 2: Displays auxiliary attendance types (Dinas, Cuti) with alignment spacer
        Row(
          children: [
            const Expanded(flex: 1, child: SizedBox()),
            const SizedBox(width: 8),
            _buildStatCard('Dinas', outOfOffice, flex: 2),
            const SizedBox(width: 8),
            _buildStatCard('Cuti', leave, flex: 2),
            const SizedBox(width: 8),
            const Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ],
    );
  }

  /// Method `_buildStatCard` returning `Widget`.
  /// Handles logic operations related to `_buildStatCard`.
  Widget _buildStatCard(String title, int count, {int flex = 1}) {
    final isAlertLeave = title == 'Cuti' && count >= 16;
    final valueColor = isAlertLeave ? const Color(0xFFEF4444) : const Color(0xFF0F172A);

    return Expanded(
      flex: flex,
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
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
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
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Class representing `_RequestPill`.
/// Auto-generated class documentation.
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
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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

/// Method `_formatDateAbbr` returning `String`.
/// Handles logic operations related to `_formatDateAbbr`.
String _formatDateAbbr(String dateStr) {
  try {
    final parts = dateStr.split('-');
    if (parts.length == 3) {
      final day = int.parse(parts[2]).toString();
      final monthIndex = int.parse(parts[1]);
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
        'Jul', 'Agt', 'Sep', 'Okt', 'Nov', 'Des'
      ];
      if (monthIndex >= 1 && monthIndex <= 12) {
        return '$day ${months[monthIndex]}';
      }
    }
  } catch (_) {}
  return dateStr;
}

/// Class representing `_ChartCard`.
/// Auto-generated class documentation.
class _ChartCard extends StatelessWidget {
  final String title;
  final List<String> xLabels;
  final List<double> yValues;
  final Color lineColor;
  final List<Color> gradientColors;

  const _ChartCard({
    required this.title,
    required this.xLabels,
    required this.yValues,
    required this.lineColor,
    required this.gradientColors,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.06),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineChartPainter(
                xLabels: xLabels,
                yValues: yValues,
                lineColor: lineColor,
                gradientColors: gradientColors,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Class representing `_LineChartPainter`.
/// Auto-generated class documentation.
class _LineChartPainter extends CustomPainter {
  final List<String> xLabels;
  final List<double> yValues;
  final Color lineColor;
  final List<Color> gradientColors;

  _LineChartPainter({
    required this.xLabels,
    required this.yValues,
    required this.lineColor,
    required this.gradientColors,
  });

  @override
  /// Method `paint` returning `void`.
  /// Handles logic operations related to `paint`.
  void paint(Canvas canvas, Size size) {
    const double leftMargin = 32;
    const double bottomMargin = 24;
    const double topMargin = 10;
    const double rightMargin = 16;

    final double chartWidth = size.width - leftMargin - rightMargin;
    final double chartHeight = size.height - topMargin - bottomMargin;

    final gridPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    if (yValues.isEmpty) {
      const int gridLinesCount = 4;
      for (int i = 0; i <= gridLinesCount; i++) {
        final double y = topMargin + chartHeight * (1 - i / gridLinesCount);
        canvas.drawLine(Offset(leftMargin, y), Offset(size.width - rightMargin, y), gridPaint);
      }
      textPainter.text = const TextSpan(
        text: 'Tidak ada data',
        style: TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(
          leftMargin + (chartWidth - textPainter.width) / 2,
          topMargin + (chartHeight - textPainter.height) / 2,
        ),
      );
      return;
    }

    double maxVal = yValues.reduce((a, b) => a > b ? a : b);
    if (maxVal == 0) maxVal = 5;

    final double yMax = ((maxVal / 5).ceil() * 5).toDouble();

    const int gridLinesCount = 4;
    for (int i = 0; i <= gridLinesCount; i++) {
      final double y = topMargin + chartHeight * (1 - i / gridLinesCount);
      canvas.drawLine(Offset(leftMargin, y), Offset(size.width - rightMargin, y), gridPaint);

      final int labelValue = (yMax * (i / gridLinesCount)).round();
      textPainter.text = TextSpan(
        text: labelValue.toString(),
        style: const TextStyle(
          color: Color(0xFF94A3B8),
          fontSize: 9,
          fontWeight: FontWeight.w600,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(leftMargin - textPainter.width - 6, y - textPainter.height / 2),
      );
    }

    final int pointsCount = yValues.length;
    final double stepX = pointsCount > 1 ? chartWidth / (pointsCount - 1) : chartWidth;

    final List<Offset> points = [];
    for (int i = 0; i < pointsCount; i++) {
      final double x = leftMargin + i * stepX;
      final double normalizedY = yValues[i] / yMax;
      final double y = topMargin + chartHeight * (1 - normalizedY);
      points.add(Offset(x, y));

      if (i < xLabels.length) {
        textPainter.text = TextSpan(
          text: xLabels[i],
          style: const TextStyle(
            color: Color(0xFF94A3B8),
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, size.height - bottomMargin + 6),
        );
      }
    }

    if (points.isNotEmpty) {
      final fillPath = Path()
        ..moveTo(leftMargin, topMargin + chartHeight)
        ..lineTo(points.first.dx, points.first.dy);

      for (int i = 1; i < points.length; i++) {
        fillPath.lineTo(points[i].dx, points[i].dy);
      }
      fillPath.lineTo(points.last.dx, topMargin + chartHeight);
      fillPath.close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: gradientColors,
        ).createShader(
          Rect.fromLTRB(leftMargin, topMargin, size.width - rightMargin, topMargin + chartHeight),
        );
      canvas.drawPath(fillPath, fillPaint);

      final linePath = Path()..moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        linePath.lineTo(points[i].dx, points[i].dy);
      }

      final linePaint = Paint()
        ..color = lineColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(linePath, linePaint);

      final dotPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      final borderPaint = Paint()
        ..color = lineColor
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke;

      for (final pt in points) {
        canvas.drawCircle(pt, 4, dotPaint);
        canvas.drawCircle(pt, 4, borderPaint);
      }
    }
  }

  @override
  /// Method `shouldRepaint` returning `bool`.
  /// Handles logic operations related to `shouldRepaint`.
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ============================================================================
// STAFF WIDGETS
// ============================================================================



/// Class representing `_InlineWarning`.
/// Auto-generated class documentation.
class _InlineWarning extends StatelessWidget {
  final String text;
  const _InlineWarning({required this.text});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
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
