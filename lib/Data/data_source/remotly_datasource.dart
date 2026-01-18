import 'package:dio/dio.dart';
import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';
import 'package:dushka_burger/core/services/logger_service.dart';

import '../../../../core/networking/api_constants.dart';

abstract class BaseRemoteDataSource {
  Future<List<CategoryWithProducts>> getMenu(String guestId);
  Future<AddonsResponse> getAddons(int productId);
  Future<CartResponse> getCart(String guestId);
  Future<CartWriteResponse> addToCart(CartRequest request);
  Future<CartWriteResponse> removeFromCart(CartRemoveRequest request);
}

class RemoteDataSource extends BaseRemoteDataSource {
  final Dio dio;
  RemoteDataSource({required this.dio});

  @override
  Future<List<CategoryWithProducts>> getMenu(String guestId) async {
    try {
      final response = await dio.get(ApiConstants.categories);

      final List jsonData = response.data;

      List<CategoryWithProducts> categories = [];

      for (var element in jsonData) {
        LoggerService.logInfo(
          '${element['name_en'].toString()} ${element['name_ar'].toString()}',
        );
        categories.add(CategoryWithProducts.fromJson(element));
      }
      if (categories.isNotEmpty) {
        return categories;
      }
      throw 'Error fetching categories';
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        throw ApiErrorModel.fromJson(errorResponse);
      }
      throw ApiErrorModel(message: e.message);
    }
  }

  @override
  Future<AddonsResponse> getAddons(int productId) async {
    try {
      final response = await dio.get(ApiConstants.addons(productId));
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return AddonsResponse.fromJson(data);
      }
      throw 'Unexpected addons response format';
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        throw ApiErrorModel.fromJson(errorResponse);
      }
      throw ApiErrorModel(message: e.message);
    }
  }

  @override
  Future<CartResponse> getCart(String guestId) async {
    try {
      final response = await dio.get(ApiConstants.cart(guestId));
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return CartResponse.fromJson(data);
      }
      throw 'Unexpected cart response format';
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        throw ApiErrorModel.fromJson(errorResponse);
      }
      throw ApiErrorModel(message: e.message);
    }
  }

  @override
  Future<CartWriteResponse> addToCart(CartRequest request) async {
    try {
      final response = await dio.post(
        ApiConstants.cartPath,
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return CartWriteResponse.fromJson(data);
      }
      throw 'Unexpected cart write response format';
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        throw ApiErrorModel.fromJson(errorResponse);
      }
      throw ApiErrorModel(message: e.message);
    }
  }

  @override
  Future<CartWriteResponse> removeFromCart(CartRemoveRequest request) async {
    try {
      final response = await dio.delete(
        ApiConstants.cartPath,
        data: request.toJson(),
      );
      final data = response.data;
      if (data is Map<String, dynamic>) {
        return CartWriteResponse.fromJson(data);
      }
      throw 'Unexpected cart remove response format';
    } on DioException catch (e) {
      final errorResponse = e.response?.data;
      if (errorResponse is Map<String, dynamic>) {
        throw ApiErrorModel.fromJson(errorResponse);
      }
      throw ApiErrorModel(message: e.message);
    }
  }
}
