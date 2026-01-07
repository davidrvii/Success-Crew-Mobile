class ProductSold {
  final int productSoldId;
  final int visitId;

  final String? productName;
  final int? quantity;
  final double? price;
  final double? total;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const ProductSold({
    required this.productSoldId,
    required this.visitId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
}
