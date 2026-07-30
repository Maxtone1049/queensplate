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
  final int? status;

  factory MenuListResModel.fromJson(Map<String, dynamic> json) {
    return MenuListResModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"],
      status: json["status"],
    );
  }
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
  final String? imagePublicId;
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
  final int? categoryId;
  final String? name;
  final String? description;
  final String? price;
  final String? image;
  final String? imagePublicId;
  final int? isAvailable;
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
}
