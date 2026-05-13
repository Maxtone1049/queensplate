import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:queen_plate_delivery/common/appmanager/shared_preferences.dart';
import 'package:queen_plate_delivery/core/Network/http_overrides.dart';
import 'package:queen_plate_delivery/core/main_core/AppConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/mobile_screen.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  // await InAppWebViewPlatform.instance?.;
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = AppHttpOverrides();

  await setupLocator();
  await locator<SharedPreferencesService>().initilize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ScreenUtilInit(
        designSize: const Size(350, 852),
        rebuildFactor: RebuildFactors.change,
        builder: (_, _) => MaterialApp(
          title: 'Queen Plate Delivery',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: kIsWeb
          ? Routes.loginView
          : SharedPreferencesService.instance.isLoggedIn == true
              ? Routes.dashboardView
              : Routes.onboardingView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
          supportedLocales: AppConfig.locals,

          // This builder controls what is shown based on screen size
          builder: (context, child) {
            final screenWidth = MediaQuery.of(context).size.width;

            // Show mobile app normally if screen is small (≤ 500px) or if running on real mobile
            if (screenWidth <= 600 || !kIsWeb) {
              return child ?? const SizedBox.shrink();
            }

            // Otherwise (large screen on web) → Show "Use Mobile Phone" message
            return const MobileOnlyScreen();
          },
        ),
      ),
    );
  }
}
