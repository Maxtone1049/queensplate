class MenuDetailResModel {
  MenuDetailResModel({
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

  factory MenuDetailResModel.fromJson(Map<String, dynamic> json) {
    return MenuDetailResModel(
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
  Data({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.cartDetails,
    required this.category,
  });

  final int? id;
  final String? name;
  final String? price;
  final String? description;
  final String? image;
  final num? categoryId;
  final CartDetails? cartDetails; // Can be null when API returns []
  final Category? category;

  factory Data.fromJson(Map<String, dynamic> json) {
    // Parse cart_details: it can be a Map (object) or an empty List
    CartDetails? parsedCartDetails;
    final cartDetailsJson = json["cart_details"];
    if (cartDetailsJson is Map<String, dynamic>) {
      parsedCartDetails = CartDetails.fromJson(cartDetailsJson);
    } // If it's a List (e.g., []), keep parsedCartDetails as null

    return Data(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      description: json["description"],
      image: json["image"],
      categoryId: json["category_id"],
      cartDetails: parsedCartDetails,
      category: json["category"] == null
          ? null
          : Category.fromJson(json["category"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "description": description,
    "image": image,
    "category_id": categoryId,
    "cart_details": cartDetails
        ?.toJson(), // null will be omitted or become null in JSON
    "category": category?.toJson(),
  };
}

class CartDetails {
  CartDetails({
    required this.id,
    required this.quantity,
    required this.foodItemId,
  });

  final int? id;
  final num? quantity;
  final num? foodItemId;

  factory CartDetails.fromJson(Map<String, dynamic> json) {
    return CartDetails(
      id: json["id"],
      quantity: json["quantity"],
      foodItemId: json["food_item_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "food_item_id": foodItemId,
  };
}

class Category {
  Category({required this.id, required this.name, required this.image});

  final int? id;
  final String? name;
  final String? image;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json["id"], name: json["name"], image: json["image"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "image": image};
}
