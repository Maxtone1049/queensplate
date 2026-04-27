// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/cupertino.dart' as _i22;
import 'package:flutter/material.dart' as _i21;
import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/screens/auth/views/change_password_view.dart'
    as _i18;
import 'package:queen_plate_delivery/screens/auth/views/forget_password_view.dart'
    as _i5;
import 'package:queen_plate_delivery/screens/auth/views/login_view.dart' as _i4;
import 'package:queen_plate_delivery/screens/auth/views/onboarding_view.dart'
    as _i20;
import 'package:queen_plate_delivery/screens/auth/views/otp_view.dart' as _i6;
import 'package:queen_plate_delivery/screens/auth/views/register_view.dart'
    as _i3;
import 'package:queen_plate_delivery/screens/auth/views/splash_view.dart'
    as _i2;
import 'package:queen_plate_delivery/screens/dashboard/dashboard_view.dart'
    as _i7;
import 'package:queen_plate_delivery/screens/dashboard/models/order_history_res_model.dart'
    as _i23;
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/checkout_view.dart'
    as _i9;
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/order_success_view.dart'
    as _i10;
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/paystack_web_view.dart'
    as _i19;
import 'package:queen_plate_delivery/screens/dashboard/views/home/views/food_menu_detail_view.dart'
    as _i8;
import 'package:queen_plate_delivery/screens/dashboard/views/order/views/order_history_view.dart'
    as _i12;
import 'package:queen_plate_delivery/screens/dashboard/views/order/views/order_tracking_view.dart'
    as _i11;
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/contact_us_view.dart'
    as _i15;
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/delivery_details_view.dart'
    as _i13;
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/edit_delivery_detail_view.dart'
    as _i14;
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/feedback_view.dart'
    as _i16;
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/notification_view.dart'
    as _i17;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i24;

class Routes {
  static const splashView = '/splash-view';

  static const registerView = '/register-view';

  static const loginView = '/login-view';

  static const forgetPasswordView = '/forget-password-view';

  static const otpView = '/otp-view';

  static const dashboardView = '/dashboard-view';

  static const foodMenuDetailView = '/food-menu-detail-view';

  static const checkoutView = '/checkout-view';

  static const orderSuccessView = '/order-success-view';

  static const orderTrackingView = '/order-tracking-view';

  static const orderHistoryView = '/order-history-view';

  static const deliveryDetailsView = '/delivery-details-view';

  static const editDeliveryDetailView = '/edit-delivery-detail-view';

  static const contactUsView = '/contact-us-view';

  static const feedbackView = '/feedback-view';

  static const notificationView = '/notification-view';

  static const changePasswordView = '/change-password-view';

  static const paystackWebView = '/paystack-web-view';

  static const onboardingView = '/';

  static const all = <String>{
    splashView,
    registerView,
    loginView,
    forgetPasswordView,
    otpView,
    dashboardView,
    foodMenuDetailView,
    checkoutView,
    orderSuccessView,
    orderTrackingView,
    orderHistoryView,
    deliveryDetailsView,
    editDeliveryDetailView,
    contactUsView,
    feedbackView,
    notificationView,
    changePasswordView,
    paystackWebView,
    onboardingView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashView,
      page: _i2.SplashView,
    ),
    _i1.RouteDef(
      Routes.registerView,
      page: _i3.RegisterView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i4.LoginView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i5.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.otpView,
      page: _i6.OtpView,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i7.DashboardView,
    ),
    _i1.RouteDef(
      Routes.foodMenuDetailView,
      page: _i8.FoodMenuDetailView,
    ),
    _i1.RouteDef(
      Routes.checkoutView,
      page: _i9.CheckoutView,
    ),
    _i1.RouteDef(
      Routes.orderSuccessView,
      page: _i10.OrderSuccessView,
    ),
    _i1.RouteDef(
      Routes.orderTrackingView,
      page: _i11.OrderTrackingView,
    ),
    _i1.RouteDef(
      Routes.orderHistoryView,
      page: _i12.OrderHistoryView,
    ),
    _i1.RouteDef(
      Routes.deliveryDetailsView,
      page: _i13.DeliveryDetailsView,
    ),
    _i1.RouteDef(
      Routes.editDeliveryDetailView,
      page: _i14.EditDeliveryDetailView,
    ),
    _i1.RouteDef(
      Routes.contactUsView,
      page: _i15.ContactUsView,
    ),
    _i1.RouteDef(
      Routes.feedbackView,
      page: _i16.FeedbackView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i17.NotificationView,
    ),
    _i1.RouteDef(
      Routes.changePasswordView,
      page: _i18.ChangePasswordView,
    ),
    _i1.RouteDef(
      Routes.paystackWebView,
      page: _i19.PaystackWebView,
    ),
    _i1.RouteDef(
      Routes.onboardingView,
      page: _i20.OnboardingView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashView: (data) {
      return _i21.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i2.SplashView(),
        settings: data,
        transitionsBuilder: data.transition ?? _i1.TransitionsBuilders.fadeIn,
      );
    },
    _i3.RegisterView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i3.RegisterView(),
        settings: data,
      );
    },
    _i4.LoginView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i4.LoginView(),
        settings: data,
      );
    },
    _i5.ForgetPasswordView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i5.ForgetPasswordView(),
        settings: data,
      );
    },
    _i6.OtpView: (data) {
      final args = data.getArgs<OtpViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i6.OtpView(key: args.key, email: args.email),
        settings: data,
      );
    },
    _i7.DashboardView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i7.DashboardView(),
        settings: data,
      );
    },
    _i8.FoodMenuDetailView: (data) {
      final args = data.getArgs<FoodMenuDetailViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i8.FoodMenuDetailView(
            key: args.key,
            foodName: args.foodName,
            price: args.price,
            description: args.description,
            imageUrl: args.imageUrl,
            category: args.category,
            foodId: args.foodId),
        settings: data,
      );
    },
    _i9.CheckoutView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i9.CheckoutView(),
        settings: data,
      );
    },
    _i10.OrderSuccessView: (data) {
      final args = data.getArgs<OrderSuccessViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i10.OrderSuccessView(
            key: args.key, orderId: args.orderId, address: args.address),
        settings: data,
      );
    },
    _i11.OrderTrackingView: (data) {
      final args = data.getArgs<OrderTrackingViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i11.OrderTrackingView(
            key: args.key, orderId: args.orderId, orderInfo: args.orderInfo),
        settings: data,
      );
    },
    _i12.OrderHistoryView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i12.OrderHistoryView(),
        settings: data,
      );
    },
    _i13.DeliveryDetailsView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i13.DeliveryDetailsView(),
        settings: data,
      );
    },
    _i14.EditDeliveryDetailView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i14.EditDeliveryDetailView(),
        settings: data,
      );
    },
    _i15.ContactUsView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i15.ContactUsView(),
        settings: data,
      );
    },
    _i16.FeedbackView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i16.FeedbackView(),
        settings: data,
      );
    },
    _i17.NotificationView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i17.NotificationView(),
        settings: data,
      );
    },
    _i18.ChangePasswordView: (data) {
      final args = data.getArgs<ChangePasswordViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i18.ChangePasswordView(
            key: args.key, email: args.email, otp: args.otp),
        settings: data,
      );
    },
    _i19.PaystackWebView: (data) {
      final args = data.getArgs<PaystackWebViewArguments>(nullOk: false);
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => _i19.PaystackWebView(
            key: args.key,
            paymentUrl: args.paymentUrl,
            orderId: args.orderId,
            onPaymentSuccess: args.onPaymentSuccess,
            onPaymentCancelled: args.onPaymentCancelled),
        settings: data,
      );
    },
    _i20.OnboardingView: (data) {
      return _i22.CupertinoPageRoute<dynamic>(
        builder: (context) => const _i20.OnboardingView(),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class OtpViewArguments {
  const OtpViewArguments({
    this.key,
    required this.email,
  });

  final _i21.Key? key;

  final String email;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email"}';
  }

  @override
  bool operator ==(covariant OtpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode;
  }
}

class FoodMenuDetailViewArguments {
  const FoodMenuDetailViewArguments({
    this.key,
    required this.foodName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.foodId,
  });

  final _i21.Key? key;

  final String foodName;

  final String price;

  final String description;

  final String imageUrl;

  final String category;

  final String foodId;

  @override
  String toString() {
    return '{"key": "$key", "foodName": "$foodName", "price": "$price", "description": "$description", "imageUrl": "$imageUrl", "category": "$category", "foodId": "$foodId"}';
  }

  @override
  bool operator ==(covariant FoodMenuDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.foodName == foodName &&
        other.price == price &&
        other.description == description &&
        other.imageUrl == imageUrl &&
        other.category == category &&
        other.foodId == foodId;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        foodName.hashCode ^
        price.hashCode ^
        description.hashCode ^
        imageUrl.hashCode ^
        category.hashCode ^
        foodId.hashCode;
  }
}

class OrderSuccessViewArguments {
  const OrderSuccessViewArguments({
    this.key,
    required this.orderId,
    required this.address,
  });

  final _i21.Key? key;

  final String orderId;

  final String address;

  @override
  String toString() {
    return '{"key": "$key", "orderId": "$orderId", "address": "$address"}';
  }

  @override
  bool operator ==(covariant OrderSuccessViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.orderId == orderId &&
        other.address == address;
  }

  @override
  int get hashCode {
    return key.hashCode ^ orderId.hashCode ^ address.hashCode;
  }
}

class OrderTrackingViewArguments {
  const OrderTrackingViewArguments({
    this.key,
    required this.orderId,
    required this.orderInfo,
  });

  final _i21.Key? key;

  final String orderId;

  final _i23.OrderData orderInfo;

  @override
  String toString() {
    return '{"key": "$key", "orderId": "$orderId", "orderInfo": "$orderInfo"}';
  }

  @override
  bool operator ==(covariant OrderTrackingViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.orderId == orderId &&
        other.orderInfo == orderInfo;
  }

  @override
  int get hashCode {
    return key.hashCode ^ orderId.hashCode ^ orderInfo.hashCode;
  }
}

class ChangePasswordViewArguments {
  const ChangePasswordViewArguments({
    this.key,
    required this.email,
    required this.otp,
  });

  final _i21.Key? key;

  final String email;

  final String otp;

  @override
  String toString() {
    return '{"key": "$key", "email": "$email", "otp": "$otp"}';
  }

  @override
  bool operator ==(covariant ChangePasswordViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.email == email && other.otp == otp;
  }

  @override
  int get hashCode {
    return key.hashCode ^ email.hashCode ^ otp.hashCode;
  }
}

class PaystackWebViewArguments {
  const PaystackWebViewArguments({
    this.key,
    required this.paymentUrl,
    required this.orderId,
    required this.onPaymentSuccess,
    this.onPaymentCancelled,
  });

  final _i21.Key? key;

  final String paymentUrl;

  final String orderId;

  final dynamic Function(String) onPaymentSuccess;

  final void Function()? onPaymentCancelled;

  @override
  String toString() {
    return '{"key": "$key", "paymentUrl": "$paymentUrl", "orderId": "$orderId", "onPaymentSuccess": "$onPaymentSuccess", "onPaymentCancelled": "$onPaymentCancelled"}';
  }

  @override
  bool operator ==(covariant PaystackWebViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key &&
        other.paymentUrl == paymentUrl &&
        other.orderId == orderId &&
        other.onPaymentSuccess == onPaymentSuccess &&
        other.onPaymentCancelled == onPaymentCancelled;
  }

  @override
  int get hashCode {
    return key.hashCode ^
        paymentUrl.hashCode ^
        orderId.hashCode ^
        onPaymentSuccess.hashCode ^
        onPaymentCancelled.hashCode;
  }
}

extension NavigatorStateExtension on _i24.NavigationService {
  Future<dynamic> navigateToSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOtpView({
    _i21.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFoodMenuDetailView({
    _i21.Key? key,
    required String foodName,
    required String price,
    required String description,
    required String imageUrl,
    required String category,
    required String foodId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.foodMenuDetailView,
        arguments: FoodMenuDetailViewArguments(
            key: key,
            foodName: foodName,
            price: price,
            description: description,
            imageUrl: imageUrl,
            category: category,
            foodId: foodId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCheckoutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.checkoutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderSuccessView({
    _i21.Key? key,
    required String orderId,
    required String address,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderSuccessView,
        arguments: OrderSuccessViewArguments(
            key: key, orderId: orderId, address: address),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderTrackingView({
    _i21.Key? key,
    required String orderId,
    required _i23.OrderData orderInfo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.orderTrackingView,
        arguments: OrderTrackingViewArguments(
            key: key, orderId: orderId, orderInfo: orderInfo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.orderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDeliveryDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.deliveryDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditDeliveryDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.editDeliveryDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToContactUsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.contactUsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.feedbackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToChangePasswordView({
    _i21.Key? key,
    required String email,
    required String otp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.changePasswordView,
        arguments:
            ChangePasswordViewArguments(key: key, email: email, otp: otp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPaystackWebView({
    _i21.Key? key,
    required String paymentUrl,
    required String orderId,
    required dynamic Function(String) onPaymentSuccess,
    void Function()? onPaymentCancelled,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.paystackWebView,
        arguments: PaystackWebViewArguments(
            key: key,
            paymentUrl: paymentUrl,
            orderId: orderId,
            onPaymentSuccess: onPaymentSuccess,
            onPaymentCancelled: onPaymentCancelled),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithRegisterView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.registerView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOtpView({
    _i21.Key? key,
    required String email,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.otpView,
        arguments: OtpViewArguments(key: key, email: email),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFoodMenuDetailView({
    _i21.Key? key,
    required String foodName,
    required String price,
    required String description,
    required String imageUrl,
    required String category,
    required String foodId,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.foodMenuDetailView,
        arguments: FoodMenuDetailViewArguments(
            key: key,
            foodName: foodName,
            price: price,
            description: description,
            imageUrl: imageUrl,
            category: category,
            foodId: foodId),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCheckoutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.checkoutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderSuccessView({
    _i21.Key? key,
    required String orderId,
    required String address,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.orderSuccessView,
        arguments: OrderSuccessViewArguments(
            key: key, orderId: orderId, address: address),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderTrackingView({
    _i21.Key? key,
    required String orderId,
    required _i23.OrderData orderInfo,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.orderTrackingView,
        arguments: OrderTrackingViewArguments(
            key: key, orderId: orderId, orderInfo: orderInfo),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOrderHistoryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.orderHistoryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDeliveryDetailsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.deliveryDetailsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditDeliveryDetailView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.editDeliveryDetailView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithContactUsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.contactUsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFeedbackView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.feedbackView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithChangePasswordView({
    _i21.Key? key,
    required String email,
    required String otp,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.changePasswordView,
        arguments:
            ChangePasswordViewArguments(key: key, email: email, otp: otp),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPaystackWebView({
    _i21.Key? key,
    required String paymentUrl,
    required String orderId,
    required dynamic Function(String) onPaymentSuccess,
    void Function()? onPaymentCancelled,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.paystackWebView,
        arguments: PaystackWebViewArguments(
            key: key,
            paymentUrl: paymentUrl,
            orderId: orderId,
            onPaymentSuccess: onPaymentSuccess,
            onPaymentCancelled: onPaymentCancelled),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnboardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onboardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
