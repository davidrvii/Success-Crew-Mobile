class UnitServicedRequest {
  final int? visitId;
  final String? unitName;
  final String? issue;
  final String? action;
  final String? status;
  final String? notes;

  const UnitServicedRequest({
    this.visitId,
    this.unitName,
    this.issue,
    this.action,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (visitId != null) {
      data['visit_id'] = visitId;
    }
    if (unitName != null) {
      data['unit_serviced_name'] = unitName;
      data['unit_name'] = unitName;
    }
    if (issue != null) {
      data['unit_serviced_issue'] = issue;
      data['issue'] = issue;
    }
    if (action != null) {
      data['unit_serviced_action'] = action;
      data['action'] = action;
    }
    if (status != null) {
      data['unit_serviced_status'] = status;
      data['status'] = status;
    }
    if (notes != null) {
      data['unit_serviced_desc'] = notes;
      data['notes'] = notes;
    }

    return data;
  }
}
