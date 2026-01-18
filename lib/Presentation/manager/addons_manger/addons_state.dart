import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';

abstract class AddonsState {
  const AddonsState();
}

class AddonsInitial extends AddonsState {
  const AddonsInitial();
}

class AddonsLoading extends AddonsState {
  const AddonsLoading();
}

class AddonsLoaded extends AddonsState {
  final AddonsResponse response;

  const AddonsLoaded(this.response);
}

class AddonsError extends AddonsState {
  final ApiErrorModel error;

  const AddonsError(this.error);
}
