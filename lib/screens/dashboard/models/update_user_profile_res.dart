class UpdateUserProfileResModel {
  UpdateUserProfileResModel({
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

  factory UpdateUserProfileResModel.fromJson(Map<String, dynamic> json) {
    return UpdateUserProfileResModel(
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
  Data({required this.message, required this.user, required this.address});

  final String? message;
  final User? user;
  final DataAddress? address;

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      address: json["address"] == null
          ? null
          : DataAddress.fromJson(json["address"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "address": address?.toJson(),
  };
}

class DataAddress {
  DataAddress({
    required this.streetAddress,
    required this.apartmentSuite,
    required this.state,
    required this.country,
    required this.phoneNumber,
    required this.isDefault,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  final String? streetAddress;
  final dynamic apartmentSuite;
  final String? state;
  final String? country;
  final String? phoneNumber;
  final bool? isDefault;
  final int? userId;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  factory DataAddress.fromJson(Map<String, dynamic> json) {
    return DataAddress(
      streetAddress: json["street_address"],
      apartmentSuite: json["apartment_suite"],
      state: json["state"],
      country: json["country"],
      phoneNumber: json["phone_number"],
      isDefault: json["is_default"],
      userId: json["user_id"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "street_address": streetAddress,
    "apartment_suite": apartmentSuite,
    "state": state,
    "country": country,
    "phone_number": phoneNumber,
    "is_default": isDefault,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
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
    required this.addresses,
  });

  final int? id;
  final String? name;
  final String? email;
  final dynamic phoneNumber;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AddressElement> addresses;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phoneNumber: json["phone_number"],
      emailVerifiedAt: json["email_verified_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      addresses: json["addresses"] == null
          ? []
          : List<AddressElement>.from(
              json["addresses"]!.map((x) => AddressElement.fromJson(x)),
            ),
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
    "addresses": addresses.map((x) => x.toJson()).toList(),
  };
}

class AddressElement {
  AddressElement({
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

  final int? id;
  final String? userId;
  final String? streetAddress;
  final dynamic apartmentSuite;
  final String? country;
  final String? state;
  final String? phoneNumber;
  final String? isDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AddressElement.fromJson(Map<String, dynamic> json) {
    return AddressElement(
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
