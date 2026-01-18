import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductDetailsAddToCartBar extends StatelessWidget {
  final bool enabled;
  final VoidCallback? onPressed;

  const ProductDetailsAddToCartBar({
    super.key,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.02,
        ),
        decoration: BoxDecoration(
          color: ColorManager.brownColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: height * 0.065,

          child: ElevatedButton(
            onPressed: enabled ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primaryColor,
              disabledBackgroundColor: ColorManager.primaryColor.withOpacity(
                0.2,
              ),

              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              elevation: 0,
            ),
            child: Text(
              StringManager.addToCart.tr(),
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
