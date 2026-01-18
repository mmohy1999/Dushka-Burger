import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_view_controller.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_item_tile.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class CartItemList extends StatelessWidget {
  final List<CartItem> items;
  final CartViewController controller;

  const CartItemList({
    super.key,
    required this.items,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final height = context.height;
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          CartItemTile(
            item: items[i],
            controller: controller,
          ),
          if (i != items.length - 1)
            Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.018),
              child: Divider(
                color: CartColors.divider,
                height: 1,
              ),
            ),
        ],
      ],
    );
  }
}
