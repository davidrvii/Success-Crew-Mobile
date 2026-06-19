class OutOfOffice {
  final int id;
  final int userId;

  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const OutOfOffice({
    required this.id,
    required this.userId,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  bool get isPending {
    final s = (status ?? '').toLowerCase().trim();
    return s.contains('pending') ||
        s.contains('wait') ||
        s.contains('waiting') ||
        s.contains('process') ||
        s.contains('requested');
  }
}
