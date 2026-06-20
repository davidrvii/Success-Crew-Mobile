/// File: lib/features/leave/presentation/pages/leave_form_page.dart
/// Generated Documentation for leave_form_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controllers/leave_controller.dart';

/// Class representing `LeaveFormPage`.
/// Auto-generated class documentation.
class LeaveFormPage extends StatefulWidget {
  final LeaveController controller;

  const LeaveFormPage({super.key, required this.controller});

  @override
  State<LeaveFormPage> createState() => _LeaveFormPageState();
}

/// Class representing `_LeaveFormPageState`.
/// Auto-generated class documentation.
class _LeaveFormPageState extends State<LeaveFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _typeController = TextEditingController();
  final _reasonController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _typeController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  /// Method `_pickStartDate` returning `Future<void>`.
  /// Handles logic operations related to `_pickStartDate`.
  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        // Jika endDate sudah dipilih tapi mendahului startDate yang baru, reset endDate
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
      });
    }
  }

  /// Method `_pickEndDate` returning `Future<void>`.
  /// Handles logic operations related to `_pickEndDate`.
  Future<void> _pickEndDate() async {
    if (_startDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih Tanggal Mulai terlebih dahulu.')),
      );
      return;
    }
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? _startDate!,
      firstDate: _startDate!,
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  /// Method `_submit` returning `Future<void>`.
  /// Handles logic operations related to `_submit`.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null || _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi Tanggal Mulai dan Tanggal Selesai.')),
      );
      return;
    }

    // Ekstra proteksi bisnis
    if (_endDate!.isBefore(_startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal Selesai tidak boleh mendahului Tanggal Mulai.')),
      );
      return;
    }

    final format = DateFormat('yyyy-MM-dd');
    final startStr = format.format(_startDate!);
    final endStr = format.format(_endDate!);

    final success = await widget.controller.submitLeave(
      type: _typeController.text.trim(),
      startDate: startStr,
      endDate: endStr,
      reason: _reasonController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cuti berhasil diajukan!')),
      );
      context.pop(true);
    } else if (mounted && widget.controller.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(widget.controller.errorMessage!),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  /// Method `build` returning `Widget`.
  /// Handles logic operations related to `build`.
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(context, 'Pengajuan Cuti'),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  final c = widget.controller;
        
                  final format = DateFormat('dd MMMM yyyy', 'id_ID');
        
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
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
                                TextFormField(
                                  controller: _typeController,
                                  decoration: const InputDecoration(
                                    labelText: 'Jenis Cuti (Misal: Tahunan, Sakit)',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                                ),
                                const SizedBox(height: 16),

                                // Tanggal Mulai (Picker)
                                InkWell(
                                  onTap: _pickStartDate,
                                  child: InputDecorator(
                                    decoration: const InputDecoration(
                                      labelText: 'Tanggal Mulai',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.calendar_today),
                                    ),
                                    child: Text(
                                      _startDate == null ? 'Pilih Tanggal' : format.format(_startDate!),
                                      style: TextStyle(
                                        color: _startDate == null ? Colors.black54 : Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Tanggal Selesai (Picker)
                                InkWell(
                                  onTap: _pickEndDate,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                      labelText: 'Tanggal Selesai',
                                      border: const OutlineInputBorder(),
                                      suffixIcon: const Icon(Icons.calendar_today),
                                      // Efek abu-abu jika startDate belum dipilih
                                      fillColor: _startDate == null ? Colors.grey.shade100 : null,
                                      filled: _startDate == null,
                                    ),
                                    child: Text(
                                      _endDate == null ? 'Pilih Tanggal' : format.format(_endDate!),
                                      style: TextStyle(
                                        color: _endDate == null ? Colors.black54 : Colors.black87,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                TextFormField(
                                  controller: _reasonController,
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    labelText: 'Alasan Cuti',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                                ),
                                const SizedBox(height: 24),
                                ElevatedButton(
                                  onPressed: c.isLoading ? null : _submit,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1C5AA6),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: c.isLoading
                                      ? const CircularProgressIndicator(color: Colors.white)
                                      : const Text(
                                          'Kirim Pengajuan',
                                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

  /// Method `_buildCustomHeader` returning `Widget`.
  /// Handles logic operations related to `_buildCustomHeader`.
  Widget _buildCustomHeader(BuildContext context, String title) {
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
            onTap: () => Navigator.maybePop(context),
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
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
