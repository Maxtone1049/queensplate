class UpdateQuantityModel {
    UpdateQuantityModel({
        required this.type,
    });

    final String? type;

    factory UpdateQuantityModel.fromJson(Map<String, dynamic> json){ 
        return UpdateQuantityModel(
            type: json["type"],
        );
    }

    Map<String, dynamic> toJson() => {
        "type": type,
    };

}
