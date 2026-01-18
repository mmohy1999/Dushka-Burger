import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_addon_option_tile.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductDetailsAddonItem extends StatelessWidget {
  final AddonItem addon;
  final bool Function(AddonItem, int) isSelected;
  final void Function(AddonItem, int) onToggle;

  const ProductDetailsAddonItem({
    super.key,
    required this.addon,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final selectedIndex =
        addon.isMultiChoice ? null : _selectedSingleChoiceIndex();
    return Container(
      color: ColorManager.brownColor,
      margin: EdgeInsets.only(bottom: height * 0.015),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: _displayAddonTitle(),
              style: TextStyle(
                fontSize: width * 0.044,
                fontWeight: FontWeight.w700,
                color: ColorManager.navSelected,
              ),
              children: [
                if (addon.required)
                  TextSpan(
                    text: StringManager.requiredIndicator.tr(),
                    style: TextStyle(
                      fontSize: width * 0.044,
                      fontWeight: FontWeight.w700,
                      color: ColorManager.primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: height * 0.01),
          for (var i = 0; i < addon.options.length; i++)
            ProductDetailsAddonOptionTile(
              addon: addon,
              option: addon.options[i],
              optionIndex: i,
              selectedIndex: selectedIndex,
              isSelected: isSelected(addon, i),
              onToggle: () => onToggle(addon, i),
            ),
        ],
      ),
    );
  }

  int? _selectedSingleChoiceIndex() {
    for (var i = 0; i < addon.options.length; i++) {
      if (isSelected(addon, i)) return i;
    }
    return null;
  }

  String _displayAddonTitle() {
    final title = addon.title.trim();
    if (title.isNotEmpty) return title;
    final titleAr = addon.titleAr.trim();
    if (titleAr.isNotEmpty) return titleAr;
    return StringManager.addon.tr();
  }
}
