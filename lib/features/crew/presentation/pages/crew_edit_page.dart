import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../controllers/crew_detail_controller.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../data/models/crew_request.dart';

class CrewEditPage extends StatefulWidget {
  final UserDetail detail;
  final CrewDetailController controller;

  const CrewEditPage({super.key, required this.detail, required this.controller});

  @override
  State<CrewEditPage> createState() => _CrewEditPageState();
}

class _CrewEditPageState extends State<CrewEditPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  DateTime? _selectedBirthDate;
  DateTime? _selectedStartWork;
  DateTime? _selectedEndWork;

  late String _selectedCrewStatus;
  late String _selectedContractStatus;
  late String _selectedRole;
  late String _selectedLocation;

  @override
  void initState() {
    super.initState();
    final d = widget.detail;
    _nameController = TextEditingController(text: d.userName);
    _emailController = TextEditingController(text: d.userEmail);
    _phoneController = TextEditingController(text: d.userPhone ?? '');

    _selectedBirthDate = d.userBirth;
    _selectedStartWork = d.startWork;
    _selectedEndWork = d.endWork;

    _selectedCrewStatus = _normalizeCrewStatus(d.crewStatus);
    _selectedContractStatus = _normalizeContractStatus(d.contractStatus);
    _selectedRole = _normalizeRole(d.roleName);
    _selectedLocation = _normalizeLocation(d.officeName);
  }

  String _normalizeLocation(String? raw) {
    final s = (raw ?? '').trim().toLowerCase();
    if (s.contains('bogor')) return 'Success Comp Bogor';
    return 'Success Comp Cibubur';
  }

  String _normalizeRole(String? raw) {
    final s = (raw ?? '').trim().toLowerCase();
    const roles = ['owner', 'manager', 'sales', 'teknisi', 'admin service', 'kurir', 'kasir'];
    if (roles.contains(s)) return s;
    if (s == 'driver') return 'kurir';
    return 'teknisi';
  }

  String _normalizeContractStatus(String? raw) {
    final s = (raw ?? '').trim().toLowerCase();
    if (s == 'magang') return 'Magang';
    if (s == 'paruh waktu' || s == 'part time') return 'Paruh Waktu';
    if (s == 'pkwt' || s.contains('kontrak')) return 'PKWT';
    return 'Crew Tetap';
  }

  String _normalizeCrewStatus(String? raw) {
    final s = (raw ?? '').trim().toLowerCase();
    if (s == 'tidak aktif' || s == 'nonaktif' || s == 'non-aktif') {
      return 'Tidak Aktif';
    }
    return 'Aktif';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, String type) async {
    final now = DateTime.now();
    DateTime initialDate;
    DateTime firstDate;
    DateTime lastDate;

    if (type == 'birth') {
      initialDate = _selectedBirthDate ?? DateTime(1995, 1, 1);
      firstDate = DateTime(1950);
      lastDate = now;
    } else {
      initialDate = (type == 'start' ? _selectedStartWork : _selectedEndWork) ?? now;
      firstDate = DateTime(2000);
      lastDate = DateTime(2100);
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      setState(() {
        if (type == 'birth') {
          _selectedBirthDate = picked;
        } else if (type == 'start') {
          _selectedStartWork = picked;
        } else if (type == 'end') {
          _selectedEndWork = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final birthStr = _selectedBirthDate != null
        ? DateFormat('yyyy-MM-dd').format(_selectedBirthDate!)
        : null;
    final startStr = _selectedStartWork != null
        ? DateFormat('yyyy-MM-dd').format(_selectedStartWork!)
        : null;
    final endStr = _selectedEndWork != null
        ? DateFormat('yyyy-MM-dd').format(_selectedEndWork!)
        : null;

    final request = CrewRequest(
      userName: _nameController.text.trim(),
      userEmail: _emailController.text.trim(),
      userPhone: _phoneController.text.trim(),
      roleName: _selectedRole,
      officeName: _selectedLocation,
      userBirth: birthStr,
      startWork: startStr,
      endWork: endStr,
      crewStatus: _selectedCrewStatus,
      contractStatus: _selectedContractStatus,
    );

    final success = await widget.controller.updateCrew(widget.detail.userId, request);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crew berhasil diperbarui!')),
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
            _buildCustomHeader(context, 'Ubah Crew'),
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

                            // Nama Lengkap
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Nama Lengkap',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Email
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Email wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Telepon
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Telepon',
                                border: OutlineInputBorder(),
                              ),
                              validator: (v) => v == null || v.isEmpty ? 'Telepon wajib diisi' : null,
                            ),
                            const SizedBox(height: 16),

                            // Tanggal Lahir (DatePicker)
                            InkWell(
                              onTap: () => _pickDate(context, 'birth'),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Tanggal Lahir',
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.calendar_today_rounded),
                                ),
                                child: Text(
                                  _selectedBirthDate != null
                                      ? DateFormat('dd MMM yyyy').format(_selectedBirthDate!)
                                      : 'Pilih Tanggal Lahir',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: _selectedBirthDate != null ? Colors.black : Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Tanggal Mulai & Selesai Kerja
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _pickDate(context, 'start'),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Mulai Kerja',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today_rounded),
                                      ),
                                      child: Text(
                                        _selectedStartWork != null
                                            ? DateFormat('dd MMM yyyy').format(_selectedStartWork!)
                                            : 'Mulai Kerja',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _selectedStartWork != null ? Colors.black : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: InkWell(
                                    onTap: () => _pickDate(context, 'end'),
                                    child: InputDecorator(
                                      decoration: const InputDecoration(
                                        labelText: 'Selesai Kerja',
                                        border: OutlineInputBorder(),
                                        suffixIcon: Icon(Icons.calendar_today_rounded),
                                      ),
                                      child: Text(
                                        _selectedEndWork != null
                                            ? DateFormat('dd MMM yyyy').format(_selectedEndWork!)
                                            : 'Selesai (Opsional)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: _selectedEndWork != null ? Colors.black : Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Posisi/Jabatan (Role)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedRole,
                              decoration: const InputDecoration(
                                labelText: 'Posisi/Jabatan (Role)',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'owner', child: Text('Owner')),
                                DropdownMenuItem(value: 'manager', child: Text('Manager')),
                                DropdownMenuItem(value: 'sales', child: Text('Sales')),
                                DropdownMenuItem(value: 'teknisi', child: Text('Teknisi')),
                                DropdownMenuItem(value: 'admin service', child: Text('Admin Service')),
                                DropdownMenuItem(value: 'kurir', child: Text('Kurir')),
                                DropdownMenuItem(value: 'kasir', child: Text('Kasir')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedRole = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),

                            // Lokasi Kerja (Office)
                            DropdownButtonFormField<String>(
                              initialValue: _selectedLocation,
                              decoration: const InputDecoration(
                                labelText: 'Lokasi Kantor',
                                border: OutlineInputBorder(),
                              ),
                              items: const [
                                DropdownMenuItem(value: 'Success Comp Cibubur', child: Text('Success Comp Cibubur')),
                                DropdownMenuItem(value: 'Success Comp Bogor', child: Text('Success Comp Bogor')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedLocation = val;
                                  });
                                }
                              },
                            ),
                            const SizedBox(height: 16),

                            // Status Crew & Kontrak Crew (Dropdown)
                            Row(
                              children: [
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _selectedCrewStatus,
                                    decoration: const InputDecoration(
                                      labelText: 'Status Crew',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(value: 'Aktif', child: Text('Aktif')),
                                      DropdownMenuItem(value: 'Tidak Aktif', child: Text('Tidak Aktif')),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedCrewStatus = val;
                                          if (val == 'Tidak Aktif') {
                                            _selectedEndWork ??= DateTime.now();
                                          } else if (val == 'Aktif') {
                                            _selectedEndWork = null;
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    initialValue: _selectedContractStatus,
                                    decoration: const InputDecoration(
                                      labelText: 'Kontrak Crew',
                                      border: OutlineInputBorder(),
                                    ),
                                    items: const [
                                      DropdownMenuItem(value: 'Crew Tetap', child: Text('Crew Tetap')),
                                      DropdownMenuItem(value: 'Magang', child: Text('Magang')),
                                      DropdownMenuItem(value: 'Paruh Waktu', child: Text('Paruh Waktu')),
                                      DropdownMenuItem(value: 'PKWT', child: Text('PKWT')),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        setState(() {
                                          _selectedContractStatus = val;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
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
                                      'Simpan Perubahan',
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
        color: const Color(0xFF1C5AA6),
        borderRadius: BorderRadius.circular(28),
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
