import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/Network/Network_Service.dart';
import 'package:queen_plate_delivery/screens/auth/auth_api/auth_api.dart';
import 'package:queen_plate_delivery/screens/auth/repository/auth_repo_impl.dart';
import 'package:queen_plate_delivery/screens/auth/view_model/auth_view_model.dart';
import 'package:queen_plate_delivery/screens/auth/views/change_password_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/forget_password_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/login_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/onboarding_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/otp_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/register_view.dart';
import 'package:queen_plate_delivery/screens/auth/views/splash_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/dashboard_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/order_api/order_api.dart';
import 'package:queen_plate_delivery/screens/dashboard/repo/general_repo_impl.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/dashboard_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/checkout_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/order_success_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/paystack_web_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/views/food_menu_detail_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/views/order_history_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/views/order_tracking_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/contact_us_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/delivery_details_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/edit_delivery_detail_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/feedback_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/notification_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CustomRoute(
      page: SplashView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CupertinoRoute(page: RegisterView),
    CupertinoRoute(page: LoginView),
    CupertinoRoute(page: ForgetPasswordView),
    CupertinoRoute(page: OtpView),
    CupertinoRoute(page: DashboardView),
    CupertinoRoute(page: FoodMenuDetailView),
    CupertinoRoute(page: CheckoutView),
    CupertinoRoute(page: OrderSuccessView),
    CupertinoRoute(page: OrderTrackingView),
    CupertinoRoute(page: OrderHistoryView),
    CupertinoRoute(page: DeliveryDetailsView),
    CupertinoRoute(page: EditDeliveryDetailView),
    CupertinoRoute(page: ContactUsView),
    CupertinoRoute(page: FeedbackView),
    CupertinoRoute(page: NotificationView),
    CupertinoRoute(page: ChangePasswordView),
    CupertinoRoute(page: PaystackWebView),
    CupertinoRoute(page: OnboardingView,initial: true),
    // CupertinoRoute(page: BvnScreen),
    // CupertinoRoute(page: LoginScreen),
    // CustomRoute(
    //   page: BvnOtpScreen,
    //   transitionsBuilder: TransitionsBuilders.fadeIn,
    // ),

    // CustomRoute(page: ViewOne, transitionsBuilder: TransitionsBuilders.fadeIn),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: SnackbarService),
    LazySingleton(classType: SharedPreferencesService),
    LazySingleton(classType: AuthViewModel),
    LazySingleton(classType: NetworkService),
    LazySingleton(classType: DashboardViewModel),
    LazySingleton(classType: CartViewModel),
    LazySingleton(classType: ProfileViewModel),
    LazySingleton(classType: AuthRepoImpl),
    LazySingleton(classType: AuthApi),
    LazySingleton(classType: OrderApi),
    LazySingleton(classType: GeneralRepoImpl),
  ],
  logger: StackedLogger(),
)
class App {}
