class GetUserResModel {
  GetUserResModel({
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

  factory GetUserResModel.fromJson(Map<String, dynamic> json) {
    return GetUserResModel(
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
  Data({required this.user, required this.addresses});

  final User? user;
  final List<AddressModel> addresses;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      addresses: json["addresses"] == null
          ? []
          : List<AddressModel>.from(
              json["addresses"]!.map((x) => AddressModel.fromJson(x)),
            ),
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "addresses": addresses.map((x) => x.toJson()).toList(),
  };
}

class AddressModel {
  AddressModel({
    required this.id,
    required this.userId,
    required this.streetAddress,
    required this.apartmentSuite,
    required this.country,
    required this.state,
    required this.phoneNumber,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  final num? id;
  final num? userId;
  final String? streetAddress;
  final String? apartmentSuite;
  final String? country;
  final String? state;
  final String? phoneNumber;
  final num? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json["id"],
      userId: json["user_id"],
      streetAddress: json["street_address"],
      apartmentSuite: json["apartment_suite"],
      country: json["country"],
      state: json["state"],
      phoneNumber: json["phone_number"],
      isDefault: json["is_default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "street_address": streetAddress,
    "apartment_suite": apartmentSuite,
    "country": country,
    "state": state,
    "phone_number": phoneNumber,
    "is_default": isDefault,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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

  final num? id;
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
