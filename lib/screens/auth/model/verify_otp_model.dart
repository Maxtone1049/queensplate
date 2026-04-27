class VerifyOtpModel {
  VerifyOtpModel({required this.email, required this.otp});

  final String? email;
  final String? otp;

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(email: json["email"], otp: json["otp"]);
  }

  Map<String, dynamic> toJson() => {"email": email, "otp": otp};
}
