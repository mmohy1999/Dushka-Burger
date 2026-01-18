import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/menu_display.dart';
import 'package:dushka_burger/core/widgets/product_network_image.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/core/resource_manager/routes_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuProductCard extends StatelessWidget {
  final Product product;

  const MenuProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final imageSize = width * 0.2;
    void openProductDetails() {
      context.pushNamed(Routes.productDetails, arguments: {
        'product': product,
        'cartCubit': context.read<CartCubit>(),
      
      });
      
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(width * 0.04),
        onTap: () {
          openProductDetails();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.03,
            vertical: height * 0.012,
          ),
          child: Row(
            children: [
              Hero(
                tag: productHeroTag(product),
                child: ProductNetworkImage(
                  url: product.image,
                  size: imageSize,
                  borderRadius: BorderRadius.circular(imageSize * 0.35),
                ),
              ),
              SizedBox(width: width * 0.04),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayProductName(product),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: height * 0.008),
                    Text(
                      displayProductPrice(product),
                      style: TextStyle(
                        fontSize: width * 0.038,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: width * 0.03),
              GestureDetector(
                onTap: () {
                  openProductDetails();
                },

                child: Container(
                  width: width * 0.08,
                  height: width * 0.08,
                  decoration: const BoxDecoration(
                    color: ColorManager.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: width * 0.05,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
