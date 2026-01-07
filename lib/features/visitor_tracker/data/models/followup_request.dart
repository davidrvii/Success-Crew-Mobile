class FollowUpRequest {
  final String? stage;
  final String? notes;
  final String? status;

  const FollowUpRequest({this.stage, this.notes, this.status});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (stage != null) data['stage'] = stage;
    if (notes != null) data['notes'] = notes;
    if (status != null) data['status'] = status;
    return data;
  }
}
