import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/storage/user_session.dart';
import '../controllers/visit_controller.dart';
import '../../domain/entities/visitor.dart';

class VisitFormPage extends StatefulWidget {
  final VisitorController controller;

  const VisitFormPage({super.key, required this.controller});

  @override
  State<VisitFormPage> createState() => _VisitFormPageState();
}

class _VisitFormPageState extends State<VisitFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController(); // perusahaan/instansi
  final _notesController = TextEditingController(); // catatan kunjungan 
  final _interestController = TextEditingController(); // interest pengunjung 
  final _visitSalesController = TextEditingController(); // visit sales 

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedStatus = 'Proses';
  String _selectedType = 'Baru';
  String _selectedMethod = 'Walk In';
  int? _userId;
  int? _selectedVisitorId;

  @override
  void initState() {
    super.initState();
    _loadSalesSession();
  }

  Future<void> _loadSalesSession() async {
    final session = sl<UserSession>();
    final name = await session.readUserName();
    _userId = await session.readUserId();
    if (name != null && mounted) {
      setState(() {
        _visitSalesController.text = name;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    _notesController.dispose();
    _interestController.dispose();
    _visitSalesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final combinedDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );

    final success = await widget.controller.submitVisit(
      visitorName: _nameController.text.trim(),
      visitorPhone: _phoneController.text.trim(),
      visitorCompany: _companyController.text.trim(), 
      purpose: _interestController.text.trim(), // keperluan
      visitorCategory: _selectedType, // status pengunjung
      visitDesc: _notesController.text.trim(), // catatan kunjungan
      visitType: _selectedMethod, // metode kunjungan
      status: _selectedStatus,
      createdAt: combinedDateTime,
      userId: _userId,
      visitorId: _selectedVisitorId,
      visitSales: _visitSalesController.text.trim(),
    );

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pengunjung berhasil ditambahkan!')),
      );
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomHeader(context, 'Tambah Pengunjung'),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  final c = widget.controller;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
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

                            // Nama
                            Autocomplete<Visitor>(
                              optionsBuilder: (TextEditingValue textEditingValue) {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<Visitor>.empty();
                                }
                                return widget.controller.visitors.where((Visitor v) {
                                  return (v.visitorName ?? '')
                                      .toLowerCase()
                                      .contains(textEditingValue.text.toLowerCase());
                                });
                              },
                              displayStringForOption: (Visitor option) => option.visitorName ?? '',
                              onSelected: (Visitor selection) {
                                setState(() {
                                  _selectedVisitorId = selection.visitorId;
                                  _phoneController.text = selection.visitorPhone ?? '';
                                  _selectedType = selection.visitorCategory ?? 'Baru';
                                  
                                  _companyController.text = selection.visitorCompany ?? '';
                                });
                              },
                              fieldViewBuilder: (
                                BuildContext context,
                                TextEditingController textEditingController,
                                FocusNode focusNode,
                                VoidCallback onFieldSubmitted,
                              ) {
                                return TextFormField(
                                  controller: textEditingController,
                                  focusNode: focusNode,
                                  decoration: const InputDecoration(
                                    labelText: 'Nama Pengunjung',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (val) {
                                    final matched = widget.controller.visitors.firstWhere(
                                      (v) => (v.visitorName ?? '').toLowerCase() == val.trim().toLowerCase(),
                                      orElse: () => const Visitor(visitorId: -1),
                                    );
                                    setState(() {
                                      if (matched.visitorId != -1) {
                                        _selectedVisitorId = matched.visitorId;
                                      } else {
                                        _selectedVisitorId = null;
                                      }
                                    });
                                  },
                                  onFieldSubmitted: (val) {
                                    onFieldSubmitted();
                                  },
                                  validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                                );
                              },
                              textEditingController: _nameController,
                              focusNode: _nameFocusNode,
                            ),
                            const SizedBox(height: 16),

                            // Tanggal & Waktu
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: _pickDate,
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Tanggal',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today),
                                      ),
                                      child: Text(
                                        DateFormat('dd MMM yyyy').format(_selectedDate),
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: InkWell(
                                    onTap: _pickTime,
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Waktu / Jam',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.access_time),
                                      ),
                                      child: Text(
                                        '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Metode Kunjungan (Dropdown)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedMethod,
                              decoration: const InputDecoration(
                                labelText: 'Metode Kunjungan',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Walk In', child: Text('Walk In')),
                                DropdownMenuItem(value: 'Call In', child: Text('Call In')),
                                DropdownMenuItem(value: 'Chat In', child: Text('Chat In')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedMethod = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),

                            // Status Kunjungan (Dropdown)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedStatus,
                              decoration: const InputDecoration(
                                labelText: 'Status Kunjungan',
                                border: OutlineInputBorder(),
                              ),
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

                            // Status Pengunjung (Dropdown)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedType,
                              decoration: const InputDecoration(
                                labelText: 'Status Pengunjung',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Baru', child: Text('Baru')),
                                DropdownMenuItem(value: 'Lama', child: Text('Lama')),
                                DropdownMenuItem(value: 'Langganan', child: Text('Langganan')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedType = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),

                            // Nomor Telepon
                            TextFormField(
                              controller: _phoneController,
                              decoration: const InputDecoration(
                                labelText: 'Nomor Telepon',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.phone,
                              validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Perusahaan / Instansi
                            TextFormField(
                              controller: _companyController,
                              decoration: const InputDecoration(
                                labelText: 'Perusahaan / Instansi',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                            ),
                             const SizedBox(height: 16),

                            // Keperluan
                            TextFormField(
                              controller: _interestController,
                              decoration: const InputDecoration(
                                labelText: 'Keperluan',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 1,
                              validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Catatan Kunjungan
                            TextFormField(
                              controller: _notesController,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: 'Catatan Kunjungan',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Visit Sales (default logged in user)
                            TextFormField(
                              controller: _visitSalesController,
                              decoration: const InputDecoration(
                                labelText: 'Visit Sales',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.trim().isEmpty ? 'Visit sales wajib diisi' : null,
                            ),
                            const SizedBox(height: 32),

                            ElevatedButton(
                              onPressed: c.isLoading ? null : _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1C5AA6),
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: c.isLoading
                                  ? const CircularProgressIndicator(color: Colors.white)
                                  : const Text(
                                      'Simpan Pengunjung',
                                      style: TextStyle(fontSize: 16, color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
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

  Widget _buildCustomHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      height: 80,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1C5AA6), // Brand blue
        borderRadius: BorderRadius.circular(28), // Rounded rectangle shape
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 12,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                onTap: () => Navigator.maybePop(context),
                borderRadius: BorderRadius.circular(20),
                child: const SizedBox(
                  width: 56,
                  height: 56,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
