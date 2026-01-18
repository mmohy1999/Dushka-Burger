import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

class GetAddonsUseCase {
  final BaseRepository baseRepository;

  GetAddonsUseCase({required this.baseRepository});

  Future<Either<AddonsResponse, ApiErrorModel>> getAddons(
    int productId,
  ) async {
    return await baseRepository.getAddons(productId);
  }
}
