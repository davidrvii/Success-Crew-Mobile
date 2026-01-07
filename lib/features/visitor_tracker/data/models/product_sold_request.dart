class ProductSoldRequest {
  final String? productName;
  final int? quantity;
  final double? price;
  final double? total;
  final String? notes;

  const ProductSoldRequest({
    this.productName,
    this.quantity,
    this.price,
    this.total,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (productName != null) data['product_name'] = productName;
    if (quantity != null) data['quantity'] = quantity;
    if (price != null) data['price'] = price;
    if (total != null) data['total'] = total;
    if (notes != null) data['notes'] = notes;
    return data;
  }
}
