import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/controllers/visit_controller.dart';
import '../../../../core/widgets/list_shimmer_view.dart';

class VisitorPage extends StatefulWidget {
  const VisitorPage({super.key});

  @override
  State<VisitorPage> createState() => _VisitorPageState();
}

class _VisitorPageState extends State<VisitorPage> {
  late final VisitorController c;

  @override
  void initState() {
    super.initState();
    c = GetIt.instance<VisitorController>();
    c.init();
  }

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F8),

          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await context.push('/visitor-add');
              c.refresh();
            },
            child: const Icon(Icons.add),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Column(
                children: [
                  _HeaderRow(
                    onFilterTap: () => _openFilter(context),
                    activeFilter: c.statusFilter,
                  ),
                  const SizedBox(height: 12),
                  _SearchPill(onChanged: c.setQuery),
                  const SizedBox(height: 12),
                  _SortRow(
                    total: c.totalCount,
                    sortMode: c.sortMode,
                    onToggle: c.toggleSort,
                  ),
                  const SizedBox(height: 12),
                  Expanded(child: _buildContent(context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    if (c.isLoading && c.visible.isEmpty) {
      return const ListShimmerView();
    }

    if (c.errorMessage != null) {
      return _ErrorState(message: c.errorMessage!, onRetry: c.refresh);
    }

    if (c.visible.isEmpty) {
      return _EmptyState(onRefresh: c.refresh);
    }

    return RefreshIndicator(
      onRefresh: c.refresh,
      child: ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: c.visible.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final v = c.visible[index];

          final visitorName = _nonEmpty(v.visitorName);
          final visitorInterest = _nonEmpty(v.visitorInterest);
          final visitType = _nonEmpty(v.visitType);
          final visitorInfo = _nonEmpty(v.visitorInformation);

          final status = _nonEmpty(v.visitorStatus);
          final date = _formatDate(v.createdAt);
          final time = _formatTime(v.createdAt);

          return _VisitorCard(
            title: visitorName,
            interest: visitorInterest,
            type: visitType,
            info: visitorInfo,
            status: status,
            date: date,
            time: time,
            onTap: () {
              context.push('/visit-detail', extra: v.visitId);
            },
          );
        },
      ),
    );
  }

  Future<void> _openFilter(BuildContext context) async {
    final selected = await showModalBottomSheet<String?>(
      context: context,
      showDragHandle: true,
      builder: (_) => _FilterSheet(selected: c.statusFilter),
    );

    if (!mounted) return;
    if (selected == null) return;

    if (selected.isEmpty) {
      c.clearFilter();
    } else {
      c.setStatusFilter(selected);
    }
  }
}

/// ------------------------------
/// UI Widgets
/// ------------------------------

class _HeaderRow extends StatelessWidget {
  final VoidCallback onFilterTap;
  final String? activeFilter;

  const _HeaderRow({required this.onFilterTap, required this.activeFilter});

  @override
  Widget build(BuildContext context) {
    final hasFilter = (activeFilter ?? '').trim().isNotEmpty;

    return Row(
      children: [
        Text(
          'Pengunjung',
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
        ),
        const Spacer(),
        InkWell(
          onTap: onFilterTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).dividerColor),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.tune, size: 18),
                const SizedBox(width: 8),
                Text(hasFilter ? (activeFilter ?? '') : 'Filter'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchPill extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const _SearchPill({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          hintText: 'Cari kunjungan',
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }
}

class _SortRow extends StatelessWidget {
  final int total;
  final VisitorSortMode sortMode;
  final VoidCallback onToggle;

  const _SortRow({
    required this.total,
    required this.sortMode,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isAz = sortMode == VisitorSortMode.az;

    return Row(
      children: [
        Text(
          'Semua ($total)',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
        ),
        const Spacer(),
        TextButton.icon(
          onPressed: onToggle,
          icon: const Icon(Icons.sort_by_alpha),
          label: Text(isAz ? 'Abjad A–Z' : 'Terbaru'),
        ),
      ],
    );
  }
}

class _VisitorCard extends StatelessWidget {
  final String title;
  final String interest;
  final String type;
  final String info;
  final String status;
  final String date;
  final String time;
  final VoidCallback onTap;

  const _VisitorCard({
    required this.title,
    required this.interest,
    required this.type,
    required this.info,
    required this.status,
    required this.date,
    required this.time,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  _miniChip(status),
                ],
              ),
              const SizedBox(height: 10),

              _kv('Keperluan', interest),
              const SizedBox(height: 4),
              _kv('Metode', type),
              const SizedBox(height: 4),
              _kv('Pengunjung', info),

              const SizedBox(height: 10),
              Row(
                children: [
                  _metaPill(Icons.calendar_today_outlined, date),
                  const SizedBox(width: 8),
                  _metaPill(Icons.access_time, time),
                  const Spacer(),
                  const Icon(Icons.chevron_right),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kv(String k, String v) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text('$k :', style: const TextStyle(color: Colors.black54)),
        ),
        Expanded(child: Text(v)),
      ],
    );
  }

  Widget _metaPill(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.black54),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _miniChip(String text) {
    final t = text.trim().toLowerCase();

    final Color bg = (t.contains('follow') || t.contains('proses'))
        ? const Color(0xFF16A34A)
        : (t.contains('batal') || t.contains('cancel')
              ? const Color(0xFFDC2626)
              : (t.contains('selesai') || t.contains('done')
                    ? const Color(0xFF0B5FA5)
                    : const Color(0xFF64748B)));

    final shown = text.trim().isEmpty ? '-' : text.trim();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        shown,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 12,
        ),
      ),
    );
  }
}

class _FilterSheet extends StatelessWidget {
  final String? selected;
  const _FilterSheet({required this.selected});

  @override
  Widget build(BuildContext context) {
    final options = <String>['Selesai', 'Proses', 'Batal', 'Follow Up'];

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Filter Status', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ChoiceChip(
                label: const Text('Clear'),
                selected: false,
                onSelected: (_) => Navigator.pop(context, ''),
              ),
              ...options.map((e) {
                final sel = (selected ?? '').toLowerCase() == e.toLowerCase();
                return ChoiceChip(
                  label: Text(e),
                  selected: sel,
                  onSelected: (_) => Navigator.pop(context, e),
                );
              }),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, size: 48),
            const SizedBox(height: 10),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: onRetry, child: const Text('Coba lagi')),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyState({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.groups_outlined, size: 48),
            const SizedBox(height: 10),
            Text(
              'No Visits',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 6),
            const Text(
              'Drag down to refresh or add new data',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () async => onRefresh(),
              child: const Text('Refresh'),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------
/// Helpers
/// ------------------------------

String _nonEmpty(String? s) {
  final v = (s ?? '').trim();
  return v.isEmpty ? '-' : v;
}

String _formatDate(DateTime? dt) {
  if (dt == null) return '-';
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.day)}/${two(dt.month)}/${dt.year}';
}

String _formatTime(DateTime? dt) {
  if (dt == null) return '-';
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.hour)}:${two(dt.minute)}';
}
