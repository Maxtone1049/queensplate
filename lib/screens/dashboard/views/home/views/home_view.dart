import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/meal_card.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/out_door_service.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/shimmer_loader.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  Future<void> _refreshData(CartViewModel model) async {
    await Future.wait([model.fetchMenu(), model.getCurrentDeliveryAddress()]);
    // Optionally fetch user if needed for name change
    await model.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await model.fetchMenu();
          await model.fetchUser();
          await model.getCurrentDeliveryAddress();
        });
      },
      disposeViewModel: false,
      builder: (_, model, _) {
        final filteredMeals = (model.menuList?.data?.featuredMeals ?? []).where(
          (meal) {
            final matchesCategory =
                model.selectedCategoryId == null ||
                meal.categoryId == model.selectedCategoryId;

            final matchesSearch =
                model.searchQuery.isEmpty ||
                (meal.name?.toLowerCase().contains(
                      model.searchQuery.toLowerCase(),
                    ) ??
                    false) ||
                (meal.description?.toLowerCase().contains(
                      model.searchQuery.toLowerCase(),
                    ) ??
                    false);

            return matchesCategory && matchesSearch;
          },
        ).toList();
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.yellow50,
            showAppBar: false,
            child: RefreshIndicator(
              onRefresh: () => _refreshData(model),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(height: 30),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            onChanged: (value) =>
                                model.updateSearchQuery(value),
                            decoration: InputDecoration(
                              hintText: "Search for meals",
                              hintStyle: GoogleFonts.dmSans(
                                fontSize: 8.25,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColors.primary,
                              ),
                              filled: true,
                              fillColor: AppColors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                        Gap(width: 42),
                        Expanded(
                          flex: 0,
                          child: Row(
                            children: [
                              // ImageView(
                              //   imageConfig: ImageConfig(
                              //     imageURL: AppImage.firedup,
                              //     imageType: ImageType.svg,
                              //   ),
                              // ),
                              Gap(width: 9),
                              ImageView(
                                imageConfig: ImageConfig(
                                  imageURL: AppImage.notify,
                                  imageType: ImageType.svg,
                                  onTap: () => PageRouter.pushNamed(
                                    Routes.notificationView,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Gap(height: 14),
                    Row(
                      children: [
                        ImageView(
                          imageConfig: ImageConfig(
                            imageURL: AppImage.locatorIndicator,
                            imageType: ImageType.svg,
                          ),
                        ),
                        Gap(width: 6),
                        Expanded(
                          child: TextView(
                            config: TextViewConfig(
                              text: model.deliveryAddress.isEmpty
                                  ? "Fetching your location..."
                                  : "Deliver to: ${model.deliveryAddress}",
                              color: AppColors.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Gap(height: 14),
                    TextView(
                      config: TextViewConfig(
                        text:
                            "Hello ${model.name.split(" ").first}, ready to eat?",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),

                    Gap(height: 20),

                    // Hero Banner
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        image: const DecorationImage(
                          image: NetworkImage(
                            "https://picsum.photos/id/1080/800/400",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.65),
                            ],
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 24,
                          horizontal: 15,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              config: TextViewConfig(
                                text: "Craving something\nDelicious?",
                                fontWeight: FontWeight.w700,
                                fontSize: 28,
                                color: AppColors.white,
                                lineHeight: 1.1,
                              ),
                            ),
                            Gap(height: 4),

                            TextView(
                              config: TextViewConfig(
                                text: "Order in 30 seconds",
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: AppColors.yellow500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Gap(height: 18),

                    TextView(
                      config: TextViewConfig(
                        text: "Tasty Meals",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.textColor,
                      ),
                    ),

                    Gap(height: 16),

                    // Meal Grid
                    if (model.isBusy)
                      SizedBox(height: 150, child: ShimmerLoader())
                    else
                      model.menuList?.data?.featuredMeals.isEmpty ?? true
                          ? const Center(child: Text("No Menu yet"))
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16,
                                    childAspectRatio: 0.75,
                                  ),
                              itemCount: filteredMeals.length,
                              itemBuilder: (context, index) {
                                final isJollof = filteredMeals[index];
                                return MealCard(
                                  imageUrl:
                                      isJollof.image!.isNotEmpty &&
                                          isJollof.image!.contains("https")
                                      ? isJollof.image.toString()
                                      : "https://picsum.photos/id/431/400/300",
                                  title: isJollof.name.toString(),
                                  price: isJollof.price.toString(),
                                  tap: () {
                                    PageRouter.pushNamed(
                                      Routes.foodMenuDetailView,
                                      args: FoodMenuDetailViewArguments(
                                        foodName: "${isJollof.name}",
                                        price: "₦${isJollof.price}",
                                        description: isJollof.description
                                            .toString(),
                                        imageUrl: isJollof.image.toString(),
                                        category: isJollof.categoryId
                                            .toString(),
                                        foodId: isJollof.id.toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),

                    const SizedBox(height: 28),

                    OutdoorServiceWidget(),

                    Gap(height: 40),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
