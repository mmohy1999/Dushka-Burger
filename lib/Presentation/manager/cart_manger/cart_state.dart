import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final CartResponse response;

  const CartLoaded(this.response);
}

class CartError extends CartState {
  final ApiErrorModel error;

  const CartError(this.error);
}
