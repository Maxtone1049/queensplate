class ResetPasswordModel {
  ResetPasswordModel({
    required this.email,
    required this.otp,
    required this.password,
    required this.confirmPassword,
  });

  final String? email;
  final String? otp;
  final String? password;
  final String? confirmPassword;

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      email: json["email"],
      otp: json["otp"],
      password: json["password"],
      confirmPassword: json["confirm_password"],
    );
  }

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp": otp,
    "password": password,
    "confirm_password": confirmPassword,
  };
}
