import 'package:dushka_burger/Presentation/component/cart/cart_loaded_view.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_checkout_bar.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_state.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  final VoidCallback? onBack;

  const CartScreen({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Scaffold(
      backgroundColor: CartColors.background,
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is CartError) {
              return Center(
                child: Text(
                  state.error.message ?? StringManager.genericError.tr(),
                  style: TextStyle(
                    fontSize: width * 0.04,
                    color: CartColors.textPrimary,
                  ),
                ),
              );
            }
            if (state is CartLoaded) {
              return CartLoadedView(
                cart: state.response,
                onBack: onBack,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.response.items.isNotEmpty) {
            return const CartCheckoutBar(enabled: true);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
