import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/menu/menu_display.dart';
import 'package:dushka_burger/core/widgets/product_network_image.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';

class MenuCategoryStrip extends StatelessWidget {
  final List<CategoryWithProducts> categories;
  final int selectedIndex;
  final List<GlobalKey> chipKeys;
  final ScrollController scrollController;
  final ValueChanged<int> onCategoryTap;

  const MenuCategoryStrip({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.chipKeys,
    required this.scrollController,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;

    final chipHeight = height * 0.06; 
    final imageSize = width * 0.085;

    final unselectedBg = ColorManager.primaryColor.withOpacity(
      0.10,
    ); 
    final selectedBg = ColorManager.primaryColor;

    return SizedBox(
      height: chipHeight,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.zero,
        separatorBuilder: (_, __) => SizedBox(width: width * 0.025),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == selectedIndex;

          return Container(
            key: chipKeys[index],
            child: GestureDetector(
              onTap: () => onCategoryTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.03,
                  vertical: chipHeight * 0.18,
                ),
                margin: index == 0
                    ? EdgeInsetsDirectional.only(start: width * 0.03)
                    : null,
                decoration: BoxDecoration(
                  color: isSelected ? selectedBg : unselectedBg,
                  borderRadius: BorderRadius.circular(width * 0.10),
                  border: Border.all(
                    color: Colors.transparent, 
                    width: 0,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: width * 0.03,
                            offset: Offset(0, height * 0.003),
                          ),
                        ]
                      : [], 
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   
                    Container(
                      width: imageSize,
                      height: imageSize,
                      padding: EdgeInsets.all(imageSize * 0.12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? const Color(0xFF2B2B2B)
                            : Colors.transparent,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: ProductNetworkImage(
                          url: category.image,
                          size: imageSize,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      displayCategoryName(category),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : ColorManager.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
