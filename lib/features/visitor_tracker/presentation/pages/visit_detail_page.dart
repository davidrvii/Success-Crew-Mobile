/// File: lib/features/visitor_tracker/presentation/pages/visit_detail_page.dart
/// Generated Documentation for visit_detail_page.dart

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../controllers/visit_detail_controller.dart';
import '../../domain/entities/visit.dart';
import '../../domain/entities/followup.dart';
import '../../domain/entities/product_sold.dart';
import '../../domain/entities/unit_serviced.dart';

/// Class representing `VisitDetailPage`.
/// Auto-generated class documentation.
class VisitDetailPage extends StatefulWidget {
  final int visitId;
  const VisitDetailPage({super.key, required this.visitId});

  @override
  State<VisitDetailPage> createState() => _VisitDetailPageState();
}

/// Class representing `_VisitDetailPageState`.
/// Auto-generated class documentation.
class _VisitDetailPageState extends State<VisitDetailPage> {
  late final VisitDetailController c;

  @override
  /// Method `initState` returning `void`.
  /// Handles logic operations related to `initState`.
  void initState() {
    super.initState();
    c = GetIt.instance<VisitDetailController>();
    c.init(widget.visitId);
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: c,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF4F6F8),
          body: SafeArea(
            child: Column(
              children: [
                _TopHeader(
                  titleTop: (c.visit?.visitType ?? 'Walk-In'),
                  titleMain: (c.visit?.visitorName ?? '-'),
                  onBack: () => Navigator.pop(context),
                ),
                Expanded(child: _buildBody(context)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Method `_buildBody` returning `Widget`.
  /// Handles logic operations related to `_buildBody`.
  Widget _buildBody(BuildContext context) {
    if (c.isLoading && c.visit == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (c.errorMessage != null && c.visit == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(c.errorMessage!, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: c.refreshAll,
              child: const Text('Coba lagi'),
            ),
          ],
        ),
      );
    }

    final v = c.visit;

    return RefreshIndicator(
      onRefresh: () async => c.refreshAll(),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
        children: [
          _Card(child: _VisitSummaryCard(visit: v)),
          const SizedBox(height: 14),
          _Card(
            title: 'Pengunjung',
            child: _VisitorInfoCard(visit: v),
          ),
          const SizedBox(height: 14),
          _Card(
            title: 'Keperluan',
            child: _NeedCard(visit: v),
          ),

          const SizedBox(height: 16),
          _SectionHeader(
            title: 'Aktifitas',
            subtitle: '',
            onRefresh: c.refreshAll,
          ),
          const SizedBox(height: 10),
          _Card(
            title: 'Follow Up',
            trailing: IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF0B5FA5)),
              onPressed: () => _showFollowUpForm(context, c),
            ),
            child: _SimpleList(
              isLoading: c.isLoadingFollowUps,
              error: c.followUpsError,
              emptyText: 'No Follow Up',
              items: c.followUps.map((f) {
                return Dismissible(
                  key: Key('followup_${f.followUpId}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _showConfirmDialog(
                      context,
                      'Hapus Follow Up',
                      'Apakah Anda yakin ingin menghapus data follow up ini?',
                    );
                  },
                  onDismissed: (direction) async {
                    final success = await c.deleteFollowUpItem(f.followUpId);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Follow up berhasil dihapus')),
                      );
                    }
                  },
                  child: _FollowUpItem(followUp: f),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _Card(
            title: 'Product Sold',
            trailing: IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF0B5FA5)),
              onPressed: () => _showProductSoldForm(context, c),
            ),
            child: _SimpleList(
              isLoading: c.isLoadingProducts,
              error: c.productsError,
              emptyText: 'No Products Sold',
              items: c.products.map((p) {
                return Dismissible(
                  key: Key('product_${p.productSoldId}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _showConfirmDialog(
                      context,
                      'Hapus Produk Terjual',
                      'Apakah Anda yakin ingin menghapus data produk terjual ${p.productName ?? ''} ini?',
                    );
                  },
                  onDismissed: (direction) async {
                    final success = await c.deleteProductItem(p.productSoldId);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Produk terjual berhasil dihapus')),
                      );
                    }
                  },
                  child: _ProductSoldItem(productSold: p),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          _Card(
            title: 'Unit Servis',
            trailing: IconButton(
              icon: const Icon(Icons.add_circle, color: Color(0xFF0B5FA5)),
              onPressed: () => _showUnitServicedForm(context, c),
            ),
            child: _SimpleList(
              isLoading: c.isLoadingUnits,
              error: c.unitsError,
              emptyText: 'No Unit Serviced',
              items: c.units.map((u) {
                return Dismissible(
                  key: Key('unit_${u.unitServicedId}'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    return await _showConfirmDialog(
                      context,
                      'Hapus Unit Servis',
                      'Apakah Anda yakin ingin menghapus data unit servis ${u.unitName ?? ''} ini?',
                    );
                  },
                  onDismissed: (direction) async {
                    final success = await c.deleteUnitItem(u.unitServicedId);
                    if (success && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unit servis berhasil dihapus')),
                      );
                    }
                  },
                  child: _UnitServicedItem(unitServiced: u),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }


  /// Method `_showFollowUpForm` returning `void`.
  /// Handles logic operations related to `_showFollowUpForm`.
  void _showFollowUpForm(BuildContext context, VisitDetailController c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _FollowUpForm(controller: c),
      ),
    );
  }

  /// Method `_showProductSoldForm` returning `void`.
  /// Handles logic operations related to `_showProductSoldForm`.
  void _showProductSoldForm(BuildContext context, VisitDetailController c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _ProductSoldForm(controller: c),
      ),
    );
  }

  /// Method `_showUnitServicedForm` returning `void`.
  /// Handles logic operations related to `_showUnitServicedForm`.
  void _showUnitServicedForm(BuildContext context, VisitDetailController c) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: _UnitServicedForm(controller: c),
      ),
    );
  }
}

/// Class representing `_FollowUpForm`.
/// Auto-generated class documentation.
class _FollowUpForm extends StatefulWidget {
  final VisitDetailController controller;
  const _FollowUpForm({required this.controller});
  @override
  State<_FollowUpForm> createState() => _FollowUpFormState();
}

/// Class representing `_FollowUpFormState`.
/// Auto-generated class documentation.
class _FollowUpFormState extends State<_FollowUpForm> {
  final _notes = TextEditingController();
  String _selectedStatus = 'Proses';

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Tambah Follow Up', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Catatan / Action', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedStatus,
            decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder()),
            items: const [
              DropdownMenuItem(value: 'Proses', child: Text('Proses')),
              DropdownMenuItem(value: 'Selesai', child: Text('Selesai')),
              DropdownMenuItem(value: 'Batal', child: Text('Batal')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedStatus = val;
                });
              }
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_notes.text.isEmpty) return;
              final res = await widget.controller.submitFollowUp(_notes.text, _selectedStatus);
              if (res && context.mounted) Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

/// Class representing `_ProductSoldForm`.
/// Auto-generated class documentation.
class _ProductSoldForm extends StatefulWidget {
  final VisitDetailController controller;
  const _ProductSoldForm({required this.controller});
  @override
  State<_ProductSoldForm> createState() => _ProductSoldFormState();
}

/// Class representing `_ProductSoldFormState`.
/// Auto-generated class documentation.
class _ProductSoldFormState extends State<_ProductSoldForm> {
  final _name = TextEditingController();
  final _qty = TextEditingController();
  final _price = TextEditingController();
  final _notes = TextEditingController();

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Tambah Product Sold', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nama Produk', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: TextField(controller: _qty, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Qty', border: OutlineInputBorder()))),
              const SizedBox(width: 12),
              Expanded(child: TextField(controller: _price, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga', border: OutlineInputBorder()))),
            ],
          ),
          const SizedBox(height: 12),
          TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Catatan', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_name.text.isEmpty) return;
              final q = int.tryParse(_qty.text) ?? 1;
              final p = double.tryParse(_price.text) ?? 0.0;
              final res = await widget.controller.submitProductSold(_name.text, q, p, _notes.text);
              if (res && context.mounted) Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

/// Class representing `_UnitServicedForm`.
/// Auto-generated class documentation.
class _UnitServicedForm extends StatefulWidget {
  final VisitDetailController controller;
  const _UnitServicedForm({required this.controller});
  @override
  State<_UnitServicedForm> createState() => _UnitServicedFormState();
}

/// Class representing `_UnitServicedFormState`.
/// Auto-generated class documentation.
class _UnitServicedFormState extends State<_UnitServicedForm> {
  final _name = TextEditingController();
  final _issue = TextEditingController();
  final _action = TextEditingController();
  final _notes = TextEditingController();
  final _status = TextEditingController();

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Tambah Unit Servis', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nama Unit', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _issue, decoration: const InputDecoration(labelText: 'Kendala (Issue)', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _action, decoration: const InputDecoration(labelText: 'Tindakan (Action)', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _status, decoration: const InputDecoration(labelText: 'Status', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Catatan', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              if (_name.text.isEmpty) return;
              final res = await widget.controller.submitUnitServiced(_name.text, _issue.text, _action.text, _notes.text, _status.text);
              if (res && context.mounted) Navigator.pop(context);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}

/// Class representing `_TopHeader`.
/// Auto-generated class documentation.
class _TopHeader extends StatelessWidget {
  final String titleTop;
  final String titleMain;
  final VoidCallback onBack;

  const _TopHeader({
    required this.titleTop,
    required this.titleMain,
    required this.onBack,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0B5FA5),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            borderRadius: BorderRadius.circular(14),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0B5FA5), size: 18),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  titleTop,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 2),
                Text(
                  titleMain,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}

/// Class representing `_Card`.
/// Auto-generated class documentation.
class _Card extends StatelessWidget {
  final String? title;
  final Widget child;
  final Widget? trailing;

  const _Card({this.title, required this.child, this.trailing});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              const SizedBox(height: 10),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

/// Class representing `_VisitSummaryCard`.
/// Auto-generated class documentation.
class _VisitSummaryCard extends StatelessWidget {
  final Visit? visit;
  const _VisitSummaryCard({required this.visit});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final v = visit;

    final type = v?.visitType ?? 'Walk-In';
    final date = _formatDate(v?.createdAt);
    final time = _formatTime(v?.createdAt);
    final rawStatus = (v?.visitorStatus ?? '').trim().toLowerCase();
    final status = (rawStatus == 'pending' || rawStatus == 'proses')
        ? 'Proses'
        : (rawStatus == 'done' || rawStatus == 'selesai')
            ? 'Selesai'
            : (rawStatus == 'cancel' || rawStatus == 'batal')
                ? 'Batal'
                : (v?.visitorStatus ?? '-');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kunjungan',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),

        _RowText(label: 'Tipe kunjungan', value: type),
        _RowText(label: 'Tanggal', value: date),
        _RowText(label: 'Jam datang', value: time),
        _RowText(label: 'Status kunjungan', value: status),
        _RowText(label: 'Sales', value: v?.visitSales ?? '-'),
        _RowText(label: 'Toko', value: v?.visitLocation ?? '-'),
      ],
    );
  }
}

/// Class representing `_VisitorInfoCard`.
/// Auto-generated class documentation.
class _VisitorInfoCard extends StatelessWidget {
  final Visit? visit;
  const _VisitorInfoCard({required this.visit});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final v = visit;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RowText(label: 'Nama', value: v?.visitorName ?? '-'),
        _RowText(label: 'Telepon', value: v?.visitorPhone ?? '-'),
        _RowText(label: 'Perusahaan/Instansi', value: v?.visitorCompany ?? '-'),
        _RowText(label: 'Status Pengunjung', value: v?.visitorCategory ?? '-'),
      ],
    );
  }
}

/// Class representing `_NeedCard`.
/// Auto-generated class documentation.
class _NeedCard extends StatelessWidget {
  final Visit? visit;
  const _NeedCard({required this.visit});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final v = visit;
    final interest = (v?.visitorInterest ?? '').trim();
    final desc = (v?.visitDesc ?? '').trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RowText(
          label: 'Keperluan',
          value: interest.isEmpty ? '-' : interest,
        ),
        _RowText(
          label: 'Keterangan',
          value: desc.isEmpty ? '-' : desc,
        ),
      ],
    );
  }
}

/// Class representing `_RowText`.
/// Auto-generated class documentation.
class _RowText extends StatelessWidget {
  final String label;
  final String value;
  const _RowText({required this.label, required this.value});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$label :',
              style: const TextStyle(color: Colors.black54),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }
}

/// Class representing `_SectionHeader`.
/// Auto-generated class documentation.
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onRefresh;

  const _SectionHeader({
    required this.title,
    required this.subtitle,
    required this.onRefresh,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (subtitle.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.black54)),
              ],
            ],
          ),
        ),
        IconButton(onPressed: onRefresh, icon: const Icon(Icons.refresh)),
      ],
    );
  }
}

/// Class representing `_SimpleList`.
/// Auto-generated class documentation.
class _SimpleList extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final String emptyText;
  final List<Widget> items;

  const _SimpleList({
    required this.isLoading,
    required this.error,
    required this.emptyText,
    required this.items,
  });

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (error != null) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Text(error!, style: const TextStyle(color: Colors.red)),
      );
    }
    if (items.isEmpty) {
      return Text(emptyText, style: const TextStyle(color: Colors.black54));
    }
    return Column(
      children: items
          .map(
            (e) =>
                Padding(padding: const EdgeInsets.only(bottom: 10), child: e),
          )
          .toList(),
    );
  }
}


/// Method `_formatDate` returning `String`.
/// Handles logic operations related to `_formatDate`.
String _formatDate(DateTime? dt) {
  if (dt == null) return '-';
  /// Method `two` returning `String`.
  /// Handles logic operations related to `two`.
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.day)}/${two(dt.month)}/${dt.year}';
}

/// Method `_formatTime` returning `String`.
/// Handles logic operations related to `_formatTime`.
String _formatTime(DateTime? dt) {
  if (dt == null) return '-';
  /// Method `two` returning `String`.
  /// Handles logic operations related to `two`.
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(dt.hour)}:${two(dt.minute)}';
}

/// Class representing `_FollowUpItem`.
/// Auto-generated class documentation.
class _FollowUpItem extends StatelessWidget {
  final FollowUp followUp;

  const _FollowUpItem({required this.followUp});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final title = followUp.status ?? 'Follow Up';
    final notes = followUp.notes ?? '-';
    final dateStr = _formatDate(followUp.createdAt);
    final timeStr = _formatTime(followUp.createdAt);

    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notes,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateStr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeStr,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Class representing `_ProductSoldItem`.
/// Auto-generated class documentation.
class _ProductSoldItem extends StatelessWidget {
  final ProductSold productSold;

  const _ProductSoldItem({required this.productSold});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final title = productSold.productName ?? 'Product';
    final details = [
      if (productSold.quantity != null) 'Qty ${productSold.quantity}',
      if (productSold.price != null) 'Harga Rp ${_formatCurrency(productSold.price)}',
      if ((productSold.notes ?? '').isNotEmpty) productSold.notes!,
    ].join(' • ');
    final sub = details.isEmpty ? '-' : details;
    final dateStr = _formatDate(productSold.createdAt);
    final timeStr = _formatTime(productSold.createdAt);

    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sub,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateStr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeStr,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Class representing `_UnitServicedItem`.
/// Auto-generated class documentation.
class _UnitServicedItem extends StatelessWidget {
  final UnitServiced unitServiced;

  const _UnitServicedItem({required this.unitServiced});

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    final title = unitServiced.unitName ?? 'Unit';
    final details = [
      if ((unitServiced.issue ?? '').isNotEmpty) 'Issue: ${unitServiced.issue}',
      if ((unitServiced.action ?? '').isNotEmpty) 'Action: ${unitServiced.action}',
      if ((unitServiced.status ?? '').isNotEmpty) 'Status: ${unitServiced.status}',
      if ((unitServiced.notes ?? '').isNotEmpty) 'Notes: ${unitServiced.notes}',
    ].join(' • ');
    final sub = details.isEmpty ? '-' : details;
    final dateStr = _formatDate(unitServiced.createdAt);
    final timeStr = _formatTime(unitServiced.createdAt);

    return Material(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    sub,
                    style: const TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateStr,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF475569),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  timeStr,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Method `_formatCurrency` returning `String`.
/// Handles logic operations related to `_formatCurrency`.
String _formatCurrency(double? val) {
  if (val == null) return '-';
  final clean = val.toInt();
  final str = clean.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < str.length; i++) {
    if (i > 0 && (str.length - i) % 3 == 0) {
      buffer.write('.');
    }
    buffer.write(str[i]);
  }
  return buffer.toString();
}

/// Method `_showConfirmDialog` returning `Future<bool?>`.
/// Handles logic operations related to `_showConfirmDialog`.
Future<bool?> _showConfirmDialog(BuildContext context, String title, String message) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Hapus', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      );
    },
  );
}
