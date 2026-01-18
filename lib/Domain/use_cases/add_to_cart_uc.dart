import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

class AddToCartUseCase {
  final BaseRepository baseRepository;

  AddToCartUseCase({required this.baseRepository});

  Future<Either<CartWriteResponse, ApiErrorModel>> addToCart(
    CartRequest request,
  ) async {
    return await baseRepository.addToCart(request);
  }
}
