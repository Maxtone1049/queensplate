// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_services/src/snackbar/snackbar_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../../common/appmanager/shared_preferences.dart';
import '../../screens/auth/auth_api/auth_api.dart';
import '../../screens/auth/repository/auth_repo_impl.dart';
import '../../screens/auth/view_model/auth_view_model.dart';
import '../../screens/dashboard/order_api/order_api.dart';
import '../../screens/dashboard/repo/general_repo_impl.dart';
import '../../screens/dashboard/view_model/cart_view_model.dart';
import '../../screens/dashboard/view_model/dashboard_view_model.dart';
import '../../screens/dashboard/view_model/profile_view_model.dart';
import '../Network/Network_Service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => AuthViewModel());
  locator.registerLazySingleton(() => NetworkService());
  locator.registerLazySingleton(() => DashboardViewModel());
  locator.registerLazySingleton(() => CartViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
  locator.registerLazySingleton(() => AuthRepoImpl());
  locator.registerLazySingleton(() => AuthApi());
  locator.registerLazySingleton(() => OrderApi());
  locator.registerLazySingleton(() => GeneralRepoImpl());
}
