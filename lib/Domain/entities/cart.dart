import 'package:dushka_burger/core/utils/extentions.dart';

class CartResponse {
  final List<CartItem> items;
  final String totalPrice;
  final String vat;
  final String totalPriceWithTax;
  final int totalItems;
  final String totalPoints;
  final String message;
  final String guestId;

  CartResponse({
    required this.items,
    required this.totalPrice,
    required this.vat,
    required this.totalPriceWithTax,
    required this.totalItems,
    required this.totalPoints,
    required this.message,
    required this.guestId,
  });

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final itemsJson = json['cart_items'];
    return CartResponse(
      items: (itemsJson is List)
          ? itemsJson
              .whereType<Map<String, dynamic>>()
              .map(CartItem.fromJson)
              .toList()
          : <CartItem>[],
      totalPrice: toStringSafe(json['total_price']),
      vat: toStringSafe(json['VAT']),
      totalPriceWithTax: toStringSafe(json['total_price_with_tax']),
      totalItems: toInt(json['total_items']),
      totalPoints: toStringSafe(json['total_points']),
      message: toStringSafe(json['message']),
      guestId: toStringSafe(json['guest_id']),
    );
  }
}

class CartWriteResponse {
  final String message;
  final String guestId;

  CartWriteResponse({
    required this.message,
    required this.guestId,
  });

  factory CartWriteResponse.fromJson(Map<String, dynamic> json) {
    return CartWriteResponse(
      message: toStringSafe(json['message']),
      guestId: toStringSafe(json['guest_id']),
    );
  }
}

class CartItem {
  final int productId;
  final String productName;
  final String productNameEn;
  final String productNameAr;
  final int quantity;
  final String price;
  final String addonPrice;
  final String image;
  final List<dynamic> addons;
  final String points;
  final String total;

  CartItem({
    required this.productId,
    required this.productName,
    required this.productNameEn,
    required this.productNameAr,
    required this.quantity,
    required this.price,
    required this.addonPrice,
    required this.image,
    required this.addons,
    required this.points,
    required this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: toInt(json['product_id']),
      productName: toStringSafe(json['product_name']),
      productNameEn: toStringSafe(json['product_name_en']),
      productNameAr: toStringSafe(json['product_name_ar']),
      quantity: toInt(json['quantity']),
      price: toStringSafe(json['price']),
      addonPrice: toStringSafe(json['addon_price']),
      image: toStringSafe(json['image']),
      addons: (json['addons'] is List) ? json['addons'] as List : <dynamic>[],
      points: toStringSafe(json['points']),
      total: toStringSafe(json['total']),
    );
  }
}
