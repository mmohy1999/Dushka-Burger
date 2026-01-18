import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartHeader extends StatelessWidget {
  final VoidCallback? onBack;

  const CartHeader({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final backWidth = width * 0.25;
    return Row(
      children: [
        GestureDetector(
          onTap: onBack ?? context.pop,
          child: Container(
            width: backWidth,
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: height * 0.011,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width * 0.1),
              border: Border.all(
                color: CartColors.inputBorder,
                width: 1.2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: width * 0.042,
                  color: CartColors.textPrimary,
                ),
                SizedBox(width: width * 0.012),
                Text(
                  StringManager.back.tr(),
                  style: TextStyle(
                    fontSize: width * 0.04,
                    fontWeight: FontWeight.w600,
                    color: CartColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              StringManager.yourCart.tr(),
              style: TextStyle(
                fontSize: width * 0.052,
                fontWeight: FontWeight.w700,
                color: CartColors.textPrimary,
              ),
            ),
          ),
        ),
        SizedBox(width: backWidth),
      ],
    );
  }
}
