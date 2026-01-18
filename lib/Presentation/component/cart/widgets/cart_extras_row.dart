import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class CartExtrasRow extends StatelessWidget {
  final List<String> extras;

  const CartExtrasRow({super.key, required this.extras});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        for (var i = 0; i < extras.length; i++) ...[
          Text(
            extras[i],
            style: TextStyle(
              fontSize: width * 0.032,
              fontWeight: FontWeight.w500,
              color: CartColors.textMuted,
            ),
          ),
          if (i != extras.length - 1)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.016),
              child: Container(
                width: 1,
                height: width * 0.04,
                color: CartColors.divider,
              ),
            ),
        ],
      ],
    );
  }
}
