import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/menu_display.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_product_card.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_section_empty.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class MenuCategorySection extends StatelessWidget {
  final CategoryWithProducts category;
  final GlobalKey headerKey;

  const MenuCategorySection({
    super.key,
    required this.category,
    required this.headerKey,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final products = category.products;
    return Padding(
      padding: EdgeInsetsDirectional.only(
        bottom: height * 0.025,
        start: width * 0.03,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            key: headerKey,
            padding: EdgeInsets.only(bottom: height * 0.0015),
            child: Text(
              displayCategoryName(category),
              style: TextStyle(
                fontSize: width * 0.05,
                fontWeight: FontWeight.w700,
                color: ColorManager.navSelected,
              ),
            ),
          ),
          if (products.isEmpty)
            const MenuSectionEmpty()
          else
            Column(
              children: List.generate(
                products.length,
                (productIndex) => Padding(
                  padding: EdgeInsets.only(top: height * 0.015),
                  child: MenuProductCard(product: products[productIndex]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
