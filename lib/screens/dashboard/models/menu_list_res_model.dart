class MenuListResModel {
  MenuListResModel({
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

  factory MenuListResModel.fromJson(Map<String, dynamic> json) {
    return MenuListResModel(
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
  Data({required this.categories, required this.featuredMeals});

  final List<Category> categories;
  final List<FeaturedMeal> featuredMeals;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      categories: json["categories"] == null
          ? []
          : List<Category>.from(
              json["categories"]!.map((x) => Category.fromJson(x)),
            ),
      featuredMeals: json["featured_meals"] == null
          ? []
          : List<FeaturedMeal>.from(
              json["featured_meals"]!.map((x) => FeaturedMeal.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "categories": categories.map((x) => x.toJson()).toList(),
    "featured_meals": featuredMeals.map((x) => x.toJson()).toList(),
  };
}

class Category {
  Category({
    required this.id,
    required this.name,
    required this.imagePublicId,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final dynamic imagePublicId;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      imagePublicId: json["image_public_id"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image_public_id": imagePublicId,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class FeaturedMeal {
  FeaturedMeal({
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
  final String? categoryId;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? imagePublicId;
  final String? isAvailable;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory FeaturedMeal.fromJson(Map<String, dynamic> json) {
    return FeaturedMeal(
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
