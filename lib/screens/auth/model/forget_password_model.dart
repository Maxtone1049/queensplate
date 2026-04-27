class ForgetPasswordModel {
  ForgetPasswordModel({required this.email});

  final String? email;

  factory ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordModel(email: json["email"]);
  }

  Map<String, dynamic> toJson() => {"email": email};
}
