import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class ProductDetailsQuantityControl extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double? buttonSize;
  final double? iconSize;
  final double? spacing;

  const ProductDetailsQuantityControl({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.buttonSize,
    this.iconSize,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final size = buttonSize ?? width * 0.115;
    final icon = iconSize ?? width * 0.058;
    final gap = spacing ?? width * 0.03;
    return Row(
      children: [
        _RoundIconButton(
          background: const Color(0xFFE2D6C7),
          icon: Icons.remove,
          iconColor: ColorManager.navSelected,
          onTap: onDecrement,
          size: size,
          iconSize: icon,
        ),
        SizedBox(width: gap),
        Text(
          quantity.toString(),
          style: TextStyle(
            fontSize: width * 0.046,
            fontWeight: FontWeight.w700,
            color: ColorManager.navSelected,
          ),
        ),
        SizedBox(width: gap),
        _RoundIconButton(
          background: ColorManager.primaryColor,
          icon: Icons.add,
          iconColor: Colors.white,
          onTap: onIncrement,
          size: size,
          iconSize: icon,
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final Color background;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;
  final double size;
  final double iconSize;

  const _RoundIconButton({
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    required this.size,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
