import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import '../../assets/app_colors.dart';
import '../TextView/Models/TextViewConfig.dart';
import '../TextView/TextView.dart';
import 'Model/BodyConfig.dart';

class BodyWidget extends StatelessWidget {
  final BodyConfig? config;

  const BodyWidget({required this.config, super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // ignore: deprecated_member_use
    return WillPopScope(
      child: Stack(
        children: [
          Scaffold(
            backgroundColor:
                config?.backgroundColor ??
                Theme.of(context).scaffoldBackgroundColor,
            appBar: config!.showAppBar
                ? AppBar(
                    centerTitle: config!.centerTitle,
                    automaticallyImplyLeading:
                        config!.automaticallyImplyLeading,
                    actions: config?.actions,
                    elevation: config?.elevation,
                    iconTheme: IconThemeData(
                      color: isDarkMode ? AppColors.white : AppColors.grey900,
                    ),
                    backgroundColor: config?.appbarBackgroundColor,
                    leading: config!.showLeadingWidget
                        ? config?.leadingWidget ??
                              CupertinoButton(
                                onPressed: config?.onPressed,
                                child: Icon(
                                  Icons.chevron_left_sharp,
                                  size: 30.sp,
                                  color: AppColors.black,
                                ),
                              )
                        : null,
                    title: TextView(
                      config: TextViewConfig(
                        text: config?.appBarTitle ?? '',
                        textStyle: GoogleFonts.workSans(
                          fontSize: config?.fontSize,
                          color: config?.appbarTitleColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    bottom: config?.tabs != null
                        ? TabBar(tabs: config!.tabs!)
                        : null,
                  )
                : null,
            body: SafeArea(
              minimum:
                  config?.childPadding ??
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: config?.child,
              ),
            ),
            bottomNavigationBar: config?.bottomNavigationBar,
            floatingActionButton: config!.floatingActionButton,
          ),
          Visibility(
            visible: config?.loading ?? false,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black.withAlpha((.2 * 225).toInt()),
              child: const Loader(),
            ),
          ),
        ],
      ),
      onWillPop: () async => config?.automaticallyImplyLeading ?? true,
    );
  }
}

class Loader extends StatelessWidget {
  const Loader({super.key, this.size = 50});

  final int? size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0.8, end: 1.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(scale: scale, child: child);
        },
        child: ImageView(
          imageConfig: ImageConfig(
            imageURL: AppImage.applogo,
            boxFit: BoxFit.contain,
            height: 78.07.h,
            imageType: ImageType.asset,
          ),
        ),
      ),
    );
    // return Center(child: SpinKitThreeBounce(color: AppColors.primary));
  }
}


// ImageView(
//         imageConfig: ImageConfig(
//           imageURL: AppImage.wepaygif,
//           imageType: ImageType.asset,
//           boxFit: BoxFit.cover,
//           height: 300.h,
//         ),
//       ),