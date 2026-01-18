import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Presentation/component/product_details/widgets/product_details_addon_item.dart';
import 'package:flutter/material.dart';

class ProductDetailsAddonBlock extends StatelessWidget {
  final AddonBlock block;
  final bool Function(AddonItem, int) isSelected;
  final void Function(AddonItem, int) onToggle;

  const ProductDetailsAddonBlock({
    super.key,
    required this.block,
    required this.isSelected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final addon in block.addons)
          ProductDetailsAddonItem(
            addon: addon,
            isSelected: isSelected,
            onToggle: onToggle,
          ),
      ],
    );
  }
}
