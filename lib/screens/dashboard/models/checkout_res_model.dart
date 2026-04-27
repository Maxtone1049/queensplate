class CheckoutResModel {
  CheckoutResModel({
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

  factory CheckoutResModel.fromJson(Map<String, dynamic> json) {
    return CheckoutResModel(
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
  Data({required this.orderId, required this.total, required this.paymentUrl});

  final String? orderId;
  final num? total;
  final String? paymentUrl;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      orderId: json["order_id"],
      total: json["total"],
      paymentUrl: json["payment_url"],
    );
  }

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "total": total,
    "payment_url": paymentUrl,
  };
}
