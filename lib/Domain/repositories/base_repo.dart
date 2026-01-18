import 'package:dartz/dartz.dart';
import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/category.dart';

import '../../../../core/networking/api_error_model.dart';


abstract class BaseRepository {

   Future<Either<List<CategoryWithProducts>, ApiErrorModel>> getMenu(
     String guestId,
   );
   Future<Either<AddonsResponse, ApiErrorModel>> getAddons(int productId);
   Future<Either<CartResponse, ApiErrorModel>> getCart(String guestId);
   Future<Either<CartWriteResponse, ApiErrorModel>> addToCart(
     CartRequest request,
   );
   Future<Either<CartWriteResponse, ApiErrorModel>> removeFromCart(
     CartRemoveRequest request,
   );

}
