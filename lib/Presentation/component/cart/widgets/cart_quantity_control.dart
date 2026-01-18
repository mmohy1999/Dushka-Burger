import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartQuantityControl extends StatelessWidget {
  final CartItem item;

  const CartQuantityControl({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final pillHeight = width * 0.12;
    final circleSize = width * 0.085;
    final isRemove = item.quantity <= 1;
    return Container(
      height: pillHeight,
      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
      decoration: BoxDecoration(
        color: CartColors.pillBackground,
        borderRadius: BorderRadius.circular(pillHeight / 2),
        border: Border.all(color: CartColors.pillBorder, width: 1),
      ),
      child: Row(
        children: [
          _CircleIcon(
            icon: isRemove ? Icons.delete_outline : Icons.remove,
            background: const Color(0xFFF4D9DC),
            iconColor: CartColors.priceRed,
            size: circleSize,
            onTap: () {
              context.read<CartCubit>().removeFromCart(
                    productId: item.productId,
                    quantity: 1,
                  );
            },
          ),
          SizedBox(width: width * 0.018),
          Text(
            item.quantity.toString(),
            style: TextStyle(
              fontSize: width * 0.042,
              fontWeight: FontWeight.w600,
              color: CartColors.textPrimary,
            ),
          ),
          SizedBox(width: width * 0.018),
          _CircleIcon(
            icon: Icons.add,
            background: CartColors.priceRed,
            iconColor: Colors.white,
            size: circleSize,
            onTap: () {
              context.read<CartCubit>().addToCart(
                    [
                      CartRequestItem(
                        productId: item.productId,
                        quantity: 1,
                      ),
                    ],
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _CircleIcon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconColor;
  final double size;
  final VoidCallback? onTap;

  const _CircleIcon({
    required this.icon,
    required this.background,
    required this.iconColor,
    required this.size,
    this.onTap,
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
        child: Icon(icon, size: size * 0.55, color: iconColor),
      ),
    );
  }
}
