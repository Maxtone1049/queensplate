import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    timer();
  }

  timer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, route);
  }

  route() {
    PageRouter.pushNamed(Routes.onboardingView);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage(AppImage.bgsplash),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Align(
            //   alignment: Alignment.topLeft,
            //   child: ImageView(
            //     imageConfig: ImageConfig(
            //       imageURL: AppImage.topimage,
            //       imageType: ImageType.asset,
            //       height: 300,
            //     ),
            //   ),
            // ),
            ImageView(
              imageConfig: ImageConfig(
                imageURL: AppImage.logo,
                imageType: ImageType.asset,
                height: 150,
              ),
            ),
            Gap(height: 40),
            Platform.isIOS
                ? const CupertinoActivityIndicator(
                    radius: 15,
                    color: AppColors.primary,
                    animating: true,
                  )
                : CircularProgressIndicator(
                    color: AppColors.primary,
                    strokeWidth: 10,
                  ),
          ],
        ),
      ),
    );
  }
}
