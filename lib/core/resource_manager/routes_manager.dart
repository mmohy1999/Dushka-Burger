import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/product_details/product_details_screen.dart';
import 'package:dushka_burger/Presentation/manager/menu_manger/menu_cubit.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/core/services/service_locator.dart';
import 'package:dushka_burger/error_screen.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_screen.dart';
import 'package:dushka_burger/Presentation/layout/home_layout.dart';
import 'package:dushka_burger/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  Routes._();

  static const String splash = '/splash';
  static const String home = '/home';
  static const String cart = '/cart';
  static const String productDetails = '/product-details';
  static const String errorScreen = '/error';
}

class RouteGenerator {
  RouteGenerator._();
  static String currentContext = '';

  static Route<dynamic>? getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.errorScreen:
        currentContext = Routes.errorScreen;
        final args = settings.arguments;
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => ErrorScreen(
              errorType: args['errorType'] as ErrorType? ?? ErrorType.server,
              message: args['message'] as String?,
              onRetry: args['onRetry'] as VoidCallback?,
            ),
          );
        }
        return _unknownRoute(settings);
      case Routes.splash:
        currentContext = Routes.splash;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const SplashScreen(),
        );
      case Routes.home:
        currentContext = Routes.home;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider<CartCubit>(
                lazy: false,
                create: (context) => getIt<CartCubit>()..fetchCart(),
              ),
              BlocProvider<MenuCubit>(
                lazy: false,
                create: (context) => getIt<MenuCubit>()..fetchMenu(),
              ),
            ],
            child: const HomeLayout(),
          ),
        );
      case Routes.cart:
        currentContext = Routes.cart;
        final args = settings.arguments;
        if (args is CartCubit) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                BlocProvider.value(value: args, child: const CartScreen()),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<CartCubit>(
            lazy: false,
            create: (context) => getIt<CartCubit>()..fetchCart(),
            child: const CartScreen(),
          ),
        );

      case Routes.productDetails:
        currentContext = Routes.productDetails;
        final args = settings.arguments as Map<String, dynamic>;
        Product? product;
        CartCubit? cartCubit;
        final rawProduct = args['product'];
        if (rawProduct is Product) {
          product = rawProduct;
        }
        final rawCartCubit = args['cartCubit'];
        if (rawCartCubit is CartCubit) {
          cartCubit = rawCartCubit;
        }
        final screen = ProductDetailsScreen(product: product!);
        if (cartCubit != null) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) =>
                BlocProvider.value(value: cartCubit!, child: screen),
          );
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => BlocProvider<CartCubit>(
            lazy: false,
            create: (context) => getIt<CartCubit>()..fetchCart(),
            child: screen,
          ),
        );

      default:
        return null;
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return _unknownRoute(settings);
  }

  static Route<dynamic> _unknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ErrorScreen(errorType: ErrorType.notFound),
    );
  }
}
