class CartRequest {
  final String guestId;
  final List<CartRequestItem> items;

  CartRequest({
    required this.guestId,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'guest_id': guestId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class CartRemoveRequest {
  final String guestId;
  final int productId;
  final int quantity;

  CartRemoveRequest({
    required this.guestId,
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'guest_id': guestId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}

class CartRequestItem {
  final int productId;
  final int quantity;
  final List<CartRequestAddon>? addons;

  CartRequestItem({
    required this.productId,
    required this.quantity,
    this.addons,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'product_id': productId,
      'quantity': quantity,
    };
    final addonList = addons;
    if (addonList != null && addonList.isNotEmpty) {
      data['addons'] = addonList.map((addon) => addon.toJson()).toList();
    }
    return data;
  }
}

class CartRequestAddon {
  final int? id;
  final String name;
  final String price;

  CartRequestAddon({
    this.id,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name': name,
      'price': price,
    };
    if (id != null && id! > 0) {
      data['id'] = id;
    }
    return data;
  }
}
