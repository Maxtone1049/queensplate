class CheckoutModel {
    CheckoutModel({
        required this.deliveryAddress,
        required this.paymentMethod,
        required this.checkoutNote,
    });

    final String? deliveryAddress;
    final String? paymentMethod;
    final String? checkoutNote;

    factory CheckoutModel.fromJson(Map<String, dynamic> json){ 
        return CheckoutModel(
            deliveryAddress: json["delivery_address"],
            paymentMethod: json["payment_method"],
            checkoutNote: json["checkout_note"],
        );
    }

    Map<String, dynamic> toJson() => {
        "delivery_address": deliveryAddress,
        "payment_method": paymentMethod,
        "checkout_note": checkoutNote,
    };

}
