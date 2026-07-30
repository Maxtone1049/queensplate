class RegisterUserResModel {
  RegisterUserResModel({
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

  factory RegisterUserResModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserResModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
      errors: json["errors"],
      status: json["status"],
    );
  }
}

class Data {
  Data({required this.email});

  final String? email;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(email: json["email"]);
  }
}
