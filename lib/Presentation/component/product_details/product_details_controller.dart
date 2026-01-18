import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/addons.dart';
import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/Presentation/component/product_details/product_details_dialogs.dart';
import 'package:dushka_burger/Presentation/manager/addons_manger/addons_cubit.dart';
import 'package:dushka_burger/Presentation/manager/cart_manger/cart_cubit.dart';
import 'package:dushka_burger/core/resource_manager/app_images.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/services/service_locator.dart';
import 'package:dushka_burger/core/utils/extentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailsController {
  final VoidCallback onStateChanged;
  final bool Function() isMounted;
  late final AddonsCubit addonsCubit;

  int quantity = 1;
  final Map<String, Set<int>> selectedOptionsByAddon = {};

  ProductDetailsController({
    required this.onStateChanged,
    required this.isMounted,
  });

  void init(Product product) {
    addonsCubit = getIt<AddonsCubit>();
    addonsCubit.fetchAddons(product.id);
  }

  void dispose() {
    addonsCubit.close();
  }

  void incrementQuantity() {
    quantity += 1;
    onStateChanged();
  }

  void decrementQuantity() {
    if (quantity <= 1) return;
    quantity -= 1;
    onStateChanged();
  }

  void toggleOption(AddonItem addon, int optionIndex) {
    final selected = selectedOptionsByAddon[addon.id] ?? <int>{};
    if (addon.isMultiChoice) {
      if (selected.contains(optionIndex)) {
        selected.remove(optionIndex);
      } else {
        selected.add(optionIndex);
      }
    } else {
      selected
        ..clear()
        ..add(optionIndex);
    }
    selectedOptionsByAddon[addon.id] = selected;
    onStateChanged();
  }

  bool isOptionSelected(AddonItem addon, int optionIndex) {
    return selectedOptionsByAddon[addon.id]?.contains(optionIndex) ?? false;
  }

  bool allRequiredSelected(AddonsResponse response) {
    for (final block in response.blocks) {
      for (final addon in block.addons) {
        if (!addon.required) continue;
        final selected = selectedOptionsByAddon[addon.id];
        if (selected == null || selected.isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  List<CartRequestItem> buildCartItems(
    Product product,
    AddonsResponse response,
  ) {
    return [
      CartRequestItem(
        productId: product.id,
        quantity: quantity,
        addons: _buildSelectedAddons(response),
      ),
    ];
  }

  Future<void> handleAddToCart(
    BuildContext context,
    Product product,
    AddonsResponse response,
  ) async {
    final items = buildCartItems(product, response);
    showBlockingAnimation(context, AppImages.burgerLoadingAnimation);
    final success = await context.read<CartCubit>().addToCart(items);
    if (!isMounted()) {
      return;
    }
    final rootNavigator = Navigator.of(context, rootNavigator: true);
    if (rootNavigator.canPop()) {
      rootNavigator.pop();
    }
    if (!success) {
      return;
    }
    await showSuccessAnimation(context, AppImages.addToCartAnimation);
    if (isMounted()) {
      context.pop();
    }
  }

  List<CartRequestAddon> _buildSelectedAddons(AddonsResponse response) {
    final addons = <CartRequestAddon>[];
    for (final block in response.blocks) {
      for (final addon in block.addons) {
        final selected = selectedOptionsByAddon[addon.id];
        if (selected == null || selected.isEmpty) {
          continue;
        }
        for (final index in selected) {
          if (index < 0 || index >= addon.options.length) {
            continue;
          }
          final option = addon.options[index];
          addons.add(
            CartRequestAddon(
              id: _resolveAddonId(addon, option),
              name: _addonNameForCart(option),
              price: _addonPriceForCart(option),
            ),
          );
        }
      }
    }
    return addons;
  }

  int _resolveAddonId(AddonItem addon, AddonOption option) {
    if (option.id > 0) {
      return option.id;
    }
    return int.tryParse(addon.id) ?? 0;
  }

  String _addonNameForCart(AddonOption option) {
    final labelInCart = option.labelInCartOpt.trim();
    if (labelInCart.isNotEmpty) return labelInCart;
    final label = option.label.trim();
    if (label.isNotEmpty) return label;
    final labelAr = option.labelAr.trim();
    if (labelAr.isNotEmpty) return labelAr;
    return StringManager.addon.tr();
  }

  String _addonPriceForCart(AddonOption option) {
    final price = option.price.trim();
    if (price.isNotEmpty) return price;
    return StringManager.zero.tr();
  }

}
