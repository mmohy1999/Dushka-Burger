import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Data/data_source/remotly_datasource.dart';
import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

class RepositoryImpl extends BaseRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  RepositoryImpl({required this.baseRemoteDataSource});

  @override
  Future<Either<List<CategoryWithProducts>, ApiErrorModel>> getMenu(
    String guestId,
  ) async {
    try {
      final result = await baseRemoteDataSource.getMenu(guestId);
      return Left(result);
    } on ApiErrorModel catch (e) {
      return right(e);
    } catch (e) {
      return right(ApiErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<AddonsResponse, ApiErrorModel>> getAddons(
    int productId,
  ) async {
    try {
      final result = await baseRemoteDataSource.getAddons(productId);
      return Left(result);
    } on ApiErrorModel catch (e) {
      return right(e);
    } catch (e) {
      return right(ApiErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<CartResponse, ApiErrorModel>> getCart(
    String guestId,
  ) async {
    try {
      final result = await baseRemoteDataSource.getCart(guestId);
      return Left(result);
    } on ApiErrorModel catch (e) {
      return right(e);
    } catch (e) {
      return right(ApiErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<CartWriteResponse, ApiErrorModel>> addToCart(
    CartRequest request,
  ) async {
    try {
      final result = await baseRemoteDataSource.addToCart(request);
      return Left(result);
    } on ApiErrorModel catch (e) {
      return right(e);
    } catch (e) {
      return right(ApiErrorModel(message: e.toString()));
    }
  }

  @override
  Future<Either<CartWriteResponse, ApiErrorModel>> removeFromCart(
    CartRemoveRequest request,
  ) async {
    try {
      final result = await baseRemoteDataSource.removeFromCart(request);
      return Left(result);
    } on ApiErrorModel catch (e) {
      return right(e);
    } catch (e) {
      return right(ApiErrorModel(message: e.toString()));
    }
  }
}
