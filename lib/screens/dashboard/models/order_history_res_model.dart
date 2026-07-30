class OrderHistoryResModel {
  OrderHistoryResModel({
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

  factory OrderHistoryResModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryResModel(
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
  Data({required this.orders, required this.deliveryTime});

  final List<OrderData> orders;
  final dynamic deliveryTime;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      orders: json["orders"] == null
          ? []
          : List<OrderData>.from(
              json["orders"]!.map((x) => OrderData.fromJson(x)),
            ),
      deliveryTime: json["delivery_time"],
    );
  }

  Map<String, dynamic> toJson() => {
    "orders": orders.map((x) => x.toJson()).toList(),
    "delivery_time": deliveryTime,
  };
}

class OrderData {
  OrderData({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.totalAmount,
    required this.status,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryAddress,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  final int? id;
  final num? userId;
  final String? orderNumber;
  final String? subtotal;
  final String? deliveryFee;
  final String? tax;
  final String? totalAmount;
  final String? status;
  final String? paymentStatus;
  final String? paymentMethod;
  final String? deliveryAddress;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Item> items;

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json["id"],
      userId: json["user_id"],
      orderNumber: json["order_number"],
      subtotal: json["subtotal"],
      deliveryFee: json["delivery_fee"],
      tax: json["tax"],
      totalAmount: json["total_amount"],
      status: json["status"],
      paymentStatus: json["payment_status"],
      paymentMethod: json["payment_method"],
      deliveryAddress: json["delivery_address"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_number": orderNumber,
    "subtotal": subtotal,
    "delivery_fee": deliveryFee,
    "tax": tax,
    "total_amount": totalAmount,
    "status": status,
    "payment_status": paymentStatus,
    "payment_method": paymentMethod,
    "delivery_address": deliveryAddress,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "items": items.map((x) => x.toJson()).toList(),
  };
}

class Item {
  Item({
    required this.id,
    required this.orderId,
    required this.foodItemId,
    required this.quantity,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.foodItem,
  });

  final int? id;
  final num? orderId;
  final num? foodItemId;
  final num? quantity;
  final String? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final FoodItem? foodItem;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      orderId: json["order_id"],
      foodItemId: json["food_item_id"],
      quantity: json["quantity"],
      price: json["price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      foodItem: json["food_item"] == null
          ? null
          : FoodItem.fromJson(json["food_item"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "food_item_id": foodItemId,
    "quantity": quantity,
    "price": price,
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
  final String? imagePublicId;  final num? isAvailable;
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
