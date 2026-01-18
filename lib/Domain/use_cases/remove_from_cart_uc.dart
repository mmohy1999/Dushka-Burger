import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

class RemoveFromCartUseCase {
  final BaseRepository baseRepository;

  RemoveFromCartUseCase({required this.baseRepository});

  Future<Either<CartWriteResponse, ApiErrorModel>> removeFromCart(
    CartRemoveRequest request,
  ) async {
    return await baseRepository.removeFromCart(request);
  }
}
