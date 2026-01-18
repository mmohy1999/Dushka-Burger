import 'package:dushka_burger/core/observers/bloc_observer.dart';
import 'package:dushka_burger/core/observers/route_observer.dart';
import 'package:dushka_burger/core/resource_manager/routes_manager.dart';
import 'package:dushka_burger/core/services/navigation_service.dart';
import 'package:dushka_burger/core/services/service_locator.dart';
import 'package:dushka_burger/Presentation/manager/locale_manger/locale_cubit.dart';
import 'package:dushka_burger/Presentation/manager/locale_manger/locale_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'core/resource_manager/translations/codegen_loader.g.dart';

//
void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  await dotenv.load(fileName: ".env");
 await setupGetIt();
  Bloc.observer = MyBlocObserver();
 runApp(EasyLocalization(
      fallbackLocale: const Locale('en'),
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      assetLoader: const CodegenLoader(),
      path: 'lib/core/resource_manager/translations',
      saveLocale: true,
      child: BlocProvider(
        create: (_) => LocaleCubit(const Locale('en')),
        child: const MyApp(),
      )));
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<LocaleCubit>().sync(context.locale);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Dushka Burger',
          locale: state.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          debugShowCheckedModeBanner: false,
          navigatorObservers: [MyRouteObserver()],
          navigatorKey: NavigationService().navigatorKey,
          initialRoute: Routes.splash,
          onGenerateRoute: RouteGenerator.getRoute,
          onUnknownRoute: RouteGenerator.onUnknownRoute,
        );
      },
    );
  }
}
