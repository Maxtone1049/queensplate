class ForgetPassResModel {
    ForgetPassResModel({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
        required this.status,
    });

    final bool? success;
    final String? message;
    final dynamic data;
    final dynamic errors;
    final num? status;

    factory ForgetPassResModel.fromJson(Map<String, dynamic> json){ 
        return ForgetPassResModel(
            success: json["success"],
            message: json["message"],
            data: json["data"],
            errors: json["errors"],
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
        "errors": errors,
        "status": status,
    };

}
