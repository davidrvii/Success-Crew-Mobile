class Visitor {
  final int visitorId;
  final String? visitorName;
  final String? visitorPhone;
  final String? visitorInformation;
  final String? visitorAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Visitor({
    required this.visitorId,
    this.visitorName,
    this.visitorPhone,
    this.visitorInformation,
    this.visitorAddress,
    this.createdAt,
    this.updatedAt,
  });
}
