import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_view_controller.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_coupon_row.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_empty_state.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_header.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_item_list.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_payment_details.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartLoadedView extends StatelessWidget {
  final CartResponse cart;
  final VoidCallback? onBack;

  const CartLoadedView({
    super.key,
    required this.cart,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final controller = const CartViewController();
    final emptyMessage =
        cart.message.isNotEmpty ? cart.message : StringManager.cartEmpty.tr();
    if (cart.items.isEmpty) {
      return CartEmptyState(message: emptyMessage);
    }
    final width = context.width;
    final height = context.height;
    final totalPrice =
        '${StringManager.currencyEgp.tr()} ${controller.fallbackMoney(cart.totalPrice)}';
    final vat =
        '${StringManager.currencyEgp.tr()} ${controller.fallbackMoney(cart.vat)}';
    final totalPayment =
        '${StringManager.currencyEgp.tr()} ${controller.fallbackMoney(cart.totalPriceWithTax)}';
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.05,
        vertical: height * 0.018,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CartHeader(onBack: onBack),
          SizedBox(height: height * 0.02),
          CartItemList(items: cart.items, controller: controller),
          SizedBox(height: height * 0.028),
          const CartCouponRow(),
          SizedBox(height: height * 0.035),
          CartPaymentDetails(
            totalPrice: totalPrice,
            vat: vat,
            totalPayment: totalPayment,
          ),
          SizedBox(height: height * 0.12),
        ],
      ),
    );
  }
}
