class AddCartModel {
  AddCartModel({required this.foodItemId, required this.quantity});

  final int? foodItemId;
  final num? quantity;

  factory AddCartModel.fromJson(Map<String, dynamic> json) {
    return AddCartModel(
      foodItemId: json["food_item_id"],
      quantity: json["quantity"],
    );
  }

  Map<String, dynamic> toJson() => {
    "food_item_id": foodItemId,
    "quantity": quantity,
  };
}
