class RegisterUserModel {
    RegisterUserModel({
        required this.name,
        required this.email,
        required this.password,
        required this.passwordConfirmation,
    });

    final String? name;
    final String? email;
    final String? password;
    final String? passwordConfirmation;

    factory RegisterUserModel.fromJson(Map<String, dynamic> json){ 
        return RegisterUserModel(
            name: json["name"],
            email: json["email"],
            password: json["password"],
            passwordConfirmation: json["password_confirmation"],
        );
    }

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
    };

}
