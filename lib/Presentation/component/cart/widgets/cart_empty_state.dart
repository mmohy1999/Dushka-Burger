import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class CartEmptyState extends StatelessWidget {
  final String message;

  const CartEmptyState({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: height * 0.07),
        child: Text(
          message,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w600,
            color: CartColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
