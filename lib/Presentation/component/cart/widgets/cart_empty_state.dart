import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CartEmptyState extends StatelessWidget {
  final String message;

  const CartEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Lottie.asset(
                AppImages.emptyAnimation,
                fit: BoxFit.contain,
                repeat: true,
              ),
            ),
            SizedBox(height: height * 0.02),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w600,
                color: CartColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
