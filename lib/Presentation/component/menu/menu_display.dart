import 'package:dushka_burger/Domain/entities/category.dart';
import 'package:dushka_burger/core/resource_manager/string_manager.dart';
import 'package:easy_localization/easy_localization.dart';

String displayCategoryName(
  CategoryWithProducts category, {
  required bool isArabic,
}) {
  final primary = isArabic ? category.nameAr.trim() : category.nameEn.trim();
  if (primary.isNotEmpty) {
    return primary;
  }
  final fallback = isArabic ? category.nameEn.trim() : category.nameAr.trim();
  if (fallback.isNotEmpty) {
    return fallback;
  }
  return StringManager.category.tr();
}

String displayProductName(
  Product product, {
  required bool isArabic,
}) {
  final primary = isArabic ? product.nameAr.trim() : product.nameEn.trim();
  if (primary.isNotEmpty) {
    return primary;
  }
  final fallback = product.name.trim();
  if (fallback.isNotEmpty) {
    return fallback;
  }
  final secondary = isArabic ? product.nameEn.trim() : product.nameAr.trim();
  if (secondary.isNotEmpty) {
    return secondary;
  }
  return StringManager.item.tr();
}

String displayProductPrice(Product product) {
  final num? salePrice = product.onSale && product.priceTaxSale > 0
      ? product.priceTaxSale
      : null;
  final num? basePrice = product.priceTax > 0 ? product.priceTax : null;
  final price = salePrice ?? basePrice;
  if (price != null) {
    return '${formatPrice(price)} ${StringManager.currencyEgp.tr()}';
  }
  if (product.price.isNotEmpty) {
    return '${product.price} ${StringManager.currencyEgp.tr()}';
  }
  if (product.regularPrice.isNotEmpty) {
    return '${product.regularPrice} ${StringManager.currencyEgp.tr()}';
  }
  return '';
}

String displayProductDescription(
  Product product, {
  required bool isArabic,
}) {
  final primary =
      isArabic ? product.descriptionAr.trim() : product.descriptionEn.trim();
  if (primary.isNotEmpty) {
    return primary;
  }
  final fallback = product.description.trim();
  if (fallback.isNotEmpty) {
    return fallback;
  }
  final secondary =
      isArabic ? product.descriptionEn.trim() : product.descriptionAr.trim();
  if (secondary.isNotEmpty) {
    return secondary;
  }
  return StringManager.noDescriptionAvailable.tr();
}

bool shouldGoToProductDetails(Product product) {
  final type = product.type.trim().toLowerCase();
  final hasVariations = product.variations.isNotEmpty;
  final hasAttributes =
      product.attributes.isNotEmpty || product.defaultAttributes.isNotEmpty;

  if (type.isNotEmpty && type != 'simple') {
    return true;
  }

  return hasVariations || hasAttributes;
}

String productHeroTag(Product product) => 'product-image-${product.id}';

String formatPrice(num value) {
  final double normalized = value.toDouble();
  if (normalized % 1 == 0) {
    return normalized.toStringAsFixed(0);
  }
  return normalized.toStringAsFixed(2);
}
