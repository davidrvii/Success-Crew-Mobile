import 'package:flutter/material.dart';

import '../../../../features/home/presentation/widgets/app_error_view.dart';
import '../../../../features/home/presentation/widgets/app_loading_view.dart';

import '../controllers/home_controller.dart';
import '../widgets/home_owner_header_card.dart';
import '../widgets/home_staff_header_card.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;

  final bool disposeController;

  final VoidCallback? onTapNotifications;
  final VoidCallback? onTapProfile;

  final VoidCallback? onTapCheckIn;

  const HomePage({
    super.key,
    required this.controller,
    this.disposeController = false,
    this.onTapNotifications,
    this.onTapProfile,
    this.onTapCheckIn,
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

  Widget _buildHeaderCard({
    required String name,
    required String role,
    required int unreadCount,
    VoidCallback? onTapNotifications,
    VoidCallback? onTapProfile,
    VoidCallback? onTapCheckIn,
  }) {
    final roleLower = role.trim().toLowerCase();
    final isOwner = roleLower == 'owner';

    if (isOwner) {
      return HomeOwnerHeaderCard(
        name: name,
        role: role,
        unreadCount: unreadCount,
        onTapNotifications: onTapNotifications,
        onTapProfile: onTapProfile,
      );
    }

    return HomeStaffHeaderCard(
      name: name,
      role: role,
      unreadCount: unreadCount,
      onTapNotifications: onTapNotifications,
      onTapCheckIn: onTapCheckIn,
    );
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
        body: SafeArea(child: AppLoadingView(message: 'Loading home data...')),
      );
    }

    return Scaffold(
      backgroundColor: bg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: c.refresh,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _TopBrand(),
                      const SizedBox(height: 14),

                      _buildHeaderCard(
                        name: c.userName,
                        role: c.roleName,
                        unreadCount: c.unreadNotif,
                        onTapNotifications: widget.onTapNotifications,
                        onTapProfile: widget.onTapProfile,
                        onTapCheckIn:
                            widget.onTapCheckIn ??
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'TODO: Arahkan ke Absence/Check-in',
                                  ),
                                ),
                              );
                            },
                      ),
                      const SizedBox(height: 18),

                      const _SectionTitle('Ringkasan Bisnis'),
                      const SizedBox(height: 12),
                      _BusinessSummaryGrid(
                        visitorsToday: c.visitorsToday,
                        walkIn: null,
                        callIn: null,
                        chatIn: null,
                      ),
                      const SizedBox(height: 18),

                      const _SectionTitle('Kehadiran Karyawan'),
                      const SizedBox(height: 12),
                      _AttendanceCard(
                        present: c.present,
                        late: c.late,
                        leave: c.leave,
                        overtime: c.overtime,
                      ),
                      const SizedBox(height: 18),

                      const _SectionTitle('Pengajuan'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _RequestPill(
                              title: 'Cuti',
                              count: c.pendingLeave,
                              background: const Color(0xFFF04444),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _RequestPill(
                              title: 'Lembur',
                              count: c.pendingOvertime,
                              background: const Color(0xFF1DB954),
                            ),
                          ),
                        ],
                      ),

                      if (c.hasData && c.hasError) ...[
                        const SizedBox(height: 14),
                        _InlineWarning(
                          text: c.errorMessage ?? 'Gagal memperbarui data.',
                        ),
                      ],

                      const SizedBox(height: 24),
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

class _TopBrand extends StatelessWidget {
  const _TopBrand();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Success Comp',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1C5AA6),
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
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: Color(0xFF0F172A),
      ),
    );
  }
}

class _BusinessSummaryGrid extends StatelessWidget {
  final int visitorsToday;
  final int? walkIn;
  final int? callIn;
  final int? chatIn;

  const _BusinessSummaryGrid({
    required this.visitorsToday,
    this.walkIn,
    this.callIn,
    this.chatIn,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.25,
      children: [
        _StatCard(
          title: 'Pengunjung\nHari Ini',
          value: visitorsToday.toString(),
          background: const Color(0xFF1E88FF),
          icon: Icons.group_outlined,
        ),
        _StatCard(
          title: 'Walk-In',
          value: (walkIn ?? 0).toString(),
          background: const Color(0xFF2ED3A2),
          icon: Icons.schedule_rounded,
          valueHint: walkIn == null ? 'TODO' : null,
        ),
        _StatCard(
          title: 'Call-In',
          value: (callIn ?? 0).toString(),
          background: const Color(0xFF5B5FEA),
          icon: Icons.info_outline_rounded,
          valueHint: callIn == null ? 'TODO' : null,
        ),
        _StatCard(
          title: 'Chat-In',
          value: (chatIn ?? 0).toString(),
          background: const Color(0xFF9A7BFF),
          icon: Icons.check_circle_outline_rounded,
          valueHint: chatIn == null ? 'TODO' : null,
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color background;
  final IconData icon;
  final String? valueHint;

  const _StatCard({
    required this.title,
    required this.value,
    required this.background,
    required this.icon,
    this.valueHint,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 10),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.22),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Icon(icon, color: Colors.white),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                  if (valueHint != null) ...[
                    const SizedBox(width: 8),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        valueHint!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.85),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttendanceCard extends StatelessWidget {
  final int present;
  final int late;
  final int leave;
  final int overtime;

  const _AttendanceCard({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
  });

  @override
  Widget build(BuildContext context) {
    const purple = Color(0xFF5B5FEA);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      decoration: BoxDecoration(
        color: purple,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 10),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Row(
        children: [
          _AttendanceItem(label: 'Present', value: present),
          _VLine(),
          _AttendanceItem(label: 'Late', value: late),
          _VLine(),
          _AttendanceItem(label: 'Leave', value: leave),
          _VLine(),
          _AttendanceItem(label: 'Overtime', value: overtime),
        ],
      ),
    );
  }
}

class _AttendanceItem extends StatelessWidget {
  final String label;
  final int value;

  const _AttendanceItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xDFFFFFFF),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _VLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 44,
      // ignore: deprecated_member_use
      color: Colors.white.withOpacity(0.30),
    );
  }
}

class _RequestPill extends StatelessWidget {
  final String title;
  final int count;
  final Color background;

  const _RequestPill({
    required this.title,
    required this.count,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 10),
            color: Color(0x1F000000),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            count.toString(),
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _InlineWarning extends StatelessWidget {
  final String text;
  const _InlineWarning({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF4D6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFD37A)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
