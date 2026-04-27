class UpdateUserProfile {
  UpdateUserProfile({
  required this.name,
    required this.email,
    required this.streetAddress,
    required this.apartmentSuite,
    required this.city,
    required this.state,
    required this.country,
    required this.phoneNumber,
    required this.isDefault,
  });

  final String? name;
  final String? email;
  final String? streetAddress;
  final String? apartmentSuite;
  final String? city;
  final String? state;
  final String? country;
  final String? phoneNumber;
  final bool? isDefault;

  factory UpdateUserProfile.fromJson(Map<String, dynamic> json) {
    return UpdateUserProfile(
  name: json["name"],
      email: json["email"],
      streetAddress: json["street_address"],
      apartmentSuite: json["apartment_suite"],
      city: json["city"],
      state: json["state"],
      country: json["country"],
      phoneNumber: json["phone_number"],
      isDefault: json["is_default"],
    );
  }

  Map<String, dynamic> toJson() => {
  "name": name,
    "email": email,
    "street_address": streetAddress,
    "apartment_suite": apartmentSuite,
    "city": city,
    "state": state,
    "country": country,
    "phone_number": phoneNumber,
    "is_default": isDefault,
  };
}
