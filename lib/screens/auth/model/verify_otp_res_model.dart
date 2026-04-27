class VerifyOtpResModel {
  VerifyOtpResModel({
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

  factory VerifyOtpResModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResModel(
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
  Data({required this.email, required this.otp});

  final String? email;
  final String? otp;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(email: json["email"], otp: json["otp"]);
  }

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
