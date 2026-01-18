import 'package:dushka_burger/core/utils/extentions.dart';

/// Parse the whole response:
/// final categories = (jsonList as List).map((e) => CategoryWithProducts.fromJson(e)).toList();
class CategoryWithProducts {
  final int id;
  final String nameEn;
  final String nameAr;
  final String image;
  final List<Product> products;

  CategoryWithProducts({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.image,
    required this.products,
  });

  factory CategoryWithProducts.fromJson(Map<String, dynamic> json) {
    return CategoryWithProducts(
      id: toInt(json['id']),
      nameEn: (json['name_en'] ?? '').toString(),
      nameAr: (json['name_ar'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),
      products: (json['products'] is List)
          ? (json['products'] as List)
              .whereType<Map<String, dynamic>>()
              .map(Product.fromJson)
              .toList()
          : <Product>[],
    );
  }
}

class Product {
  final int id;
  final String name;
  final String slug;

  final WooDateTime? dateCreated;
  final WooDateTime? dateModified;

  final String status;
  final bool featured;
  final String catalogVisibility;

  final String description;
  final String shortDescription;

  final String sku;
  final String globalUniqueId;

  final String price;
  final String regularPrice;
  final String salePrice;

  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleTo;

  final int totalSales;

  final String taxStatus;
  final String taxClass;

  final bool manageStock;
  final int? stockQuantity;
  final String stockStatus;
  final String backorders;

  final String lowStockAmount;
  final bool soldIndividually;

  final String weight;
  final String length;
  final String width;
  final String height;

  final List<int> upsellIds;
  final List<int> crossSellIds;

  final int parentId;

  final bool reviewsAllowed;
  final String purchaseNote;

  /// IMPORTANT: in your API this can be [] OR { ... }
  /// so we normalize it to Map<String, dynamic>
  final Map<String, dynamic> attributes;

  final List<dynamic> defaultAttributes;

  final int menuOrder;

  final String postPassword;

  final bool virtual;
  final bool downloadable;

  final List<int> categoryIds;
  final List<int> tagIds;
  final List<int> brandIds;

  final int shippingClassId;

  final List<dynamic> downloads;

  final String imageId;
  final List<int> galleryImageIds;

  final int downloadLimit;
  final int downloadExpiry;

  final List<dynamic> ratingCounts;
  final String averageRating;
  final int reviewCount;

  final dynamic cogsValue;

  final List<MetaDataItem> metaData;

  // Extra localized / computed fields
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String image;

  final num priceTax;
  final num priceTaxSale;
  final int points;
  final bool onSale;

  final List<int> relatedIds;

  final String type;

  /// Some products have variations (type=variable)
  final List<ProductVariation> variations;

  /// Some products have related_products
  final List<int> relatedProducts;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.dateCreated,
    required this.dateModified,
    required this.status,
    required this.featured,
    required this.catalogVisibility,
    required this.description,
    required this.shortDescription,
    required this.sku,
    required this.globalUniqueId,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleTo,
    required this.totalSales,
    required this.taxStatus,
    required this.taxClass,
    required this.manageStock,
    required this.stockQuantity,
    required this.stockStatus,
    required this.backorders,
    required this.lowStockAmount,
    required this.soldIndividually,
    required this.weight,
    required this.length,
    required this.width,
    required this.height,
    required this.upsellIds,
    required this.crossSellIds,
    required this.parentId,
    required this.reviewsAllowed,
    required this.purchaseNote,
    required this.attributes,
    required this.defaultAttributes,
    required this.menuOrder,
    required this.postPassword,
    required this.virtual,
    required this.downloadable,
    required this.categoryIds,
    required this.tagIds,
    required this.brandIds,
    required this.shippingClassId,
    required this.downloads,
    required this.imageId,
    required this.galleryImageIds,
    required this.downloadLimit,
    required this.downloadExpiry,
    required this.ratingCounts,
    required this.averageRating,
    required this.reviewCount,
    required this.cogsValue,
    required this.metaData,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.image,
    required this.priceTax,
    required this.priceTaxSale,
    required this.points,
    required this.onSale,
    required this.relatedIds,
    required this.type,
    required this.variations,
    required this.relatedProducts,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      slug: (json['slug'] ?? '').toString(),

      dateCreated: (json['date_created'] is Map<String, dynamic>)
          ? WooDateTime.fromJson(json['date_created'] as Map<String, dynamic>)
          : null,
      dateModified: (json['date_modified'] is Map<String, dynamic>)
          ? WooDateTime.fromJson(json['date_modified'] as Map<String, dynamic>)
          : null,

      status: (json['status'] ?? '').toString(),
      featured: toBool(json['featured']),
      catalogVisibility: (json['catalog_visibility'] ?? '').toString(),

      description: (json['description'] ?? '').toString(),
      shortDescription: (json['short_description'] ?? '').toString(),

      sku: (json['sku'] ?? '').toString(),
      globalUniqueId: (json['global_unique_id'] ?? '').toString(),

      price: (json['price'] ?? '').toString(),
      regularPrice: (json['regular_price'] ?? '').toString(),
      salePrice: (json['sale_price'] ?? '').toString(),

      dateOnSaleFrom: json['date_on_sale_from'],
      dateOnSaleTo: json['date_on_sale_to'],

      totalSales: toInt(json['total_sales']),

      taxStatus: (json['tax_status'] ?? '').toString(),
      taxClass: (json['tax_class'] ?? '').toString(),

      manageStock: toBool(json['manage_stock']),
      stockQuantity: json['stock_quantity'] == null
          ? null
          : toInt(json['stock_quantity']),
      stockStatus: (json['stock_status'] ?? '').toString(),
      backorders: (json['backorders'] ?? '').toString(),

      lowStockAmount: (json['low_stock_amount'] ?? '').toString(),
      soldIndividually: toBool(json['sold_individually']),

      weight: (json['weight'] ?? '').toString(),
      length: (json['length'] ?? '').toString(),
      width: (json['width'] ?? '').toString(),
      height: (json['height'] ?? '').toString(),

      upsellIds: toIntList(json['upsell_ids']),
      crossSellIds: toIntList(json['cross_sell_ids']),

      parentId: toInt(json['parent_id']),

      reviewsAllowed: toBool(json['reviews_allowed']),
      purchaseNote: (json['purchase_note'] ?? '').toString(),

      // FIX: attributes can be [] or { ... }
      attributes: toMap(json['attributes']),

      defaultAttributes: (json['default_attributes'] is List)
          ? (json['default_attributes'] as List)
          : <dynamic>[],

      menuOrder: toInt(json['menu_order']),
      postPassword: (json['post_password'] ?? '').toString(),

      virtual: toBool(json['virtual']),
      downloadable: toBool(json['downloadable']),

      categoryIds: toIntList(json['category_ids']),
      tagIds: toIntList(json['tag_ids']),
      brandIds: toIntList(json['brand_ids']),

      shippingClassId: toInt(json['shipping_class_id']),

      downloads: (json['downloads'] is List)
          ? (json['downloads'] as List)
          : <dynamic>[],

      imageId: (json['image_id'] ?? '').toString(),
      galleryImageIds: toIntList(json['gallery_image_ids']),

      downloadLimit: toInt(json['download_limit']),
      downloadExpiry: toInt(json['download_expiry']),

      ratingCounts: (json['rating_counts'] is List)
          ? (json['rating_counts'] as List)
          : <dynamic>[],
      averageRating: (json['average_rating'] ?? '0').toString(),
      reviewCount: toInt(json['review_count']),

      cogsValue: json['cogs_value'],

      metaData: (json['meta_data'] is List)
          ? (json['meta_data'] as List)
              .whereType<Map<String, dynamic>>()
              .map(MetaDataItem.fromJson)
              .toList()
          : <MetaDataItem>[],

      nameEn: (json['name_en'] ?? '').toString(),
      nameAr: (json['name_ar'] ?? '').toString(),
      descriptionEn: (json['description_en'] ?? '').toString(),
      descriptionAr: (json['description_ar'] ?? '').toString(),
      image: (json['image'] ?? '').toString(),

      priceTax: toNum(json['price_tax']),
      priceTaxSale: toNum(json['price_tax_sale']),
      points: toInt(json['points']),
      onSale: toBool(json['on_sale']),

      relatedIds: toIntList(json['related_ids']),
      type: (json['type'] ?? '').toString(),

      variations: (json['variations'] is List)
          ? (json['variations'] as List)
              .whereType<Map<String, dynamic>>()
              .map(ProductVariation.fromJson)
              .toList()
          : <ProductVariation>[],

      relatedProducts: toIntList(json['related_products']),
    );
  }
}

class ProductVariation {
  final int id;
  final String name;
  final String slug;

  final WooDateTime? dateCreated;
  final WooDateTime? dateModified;

  final String status;
  final String catalogVisibility;

  final String description;

  final String price;
  final String regularPrice;
  final String salePrice;

  final dynamic dateOnSaleFrom;
  final dynamic dateOnSaleTo;

  final int parentId;

  /// In variations: attributes is always Map like {"pa_size":"single"}
  final Map<String, dynamic> attributes;

  final int menuOrder;

  final String attributeSummary;

  final List<MetaDataItem> metaData;

  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;

  final num priceTax;
  final num priceTaxSale;
  final int points;

  ProductVariation({
    required this.id,
    required this.name,
    required this.slug,
    required this.dateCreated,
    required this.dateModified,
    required this.status,
    required this.catalogVisibility,
    required this.description,
    required this.price,
    required this.regularPrice,
    required this.salePrice,
    required this.dateOnSaleFrom,
    required this.dateOnSaleTo,
    required this.parentId,
    required this.attributes,
    required this.menuOrder,
    required this.attributeSummary,
    required this.metaData,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.priceTax,
    required this.priceTaxSale,
    required this.points,
  });

  factory ProductVariation.fromJson(Map<String, dynamic> json) {
    return ProductVariation(
      id: toInt(json['id']),
      name: (json['name'] ?? '').toString(),
      slug: (json['slug'] ?? '').toString(),

      dateCreated: (json['date_created'] is Map<String, dynamic>)
          ? WooDateTime.fromJson(json['date_created'] as Map<String, dynamic>)
          : null,
      dateModified: (json['date_modified'] is Map<String, dynamic>)
          ? WooDateTime.fromJson(json['date_modified'] as Map<String, dynamic>)
          : null,

      status: (json['status'] ?? '').toString(),
      catalogVisibility: (json['catalog_visibility'] ?? '').toString(),

      description: (json['description'] ?? '').toString(),

      price: (json['price'] ?? '').toString(),
      regularPrice: (json['regular_price'] ?? '').toString(),
      salePrice: (json['sale_price'] ?? '').toString(),

      dateOnSaleFrom: json['date_on_sale_from'],
      dateOnSaleTo: json['date_on_sale_to'],

      parentId: toInt(json['parent_id']),

      attributes: toMap(json['attributes']),
      menuOrder: toInt(json['menu_order']),

      attributeSummary: (json['attribute_summary'] ?? '').toString(),

      metaData: (json['meta_data'] is List)
          ? (json['meta_data'] as List)
              .whereType<Map<String, dynamic>>()
              .map(MetaDataItem.fromJson)
              .toList()
          : <MetaDataItem>[],

      nameEn: (json['name_en'] ?? '').toString(),
      nameAr: (json['name_ar'] ?? '').toString(),
      descriptionEn: (json['description_en'] ?? '').toString(),
      descriptionAr: (json['description_ar'] ?? '').toString(),

      priceTax: toNum(json['price_tax']),
      priceTaxSale: toNum(json['price_tax_sale']),
      points: toInt(json['points']),
    );
  }
}

class WooDateTime {
  final String date;
  final int timezoneType;
  final String timezone;

  WooDateTime({
    required this.date,
    required this.timezoneType,
    required this.timezone,
  });

  factory WooDateTime.fromJson(Map<String, dynamic> json) {
    return WooDateTime(
      date: (json['date'] ?? '').toString(),
      timezoneType: toInt(json['timezone_type']),
      timezone: (json['timezone'] ?? '').toString(),
    );
  }
}

class MetaDataItem {
  final int id;
  final String key;
  final dynamic value;

  MetaDataItem({required this.id, required this.key, required this.value});

  factory MetaDataItem.fromJson(Map<String, dynamic> json) {
    return MetaDataItem(
      id: toInt(json['id']),
      key: (json['key'] ?? '').toString(),
      value: json['value'],
    );
  }
}
