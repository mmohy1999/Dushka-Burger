import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductDetailsHeader extends StatelessWidget {
  final VoidCallback onBack;
  final int cartCount;
  final String title;
  final VoidCallback? onCartTap;

  const ProductDetailsHeader({
    super.key,
    required this.onBack,
    this.cartCount = 0,
    this.title = StringManager.productDetails,
    this.onCartTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Row(
      children: [
        GestureDetector(
          onTap: onBack,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.04,
              vertical: height * 0.012,
            ),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(width * 0.08),
              border: Border.all(
                color: ColorManager.navUnselected.withOpacity(0.6),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppImages.arrowBack,
                  height: width * 0.045,
                  colorFilter: const ColorFilter.mode(
                    ColorManager.navSelected,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: width * 0.015),
                Text(
                  StringManager.back.tr(),
                  style: TextStyle(
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.navSelected,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              title.tr(),
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
                color: ColorManager.navSelected,
              ),
            ),
          ),
        ),
        _CartBadge(cartCount: cartCount, onTap: onCartTap),
      ],
    );
  }
}

class _CartBadge extends StatelessWidget {
  final int cartCount;
  final VoidCallback? onTap;

  const _CartBadge({required this.cartCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SizedBox(
            width: width * 0.11,
            height: width * 0.11,
            child: Center(
              child: SvgPicture.asset(
                AppImages.cart,
                height: width * 0.075,
                colorFilter: const ColorFilter.mode(
                  ColorManager.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          if (cartCount > 0)
            Positioned(
              right: 0,
              top: width * 0.025,
              child: Container(
                width: width * 0.045,
                height: width * 0.045,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  color: ColorManager.primaryColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  cartCount.toString(),
                  style: TextStyle(
                    fontSize: width * 0.025,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
