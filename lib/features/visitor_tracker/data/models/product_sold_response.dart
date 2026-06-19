/// File: lib/features/visitor_tracker/data/models/product_sold_response.dart
/// Generated Documentation for product_sold_response.dart

import 'product_sold_model.dart';

/// Method `_status` returning `int`.
/// Handles logic operations related to `_status`.
int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
/// Method `_msg` returning `String`.
/// Handles logic operations related to `_msg`.
String _msg(Map<String, dynamic> json) => (json['message'] as String?) ?? '';

List<Map<String, dynamic>> _asListMap(dynamic raw) {
  if (raw is List) return raw.whereType<Map<String, dynamic>>().toList();
  if (raw is Map<String, dynamic>) {
    final inner =
        raw['products'] ??
        raw['productsSold'] ??
        raw['productSold'] ??
        raw['data'] ??
        raw['items'];
    if (inner is List) return inner.whereType<Map<String, dynamic>>().toList();
  }
  return const <Map<String, dynamic>>[];
}

Map<String, dynamic>? _asMap(dynamic raw) =>
    raw is Map<String, dynamic> ? raw : null;

/// Class representing `ProductSoldListResponse`.
/// Auto-generated class documentation.
class ProductSoldListResponse {
  final int statusCode;
  final String message;
  final List<ProductSoldModel> productsSold;

  const ProductSoldListResponse({
    required this.statusCode,
    required this.message,
    required this.productsSold,
  });

  factory ProductSoldListResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['products'] ?? json['productsSold'] ?? json['data'] ?? json['items'] ?? json['result'];
    final list = _asListMap(raw).map(ProductSoldModel.fromJson).toList();

    return ProductSoldListResponse(
      statusCode: _status(json),
      message: _msg(json),
      productsSold: list,
    );
  }
}

/// Class representing `ProductSoldMutationResponse`.
/// Auto-generated class documentation.
class ProductSoldMutationResponse {
  final int statusCode;
  final String message;
  final ProductSoldModel? productSold;

  const ProductSoldMutationResponse({
    required this.statusCode,
    required this.message,
    required this.productSold,
  });

  factory ProductSoldMutationResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['productSold'] ??
        json['productSoldCreated'] ??
        json['productSoldUpdated'] ??
        json['newProductSold'] ??
        json['updatedProductSold'] ??
        json['data'] ??
        json['result'];

    final map = _asMap(raw);

    return ProductSoldMutationResponse(
      statusCode: _status(json),
      message: _msg(json),
      productSold: map == null ? null : ProductSoldModel.fromJson(map),
    );
  }
}

/// Class representing `ProductSoldDeleteResponse`.
/// Auto-generated class documentation.
class ProductSoldDeleteResponse {
  final int statusCode;
  final String message;
  final int? deletedId;

  const ProductSoldDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.deletedId,
  });

  factory ProductSoldDeleteResponse.fromJson(Map<String, dynamic> json) {
    final rawId = json['productSoldId'] ?? json['deletedId'] ?? json['id'];
    final id = (rawId is num) ? rawId.toInt() : int.tryParse('$rawId');

    return ProductSoldDeleteResponse(
      statusCode: _status(json),
      message: _msg(json),
      deletedId: id,
    );
  }
}
