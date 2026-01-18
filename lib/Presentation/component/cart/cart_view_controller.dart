import 'package:dushka_burger/Domain/entities/cart.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
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

  String displayProductName(CartItem item) {
    if (item.productName.trim().isNotEmpty) return item.productName;
    if (item.productNameEn.trim().isNotEmpty) return item.productNameEn;
    if (item.productNameAr.trim().isNotEmpty) return item.productNameAr;
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
}
