import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

abstract class MenuState {
  const MenuState();
}

class MenuInitial extends MenuState {
  const MenuInitial();
}

class MenuLoading extends MenuState {
  const MenuLoading();
}

class MenuLoaded extends MenuState {
  final List<CategoryWithProducts> categories;

  const MenuLoaded(this.categories);
}

class MenuError extends MenuState {
  final ApiErrorModel error;

  const MenuError(this.error);
}
