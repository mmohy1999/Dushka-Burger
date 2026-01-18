import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/menu_display.dart';
import 'package:dushka_burger/core/widgets/product_network_image.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_extras_section.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_header.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_quantity_control.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_state.dart';
import 'package:dushka_burger/core/resource_manager/routes_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsContent extends StatelessWidget {
  final Product product;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final bool Function(AddonItem, int) isSelected;
  final void Function(AddonItem, int) onToggle;

  const ProductDetailsContent({
    super.key,
    required this.product,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final imageSize = width * 0.7;
    return SafeArea(
      child: Column(
        children: [
          _HeaderBar(
            onBack: context.pop,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorManager.brownColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04,
                      vertical: height * 0.02,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Hero(
                            tag: productHeroTag(product),
                            child: ProductNetworkImage(
                              url: product.image,
                              size: imageSize,
                              borderRadius: BorderRadius.circular(
                                imageSize * 0.2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.03),
                        Text(
                          displayProductName(product),
                          style: TextStyle(
                            fontSize: width * 0.06,
                            fontWeight: FontWeight.w700,
                            color: ColorManager.navSelected,
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              displayProductPrice(product),
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            ProductDetailsQuantityControl(
                              quantity: quantity,
                              onIncrement: onIncrement,
                              onDecrement: onDecrement,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(height: height * 0.015),
                  Container(
                    width: double.infinity,
                    color: ColorManager.brownColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.045,
                      vertical: height * 0.018,
                    ),
                    child: Text(
                      displayProductDescription(product),
                      style: TextStyle(
                        fontSize: width * 0.038,
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(height: height * 0.015),
                  ProductDetailsExtrasSection(
                    isSelected: isSelected,
                    onToggle: onToggle,
                  ),
                  SizedBox(height: height * 0.015),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderBar extends StatelessWidget {
  final VoidCallback onBack;

  const _HeaderBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    return Container(
      color: ColorManager.brownColor,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cartCount =
              state is CartLoaded ? state.response.totalItems : 0;
          return ProductDetailsHeader(
            onBack: onBack,
            cartCount: cartCount,
            onCartTap: () {
              context.pushNamed(
                Routes.cart,
                arguments: context.read<CartCubit>(),
              );
            },
          );
        },
      ),
    );
  }
}
