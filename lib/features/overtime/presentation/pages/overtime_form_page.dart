import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controllers/overtime_controller.dart';

class OvertimeFormPage extends StatefulWidget {
  final OvertimeController controller;

  const OvertimeFormPage({super.key, required this.controller});

  @override
  State<OvertimeFormPage> createState() => _OvertimeFormPageState();
}

class _OvertimeFormPageState extends State<OvertimeFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();

  DateTime? _date;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _date = picked;
      });
    }
  }

  Future<void> _pickStartTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _startTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _startTime = picked;
        // Reset endTime jika menjadi tidak valid (kurang dari startTime)
        if (_endTime != null) {
          final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
          final endMinutes = _endTime!.hour * 60 + _endTime!.minute;
          if (endMinutes <= startMinutes) {
            _endTime = null;
          }
        }
      });
    }
  }

  Future<void> _pickEndTime() async {
    if (_startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih Waktu Mulai terlebih dahulu.')),
      );
      return;
    }

    final picked = await showTimePicker(
      context: context,
      initialTime: _endTime ?? _startTime!,
    );
    
    if (picked != null) {
      final startMinutes = _startTime!.hour * 60 + _startTime!.minute;
      final pickedMinutes = picked.hour * 60 + picked.minute;

      if (pickedMinutes <= startMinutes) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Waktu Selesai harus lebih besar dari Waktu Mulai (tidak boleh lewat tengah malam).'),
            ),
          );
        }
        return;
      }

      setState(() {
        _endTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    
    if (_date == null || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi Tanggal, Waktu Mulai, dan Waktu Selesai.')),
      );
      return;
    }

    // Ekstra Proteksi (sudah dicek saat picking, tapi jaga-jaga)
    final startMins = _startTime!.hour * 60 + _startTime!.minute;
    final endMins = _endTime!.hour * 60 + _endTime!.minute;
    if (endMins <= startMins) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Waktu Selesai tidak valid.')),
      );
      return;
    }

    final dateFormat = DateFormat('yyyy-MM-dd');
    final dateStr = dateFormat.format(_date!);

    String formatTime(TimeOfDay t) {
      final h = t.hour.toString().padLeft(2, '0');
      final m = t.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }

    final success = await widget.controller.submitOvertime(
      date: dateStr,
      startTime: formatTime(_startTime!),
      endTime: formatTime(_endTime!),
      reason: _reasonController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lembur berhasil diajukan!')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Pengajuan Lembur'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          final c = widget.controller;
          final dateFormat = DateFormat('dd MMM yyyy');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (c.errorMessage != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      color: Colors.red.shade50,
                      child: Text(
                        c.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Tanggal Lembur
                  InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Lembur',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _date == null ? 'Pilih Tanggal' : dateFormat.format(_date!),
                        style: TextStyle(
                          color: _date == null ? Colors.black54 : Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      // Waktu Mulai
                      Expanded(
                        child: InkWell(
                          onTap: _pickStartTime,
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Waktu Mulai',
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.access_time),
                            ),
                            child: Text(
                              _startTime == null ? '--:--' : _startTime!.format(context),
                              style: TextStyle(
                                color: _startTime == null ? Colors.black54 : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Waktu Selesai
                      Expanded(
                        child: InkWell(
                          onTap: _pickEndTime,
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: 'Waktu Selesai',
                              border: const OutlineInputBorder(),
                              suffixIcon: const Icon(Icons.access_time),
                              fillColor: _startTime == null ? Colors.grey.shade100 : null,
                              filled: _startTime == null,
                            ),
                            child: Text(
                              _endTime == null ? '--:--' : _endTime!.format(context),
                              style: TextStyle(
                                color: _endTime == null ? Colors.black54 : Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _reasonController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Alasan Lembur',
                      border: OutlineInputBorder(),
                    ),
                    validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 32),
                  
                  ElevatedButton(
                    onPressed: c.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1DB954),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: c.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            'Kirim Pengajuan',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
