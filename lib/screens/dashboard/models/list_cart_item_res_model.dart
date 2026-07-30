class ListCartResModel {
  ListCartResModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.status,
  });

  final bool? success;
  final String? message;
  final Data? data;
  final dynamic errors;
  final num? status;

  factory ListCartResModel.fromJson(Map<String, dynamic> json) {
    return ListCartResModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "errors": errors,
    "status": status,
  };
}

class Data {
  Data({required this.items, required this.itemCount, required this.summary});

  final List<Item> items;
  final num? itemCount;
  final Summary? summary;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      itemCount: json["item_count"],
      summary: json["summary"] == null
          ? null
          : Summary.fromJson(json["summary"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "items": items.map((x) => x.toJson()).toList(),
    "item_count": itemCount,
    "summary": summary?.toJson(),
  };
}

class Item {
  Item({
    required this.id,
    required this.userId,
    required this.foodItemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.foodItem,
  });

  final int? id;
  final num? userId;
  final num? foodItemId;
  final num? quantity;
  final String? unitPrice;
  final String? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FoodItem? foodItem;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      userId: json["user_id"],
      foodItemId: json["food_item_id"],
      quantity: json["quantity"],
      unitPrice: json["unit_price"],
      totalPrice: json["total_price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      foodItem: json["food_item"] == null
          ? null
          : FoodItem.fromJson(json["food_item"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "food_item_id": foodItemId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "total_price": totalPrice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "food_item": foodItem?.toJson(),
  };
}

class FoodItem {
  FoodItem({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.imagePublicId,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final num? categoryId;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? imagePublicId;
  final num? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json["id"],
      categoryId: json["category_id"],
      name: json["name"],
      description: json["description"],
      price: json["price"],
      image: json["image"],
      imagePublicId: json["image_public_id"],
      isAvailable: json["is_available"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "name": name,
    "description": description,
    "price": price,
    "image": image,
    "image_public_id": imagePublicId,
    "is_available": isAvailable,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Summary {
  Summary({
    required this.subtotal,
    required this.deliveryFee,
    required this.taxRate,
    required this.taxAmount,
    required this.total,
  });

  final num? subtotal;
  final String? deliveryFee;
  final String? taxRate;
  final num? taxAmount;
  final num? total;

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      subtotal: json["subtotal"],
      deliveryFee: json["delivery_fee"],
      taxRate: json["tax_rate"],
      taxAmount: json["tax_amount"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "subtotal": subtotal,
    "delivery_fee": deliveryFee,
    "tax_rate": taxRate,
    "tax_amount": taxAmount,
    "total": total,
  };
}
