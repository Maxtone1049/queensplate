class VerifyEmailModel {
    VerifyEmailModel({
        required this.email,
        required this.otp,
    });

    final String? email;
    final String? otp;

    factory VerifyEmailModel.fromJson(Map<String, dynamic> json){ 
        return VerifyEmailModel(
            email: json["email"],
            otp: json["otp"],
        );
    }

    Map<String, dynamic> toJson() => {
        "email": email,
        "otp": otp,
    };

}
