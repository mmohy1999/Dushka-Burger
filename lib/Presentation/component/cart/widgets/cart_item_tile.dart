import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_theme.dart';
import 'package:dushka_burger/Presentation/component/cart/cart_view_controller.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_extras_row.dart';
import 'package:dushka_burger/Presentation/component/cart/widgets/cart_quantity_control.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:dushka_burger/core/widgets/product_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartItemTile extends StatelessWidget {
  final CartItem item;
  final CartViewController controller;

  const CartItemTile({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final imageSize = width * 0.19;
    final imagePadding = width * 0.012;
    final extras = controller.extractAddonLabels(item.addons);
    final displayName = controller.displayProductName(item);
    final displayPrice = controller.displayItemPrice(item);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: imageSize,
              height: imageSize,
              padding: EdgeInsets.all(imagePadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(imageSize * 0.28),
              ),
              child: ProductNetworkImage(
                url: item.image,
                size: imageSize - (imagePadding * 2),
                borderRadius: BorderRadius.circular(imageSize * 0.22),
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                      color: CartColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: height * 0.008),
                  Text(
                    '${StringManager.currencyEgp.tr()} $displayPrice',
                    style: TextStyle(
                      fontSize: width * 0.043,
                      fontWeight: FontWeight.w700,
                      color: CartColors.priceRed,
                    ),
                  ),
                ],
              ),
            ),
            CartQuantityControl(item: item),
          ],
        ),
        if (extras.isNotEmpty) ...[
          SizedBox(height: height * 0.014),
          Padding(
            padding: EdgeInsets.only(left: imageSize + (width * 0.04)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringManager.extras.tr(),
                  style: TextStyle(
                    fontSize: width * 0.036,
                    fontWeight: FontWeight.w600,
                    color: CartColors.textPrimary,
                  ),
                ),
                SizedBox(height: height * 0.006),
                CartExtrasRow(extras: extras),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
