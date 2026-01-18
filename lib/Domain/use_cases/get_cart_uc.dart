import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

class GetCartUseCase {
  final BaseRepository baseRepository;

  GetCartUseCase({required this.baseRepository});

  Future<Either<CartResponse, ApiErrorModel>> getCart(String guestId) async {
    return await baseRepository.getCart(guestId);
  }
}
