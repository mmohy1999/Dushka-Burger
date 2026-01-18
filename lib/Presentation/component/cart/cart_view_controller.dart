import 'package:dushka_burger/Data/models/cart.dart';
import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:dushka_burger/core/services/logger_service.dart';
import 'package:easy_localization/easy_localization.dart';

class CartViewController {
  const CartViewController();

  List<String> extractAddonLabels(List<dynamic> addons) {
    final labels = <String>[];
    for (final addon in addons) {
      if (addon is String && addon.trim().isNotEmpty) {
        labels.add(addon.trim());
      } else if (addon is Map) {
        final name =
            addon['name'] ?? addon['label'] ?? addon['title'] ?? addon['value'];
        if (name is String && name.trim().isNotEmpty) {
          labels.add(name.trim());
        }
      }
    }
    return labels;
  }

  String displayProductName(CartItem item, {required bool isArabic}) {
    final primary = isArabic
        ? item.productNameAr.trim()
        : item.productNameEn.trim();
    if (primary.isNotEmpty) return primary;
    final fallback = item.productName.trim();
    if (fallback.isNotEmpty) return fallback;
    final secondary = isArabic
        ? item.productNameEn.trim()
        : item.productNameAr.trim();
    if (secondary.isNotEmpty) return secondary;
    return StringManager.item.tr();
  }

  String displayItemPrice(CartItem item) {
    if (item.total.trim().isNotEmpty) return item.total;
    if (item.price.trim().isNotEmpty) return item.price;
    return StringManager.zero.tr();
  }

  String fallbackMoney(String value) {
    if (value.trim().isNotEmpty) return value;
    return StringManager.zero.tr();
  }

  List<CartRequestAddon> convertToCartRequestAddon(List addons) {
    final List<CartRequestAddon> addonList = [];
    addons.forEach((addon) {
      LoggerService.logError('addon: $addon');
      addonList.add(
        CartRequestAddon(
          id: addon['id'],
          name: addon['name'],
          price: addon['price'],
        ),
      );
    });
    return addonList;
  }
}
