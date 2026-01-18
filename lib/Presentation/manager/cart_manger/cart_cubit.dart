import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/use_cases/add_to_cart_uc.dart';
import 'package:dushka_burger/Domain/use_cases/get_cart_uc.dart';
import 'package:dushka_burger/Domain/use_cases/remove_from_cart_uc.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_state.dart';
import 'package:dushka_burger/core/helper/guest_id_manager.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;

  CartCubit({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
  })
      : super(const CartInitial());

  Future<void> fetchCart({bool showLoading = true}) async {
    if (showLoading) {
      emit(const CartLoading());
    }
    try {
      final guestId = await GuestIdManager.ensureGuestId();
      final result = await getCartUseCase.getCart(guestId);
      result.fold(
        (cart) => emit(CartLoaded(cart)),
        (error) {
          if (showLoading || state is! CartLoaded) {
            emit(CartError(error));
          }
        },
      );
    } catch (e) {
      if (showLoading || state is! CartLoaded) {
        emit(CartError(ApiErrorModel(message: e.toString())));
      }
    }
  }

  Future<bool> addToCart(List<CartRequestItem> items) async {
    try {
      final guestId = await GuestIdManager.ensureGuestId();
      final request = CartRequest(guestId: guestId, items: items);
      final result = await addToCartUseCase.addToCart(request);
      return await result.fold<Future<bool>>(
        (_) async {
          await fetchCart(showLoading: false);
          return true;
        },
        (error) {
          if (state is! CartLoaded) {
            emit(CartError(error));
          }
          return Future.value(false);
        },
      );
    } catch (e) {
      if (state is! CartLoaded) {
        emit(CartError(ApiErrorModel(message: e.toString())));
      }
      return false;
    }
  }

  Future<void> removeFromCart({
    required int productId,
    int quantity = 1,
  }) async {
    try {
      final guestId = await GuestIdManager.ensureGuestId();
      final request = CartRemoveRequest(
        guestId: guestId,
        productId: productId,
        quantity: quantity,
      );
      final result = await removeFromCartUseCase.removeFromCart(request);
      await result.fold<Future<void>>(
        (_) => fetchCart(showLoading: false),
        (error) {
          if (state is! CartLoaded) {
            emit(CartError(error));
          }
          return Future.value();
        },
      );
    } catch (e) {
      if (state is! CartLoaded) {
        emit(CartError(ApiErrorModel(message: e.toString())));
      }
    }
  }
}
