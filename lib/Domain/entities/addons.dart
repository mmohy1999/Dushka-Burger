import 'package:dushka_burger/core/utils/extentions.dart';

class AddonsResponse {
  final AddonsProduct? product;
  final List<AddonBlock> blocks;

  AddonsResponse({required this.product, required this.blocks});

  factory AddonsResponse.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'];
    return AddonsResponse(
      product: productJson is Map<String, dynamic>
          ? AddonsProduct.fromJson(productJson)
          : null,
      blocks: (json['blocks'] is List)
          ? (json['blocks'] as List)
              .whereType<Map<String, dynamic>>()
              .map(AddonBlock.fromJson)
              .toList()
          : <AddonBlock>[],
    );
  }
}

class AddonsProduct {
  final int id;
  final String name;
  final String nameAr;
  final String price;
  final String type;

  AddonsProduct({
    required this.id,
    required this.name,
    required this.nameAr,
    required this.price,
    required this.type,
  });

  factory AddonsProduct.fromJson(Map<String, dynamic> json) {
    return AddonsProduct(
      id: toInt(json['id']),
      name: toStringSafe(json['name']),
      nameAr: toStringSafe(json['name_ar']),
      price: toStringSafe(json['price']),
      type: toStringSafe(json['type']),
    );
  }
}

class AddonBlock {
  final String id;
  final String name;
  final List<AddonItem> addons;

  AddonBlock({
    required this.id,
    required this.name,
    required this.addons,
  });

  factory AddonBlock.fromJson(Map<String, dynamic> json) {
    return AddonBlock(
      id: toStringSafe(json['id']),
      name: toStringSafe(json['name']),
      addons: (json['addons'] is List)
          ? (json['addons'] as List)
              .whereType<Map<String, dynamic>>()
              .map(AddonItem.fromJson)
              .toList()
          : <AddonItem>[],
    );
  }
}

class AddonItem {
  final String id;
  final String title;
  final String titleAr;
  final MinMaxRules minMaxRules;
  final bool required;
  final bool isMultiChoice;
  final List<AddonOption> options;

  AddonItem({
    required this.id,
    required this.title,
    required this.titleAr,
    required this.minMaxRules,
    required this.required,
    required this.isMultiChoice,
    required this.options,
  });

  factory AddonItem.fromJson(Map<String, dynamic> json) {
    final minMaxJson = json['min_max_rules'];
    return AddonItem(
      id: toStringSafe(json['id']),
      title: toStringSafe(json['title']),
      titleAr: toStringSafe(json['title_ar']),
      minMaxRules: minMaxJson is Map<String, dynamic>
          ? MinMaxRules.fromJson(minMaxJson)
          : MinMaxRules.empty(),
      required: toBool(json['required']),
      isMultiChoice: toBool(json['IsMultiChoise']),
      options: (json['options'] is List)
          ? (json['options'] as List)
              .whereType<Map<String, dynamic>>()
              .map(AddonOption.fromJson)
              .toList()
          : <AddonOption>[],
    );
  }
}

class MinMaxRules {
  final int min;
  final int max;
  final int exact;

  const MinMaxRules({
    required this.min,
    required this.max,
    required this.exact,
  });

  factory MinMaxRules.fromJson(Map<String, dynamic> json) {
    return MinMaxRules(
      min: toInt(json['min']),
      max: toInt(json['max']),
      exact: toInt(json['exact']),
    );
  }

  factory MinMaxRules.empty() => const MinMaxRules(min: 0, max: 0, exact: 0);
}

class AddonOption {
  final int id;
  final bool selectedByDefault;
  final bool required;
  final bool addonEnabled;
  final String label;
  final String labelAr;
  final String price;
  final String priceType;
  final String priceMethod;
  final String tooltip;
  final String description;
  final String image;
  final bool showImage;
  final bool labelInCart;
  final String labelInCartOpt;

  AddonOption({
    required this.id,
    required this.selectedByDefault,
    required this.required,
    required this.addonEnabled,
    required this.label,
    required this.labelAr,
    required this.price,
    required this.priceType,
    required this.priceMethod,
    required this.tooltip,
    required this.description,
    required this.image,
    required this.showImage,
    required this.labelInCart,
    required this.labelInCartOpt,
  });

  factory AddonOption.fromJson(Map<String, dynamic> json) {
    return AddonOption(
      id: toInt(json['id']),
      selectedByDefault: toBool(json['selected_by_default']),
      required: toBool(json['required']),
      addonEnabled: toBool(json['addon_enabled']),
      label: toStringSafe(json['label']),
      labelAr: toStringSafe(json['label_ar']),
      price: toStringSafe(json['price']),
      priceType: toStringSafe(json['price_type']),
      priceMethod: toStringSafe(json['price_method']),
      tooltip: toStringSafe(json['tooltip']),
      description: toStringSafe(json['description']),
      image: toStringSafe(json['image']),
      showImage: toBool(json['show_image']),
      labelInCart: toBool(json['label_in_cart']),
      labelInCartOpt: toStringSafe(json['label_in_cart_opt']),
    );
  }
}
