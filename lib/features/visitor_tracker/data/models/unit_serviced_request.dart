class UnitServicedRequest {
  final String? unitName;
  final String? issue;
  final String? action;
  final String? status;
  final String? notes;

  const UnitServicedRequest({
    this.unitName,
    this.issue,
    this.action,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (unitName != null) data['unit_name'] = unitName;
    if (issue != null) data['issue'] = issue;
    if (action != null) data['action'] = action;
    if (status != null) data['status'] = status;
    if (notes != null) data['notes'] = notes;
    return data;
  }
}
