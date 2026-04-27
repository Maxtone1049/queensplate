class SendReviewResModel {
  SendReviewResModel({
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

  factory SendReviewResModel.fromJson(Map<String, dynamic> json) {
    return SendReviewResModel(
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
    required this.userId,
    required this.rating,
    required this.comment,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.user,
  });

  final String? userId;
  final String? rating;
  final String? comment;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final User? user;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      userId: json["user_id"],
      rating: json["rating"],
      comment: json["comment"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "rating": rating,
    "comment": comment,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "user": user?.toJson(),
  };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? email;
  final dynamic phoneNumber;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_number": phoneNumber,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
