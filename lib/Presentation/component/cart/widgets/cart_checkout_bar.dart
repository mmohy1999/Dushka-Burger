import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartCheckoutBar extends StatelessWidget {
  final bool enabled;

  const CartCheckoutBar({super.key, required this.enabled});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.018,
        ),
        decoration: BoxDecoration(
          color: CartColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: SizedBox(
          height: height * 0.07,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: enabled ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: CartColors.priceRed,
              disabledBackgroundColor: CartColors.priceRed.withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.05),
              ),
              elevation: 0,
            ),
            child: Text(
              StringManager.proceedToCheckout.tr(),
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
