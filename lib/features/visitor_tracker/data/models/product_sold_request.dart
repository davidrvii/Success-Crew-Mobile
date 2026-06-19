/// File: lib/features/visitor_tracker/data/models/product_sold_request.dart
/// Generated Documentation for product_sold_request.dart

/// Class representing `ProductSoldRequest`.
/// Auto-generated class documentation.
class ProductSoldRequest {
  final int? visitId;
  final String? productName;
  final int? quantity;
  final double? price;
  final double? total;
  final String? notes;

  const ProductSoldRequest({
    this.visitId,
    this.productName,
    this.quantity,
    this.price,
    this.total,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (visitId != null) {
      data['visit_id'] = visitId;
    }
    if (productName != null) {
      data['product_sold_name'] = productName;
      data['product_name'] = productName;
    }
    if (quantity != null) {
      data['product_sold_quantity'] = quantity;
      data['quantity'] = quantity;
    }
    if (price != null) {
      data['product_sold_price'] = price;
      data['price'] = price;
    }
    if (total != null) {
      data['product_sold_total'] = total;
      data['total'] = total;
    }
    if (notes != null) {
      data['product_sold_desc'] = notes;
      data['notes'] = notes;
    }

    return data;
  }
}
