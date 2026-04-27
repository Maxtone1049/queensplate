class SendReviewModel {
    SendReviewModel({
        required this.rating,
        required this.comment,
    });

    final String? rating;
    final String? comment;

    factory SendReviewModel.fromJson(Map<String, dynamic> json){ 
        return SendReviewModel(
            rating: json["rating"],
            comment: json["comment"],
        );
    }

    Map<String, dynamic> toJson() => {
        "rating": rating,
        "comment": comment,
    };

}
