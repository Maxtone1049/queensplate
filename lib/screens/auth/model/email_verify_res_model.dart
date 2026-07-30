class EmailVerifyResModel {
    EmailVerifyResModel({
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

    factory EmailVerifyResModel.fromJson(Map<String, dynamic> json){ 
        return EmailVerifyResModel(
            success: json["success"],
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
            errors: json["errors"],
            status: json["status"],
        );
    }

}

class Data {
    Data({
        required this.token,
        required this.user,
    });

    final String? token;
    final User? user;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            token: json["token"],
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

}

class User {
    User({
        required this.id,
        required this.name,
        required this.email,
        required this.socialId,
        required this.socialProvider,
        required this.avatar,
        required this.phoneNumber,
        required this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    final num? id;
    final String? name;
    final String? email;
    final dynamic socialId;
    final dynamic socialProvider;
    final dynamic avatar;
    final dynamic phoneNumber;
    final DateTime? emailVerifiedAt;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            id: json["id"],
            name: json["name"],
            email: json["email"],
            socialId: json["social_id"],
            socialProvider: json["social_provider"],
            avatar: json["avatar"],
            phoneNumber: json["phone_number"],
            emailVerifiedAt: DateTime.tryParse(json["email_verified_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        );
    }

}
