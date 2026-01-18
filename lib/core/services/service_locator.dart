import 'package:dushka_burger/Data/data_source/remotly_datasource.dart';
import 'package:dushka_burger/Data/repositories/repo_imp.dart';
import 'package:dushka_burger/Domain/repositories/base_repo.dart';
import 'package:dushka_burger/Domain/use_cases/add_to_cart_uc.dart';
import 'package:dushka_burger/Domain/use_cases/get_addons_uc.dart';
import 'package:dushka_burger/Domain/use_cases/get_cart_uc.dart';
import 'package:dushka_burger/Domain/use_cases/get_menu_uc.dart';
import 'package:dushka_burger/Domain/use_cases/remove_from_cart_uc.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/Presentation/manager/menu_manger/menu_cubit.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_cubit.dart';
import 'package:dushka_burger/core/networking/dio_factory.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  Dio dio = DioFactory.getDio();
  if (!getIt.isRegistered<Dio>()) {
    getIt.registerLazySingleton<Dio>(() => dio);
  }

  //region repos
  getIt.registerLazySingleton<BaseRepository>(
    () => RepositoryImpl(baseRemoteDataSource: getIt()),
  );
  //endregion

  //region data sources
  getIt.registerLazySingleton<BaseRemoteDataSource>(
    () => RemoteDataSource(dio: getIt()),
  );
  //endregion

  //region use case
  getIt.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(baseRepository: getIt()),
  );
  getIt.registerLazySingleton<GetAddonsUseCase>(
    () => GetAddonsUseCase(baseRepository: getIt()),
  );
  getIt.registerLazySingleton<GetCartUseCase>(
    () => GetCartUseCase(baseRepository: getIt()),
  );
  getIt.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(baseRepository: getIt()),
  );
  getIt.registerLazySingleton<RemoveFromCartUseCase>(
    () => RemoveFromCartUseCase(baseRepository: getIt()),
  );

  //endregion

  //region cubits
  getIt.registerFactory<MenuCubit>(
    () => MenuCubit(getMenuUseCase: getIt()),
  );
  getIt.registerFactory<AddonsCubit>(
    () => AddonsCubit(getAddonsUseCase: getIt()),
  );
  getIt.registerFactory<CartCubit>(
    () => CartCubit(
      getCartUseCase: getIt(),
      addToCartUseCase: getIt(),
      removeFromCartUseCase: getIt(),
    ),
  );
  //endregion
}
