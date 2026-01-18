import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartCouponRow extends StatelessWidget {
  const CartCouponRow({super.key});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: height * 0.07,
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            decoration: BoxDecoration(
              color: CartColors.background,
              borderRadius: BorderRadius.circular(width * 0.06),
              border: Border.all(
                color: CartColors.inputBorder,
                width: 1.2,
              ),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: StringManager.enterCouponHint.tr(),
                hintStyle: TextStyle(
                  fontSize: width * 0.038,
                  color: CartColors.textMuted,
                ),
                suffixIcon: Icon(
                  Icons.delete_outline,
                  color: CartColors.applyPink.withOpacity(0.9),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(
                  top: height * 0.018,
                  bottom: height * 0.018,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: width * 0.03),
        SizedBox(
          height: height * 0.07,
          child: ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              backgroundColor: CartColors.applyPink,
              disabledBackgroundColor: CartColors.applyPink,
              foregroundColor: CartColors.priceRed,
              disabledForegroundColor: CartColors.priceRed,
              padding: EdgeInsets.symmetric(horizontal: width * 0.07),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.06),
              ),
              elevation: 0,
            ),
            child: Text(
              StringManager.apply.tr(),
              style: TextStyle(
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
