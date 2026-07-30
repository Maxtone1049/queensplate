class UpdateQuantityResModel {
  UpdateQuantityResModel({
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

  factory UpdateQuantityResModel.fromJson(Map<String, dynamic> json) {
    return UpdateQuantityResModel(
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
    required this.userId,
    required this.foodItemId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final num? userId;
  final num? foodItemId;
  final num? quantity;
  final String? unitPrice;
  final num? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json["id"],
      userId: json["user_id"],
      foodItemId: json["food_item_id"],
      quantity: json["quantity"],
      unitPrice: json["unit_price"],
      totalPrice: json["total_price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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
  };
}
