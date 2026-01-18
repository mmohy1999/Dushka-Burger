import 'package:dushka_burger/Presentation/layout/widgets/home_nav_item_data.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeNavItem extends StatelessWidget {
  final HomeNavItemData item;
  final bool isSelected;
  final VoidCallback onTap;

  const HomeNavItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final iconPath = isSelected ? item.selectedIcon : item.unselectedIcon;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(width * 0.032),
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconPath, height: width * 0.066),
            SizedBox(height: height * 0.009),
            Text(
              item.label,
              style: TextStyle(
                fontSize: width * 0.035,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected
                    ? ColorManager.navSelected
                    : ColorManager.navUnselected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
