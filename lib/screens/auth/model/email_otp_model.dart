class EmailOtpModel {
  EmailOtpModel({required this.email});

  final String? email;

  factory EmailOtpModel.fromJson(Map<String, dynamic> json) {
    return EmailOtpModel(email: json["email"]);
  }

  Map<String, dynamic> toJson() => {"email": email};
}
