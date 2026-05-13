import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // For kIsWeb
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage(
              _index != 1 ? AppImage.onboardone : AppImage.onboardtwo,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 200.h,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) =>
                    FadeTransition(opacity: animation, child: child),
                child: PageView(
                  onPageChanged: (index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  controller: _controller,
                  children: [
                    // First Onboarding Text
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32, top: 30),
                        child: RichText(
                          text: TextSpan(
                            text: "Order ",
                            style: GoogleFonts.dmSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: "tasty meals\n",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: "that nourishes and\n",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: "comforts",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Second Onboarding Text
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32, top: 30),
                        child: RichText(
                          text: TextSpan(
                            text: "Experience ",
                            style: GoogleFonts.dmSans(
                              color: AppColors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                            children: [
                              TextSpan(
                                text: "rich, royal\nflavors ",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: "delivered\n",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                              TextSpan(
                                text: "straight to you.",
                                style: GoogleFonts.dmSans(
                                  color: AppColors.gold,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 24,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ImageView(
                  imageConfig: ImageConfig(
                    imageURL: AppImage.next,
                    imageType: ImageType.svg,
                    height: 40.h,
                    width: 90,
                    onTap: () {
                      if (_index != 1) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        PageRouter.pushNamed(Routes.loginView);
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
