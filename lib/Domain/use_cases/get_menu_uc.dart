import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';


class GetUserUseCase {
  final BaseRepository baseRepository;

  GetUserUseCase({required this.baseRepository});

  Future<Either<List<CategoryWithProducts>, ApiErrorModel>> getCurrentUser(
    String guestId,
  ) async {
    return await baseRepository.getMenu(guestId);
  }
}
