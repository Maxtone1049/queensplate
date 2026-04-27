class LoginUserResModel {
  LoginUserResModel({
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

  factory LoginUserResModel.fromJson(Map<String, dynamic> json) {
    return LoginUserResModel(
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
    required this.accessToken,
    required this.tokenType,
    required this.userType,
    required this.user,
  });

  final String? accessToken;
  final String? tokenType;
  final String? userType;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      accessToken: json["access_token"],
      tokenType: json["token_type"],
      userType: json["user_type"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user_type": userType,
    "user": user?.toJson(),
  };
}

class User {
  User({required this.id, required this.name, required this.email});

  final int? id;
  final String? name;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"], email: json["email"]);
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};
}
