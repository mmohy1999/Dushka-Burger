import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String get apiBaseUrl =>
      dotenv.env['BASE_URL'] ?? '';

  static const String guestIdPath = 'guestcart/v1/guestid';
  static const String cartPath = 'guestcart/v1/cart';
  static String cart(String guestId) => '$cartPath?guest_id=$guestId';
  static const String categories = 'custom-api/v1/categories';

  static String addons(int productId) =>
      'proaddon/v1/get2/?product_id2=$productId';


  static String? get basicAuthHeader {
    final username = dotenv.env['BASIC_AUTH_USERNAME'];
    final password = dotenv.env['BASIC_AUTH_PASSWORD'];
    final encoded = base64Encode(utf8.encode('$username:$password'));
    return 'Basic $encoded';
  }
}
