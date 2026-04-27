class RegisterUserResModel {
    RegisterUserResModel({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
        required this.status,
    });

    final bool? success;
    final num? message;
    final Data? data;
    final dynamic errors;
    final num? status;

    factory RegisterUserResModel.fromJson(Map<String, dynamic> json){ 
        return RegisterUserResModel(
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
        required this.user,
    });

    final User? user;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            user: json["user"] == null ? null : User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
    };

}

class User {
    User({
        required this.name,
        required this.email,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    final String? name;
    final String? email;
    final DateTime? updatedAt;
    final DateTime? createdAt;
    final int? id;

    factory User.fromJson(Map<String, dynamic> json){ 
        return User(
            name: json["name"],
            email: json["email"],
            updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
            createdAt: DateTime.tryParse(json["created_at"] ?? ""),
            id: json["id"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
    };

}
