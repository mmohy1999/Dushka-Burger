import 'package:dushka_burger/Domain/use_cases/get_menu_uc.dart';
import 'package:dushka_burger/Presentation/manager/menu_manger/menu_state.dart';
import 'package:dushka_burger/core/helper/guest_id_manager.dart';
import 'package:dushka_burger/core/networking/api_error_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCubit extends Cubit<MenuState> {
  final GetUserUseCase getMenuUseCase;

  MenuCubit({required this.getMenuUseCase}) : super(const MenuInitial());

  Future<void> fetchMenu() async {
    emit(const MenuLoading());
    try {
      final guestId = await GuestIdManager.ensureGuestId();
      final result = await getMenuUseCase.getCurrentUser(guestId);
      result.fold(
        (menu) => emit(MenuLoaded(menu)),
        (error) => emit(MenuError(error)),
      );
    } catch (e) {
      emit(MenuError(ApiErrorModel(message: e.toString())));
    }
  }
}
