import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/widgets/menu_category_section.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class MenuCategoryList extends StatelessWidget {
  final List<CategoryWithProducts> categories;
  final List<GlobalKey> headerKeys;
  final GlobalKey listKey;
  final ScrollController scrollController;

  const MenuCategoryList({
    super.key,
    required this.categories,
    required this.headerKeys,
    required this.listKey,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    return ListView(
      key: listKey,
      controller: scrollController,
      padding: EdgeInsets.only(bottom: height * 0.03),
      children: List.generate(
        categories.length,
        (index) => Column(
          children: [
            MenuCategorySection(
              category: categories[index],
              headerKey: headerKeys[index],
            ),
            if (index < categories.length - 1)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Divider(
                  height: height * 0.015,
                  color: ColorManager.navSelected.withOpacity(0.5),
                  thickness: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
