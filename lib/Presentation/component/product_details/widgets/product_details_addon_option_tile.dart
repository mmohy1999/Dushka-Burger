import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/theming/app_color.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ProductDetailsAddonOptionTile extends StatelessWidget {
  final AddonItem addon;
  final AddonOption option;
  final int optionIndex;
  final int? selectedIndex;
  final bool isSelected;
  final VoidCallback onToggle;

  const ProductDetailsAddonOptionTile({
    super.key,
    required this.addon,
    required this.option,
    required this.optionIndex,
    required this.selectedIndex,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final width = context.width;
    final height = context.height;
    final isArabic = context.locale.languageCode == 'ar';
    final priceLabel = _displayAddonPrice();
    final control = addon.isMultiChoice
        ? Checkbox(
            value: isSelected,
            onChanged: (_) => onToggle(),
            activeColor: ColorManager.primaryColor,
            checkColor: Colors.white,
            side: BorderSide(
              color: ColorManager.navSelected.withOpacity(0.7),
              width: 1.5,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          )
        : Radio<int>(
            value: optionIndex,
            groupValue: selectedIndex,
            onChanged: (_) => onToggle(),
            activeColor: ColorManager.primaryColor,
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (states) => states.contains(MaterialState.selected)
                  ? ColorManager.primaryColor
                  : ColorManager.navSelected.withOpacity(0.7),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          );
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.012),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(width * 0.04),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.06,
              height: width * 0.06,
              child: Align(
                alignment: Alignment.topCenter,
                child: IgnorePointer(child: control),
              ),
            ),
            SizedBox(width: width * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _displayAddonOption(isArabic),
                    style: TextStyle(
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.navSelected,
                    ),
                  ),
                  if (priceLabel.isNotEmpty) ...[
                    SizedBox(height: height * 0.004),
                    Text(
                      priceLabel,
                      style: TextStyle(
                        fontSize: width * 0.034,
                        fontWeight: FontWeight.w600,
                        color: ColorManager.navSelected,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _displayAddonOption(bool isArabic) {
    final primary = isArabic ? option.labelAr.trim() : option.label.trim();
    if (primary.isNotEmpty) return primary;
    final fallback = isArabic ? option.label.trim() : option.labelAr.trim();
    if (fallback.isNotEmpty) return fallback;
    return StringManager.option.tr();
  }

  String _displayAddonPrice() {
    final rawPrice = option.price.trim();
    if (rawPrice.isEmpty) return '';
    final upperPrice = rawPrice.toUpperCase();
    final currencyLabel = StringManager.currencyEgp.tr().toUpperCase();
    final hasCurrency = upperPrice.contains(currencyLabel);
    final hasPlus = rawPrice.startsWith('+');
    final buffer = StringBuffer();
    if (!hasPlus) {
      buffer.write('+ ');
    }
    buffer.write(rawPrice);
    if (!hasCurrency) {
      buffer.write(' ${StringManager.currencyEgp.tr()}');
    }
    return buffer.toString();
  }
}
