import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/dashboard_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/cart_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/views/home_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/menu/views/menu_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/views/orders_view.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/profile_view.dart';
import 'package:stacked/stacked.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
      viewModelBuilder: () => locator<DashboardViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (viewModel) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          viewModel.setIndex(0);
          // initializeTimer();
        });
      },
      builder: (_, model, __) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeTransition(opacity: primaryAnimation, child: child),
            child: Container(
              key: ValueKey<int>(model.currentIndex),
              child: _getViewForIndex(model.currentIndex),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 10,
            currentIndex: model.currentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            selectedLabelStyle: GoogleFonts.dmSans(fontWeight: FontWeight.w500),
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.grey200,
            unselectedLabelStyle: GoogleFonts.dmSans(
              fontWeight: FontWeight.w500,
            ),
            onTap: model.setIndex,
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: ImageView(
                  imageConfig: ImageConfig(
                    imageURL: model.currentIndex == 0
                        ? AppImage.homefilled
                        : AppImage.homenormal,
                    imageType: ImageType.svg,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Menu',
                icon: ImageView(
                  imageConfig: ImageConfig(
                    imageType: ImageType.svg,
                    imageURL: model.currentIndex == 1
                        ? AppImage.menufilled
                        : AppImage.menu,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                icon: ImageView(
                  imageConfig: ImageConfig(
                    imageType: ImageType.svg,
                    imageURL: model.currentIndex == 2
                        ? AppImage.cartfilled
                        : AppImage.cartdiffer,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Order',
                icon: ImageView(
                  imageConfig: ImageConfig(
                    imageType: ImageType.svg,
                    imageURL: model.currentIndex == 3
                        ? AppImage.orderfilled
                        : AppImage.order,
                  ),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Profile',
                icon: ImageView(
                  imageConfig: ImageConfig(
                    imageType: ImageType.svg,
                    imageURL: model.currentIndex == 4
                        ? AppImage.profilefilled
                        : AppImage.profile,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const MenuView();
      case 2:
        return const CartView();
      case 3:
        return const OrdersView();
      case 4:
        return const ProfileView();
    }
    return const Scaffold();
  }
}
