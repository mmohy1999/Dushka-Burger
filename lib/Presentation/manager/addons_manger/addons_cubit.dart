import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/use_cases/get_addons_uc.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddonsCubit extends Cubit<AddonsState> {
  final GetAddonsUseCase getAddonsUseCase;

  AddonsCubit({required this.getAddonsUseCase})
      : super(const AddonsInitial());

  Future<void> fetchAddons(int productId) async {
    if (productId == 0) {
      emit(AddonsLoaded(AddonsResponse(product: null, blocks: [])));
      return;
    }

    emit(const AddonsLoading());
    final result = await getAddonsUseCase.getAddons(productId);
    result.fold(
      (addons) => emit(AddonsLoaded(addons)),
      (error) => emit(AddonsError(error)),
    );
  }
}
