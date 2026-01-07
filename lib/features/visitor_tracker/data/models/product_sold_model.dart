DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');
double? _dbl(dynamic v) => (v is num) ? v.toDouble() : double.tryParse('$v');

class ProductSoldModel {
  final int productSoldId;
  final int? visitId;

  final String? productName;
  final int? quantity;
  final double? price;
  final double? total;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductSoldModel({
    required this.productSoldId,
    this.visitId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory ProductSoldModel.fromJson(Map<String, dynamic> json) {
    return ProductSoldModel(
      productSoldId:
          _int(
            json['product_sold_id'] ?? json['productSoldId'] ?? json['id'],
          ) ??
          0,
      visitId: _int(json['visit_id']),
      productName: json['product_name'] as String? ?? json['name'] as String?,
      quantity: _int(json['quantity'] ?? json['qty']),
      price: _dbl(json['price']),
      total: _dbl(json['total']),
      notes: json['notes'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
