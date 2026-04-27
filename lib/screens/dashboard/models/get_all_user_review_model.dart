class GetAllUserReviewModel {
  GetAllUserReviewModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
    required this.status,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;
  final dynamic errors;
  final num? status;

  factory GetAllUserReviewModel.fromJson(Map<String, dynamic> json) {
    return GetAllUserReviewModel(
      success: json["success"],
      message: json["message"],
      data: json["data"] == null
          ? []
          : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      errors: json["errors"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.map((x) => x.toJson()).toList(),
    "errors": errors,
    "status": status,
  };
}

class Datum {
  Datum({required this.rating, required this.comment, required this.createdAt});

  final String? rating;
  final String? comment;
  final DateTime? createdAt;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      rating: json["rating"],
      comment: json["comment"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "rating": rating,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
  };
}
