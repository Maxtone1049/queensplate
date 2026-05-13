import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/Common/Image/ImageView.dart';
import 'package:queen_plate_delivery/Common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/Common/TextView/TextView.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/trans_skeleton.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/meal_card.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/menu/widgets/menu_category_widget.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/shimmer_loader.dart';
import 'package:stacked/stacked.dart';

class MenuView extends StatelessWidget {
  const MenuView({super.key});

  Future<void> _refreshData(CartViewModel model) async {
    await model.fetchMenu(forceRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await model.fetchMenu();
        });
      },
      disposeViewModel: false,
      builder: (_, model, __) {
        // ====================== FIXED & PROPER FILTERING ======================
        final allMeals = model.menuList?.data?.featuredMeals ?? [];

        final filteredMeals = allMeals.where((meal) {
          // Handle String vs Int comparison safely
          final mealCategoryId = meal.categoryId?.toString().trim();

          final matchesCategory =
              model.selectedCategoryId == null ||
              mealCategoryId == model.selectedCategoryId?.toString();

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
        }).toList();

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

                    // Search Bar + Notification
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
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                              prefixIcon: const Icon(
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
                        Gap(width: 16),
                        ImageView(
                          imageConfig: ImageConfig(
                            imageURL: AppImage.notify,
                            imageType: ImageType.svg,
                            onTap: () =>
                                PageRouter.pushNamed(Routes.notificationView),
                          ),
                        ),
                      ],
                    ),

                    Gap(height: 24),

                    // Categories Section
                    TextView(
                      config: TextViewConfig(
                        text: "Menu Categories",
                        color: AppColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(height: 12),

                    if (model.isBusy && model.menuList == null)
                      const TransactionSkeleton(count: 1)
                    else
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            // "All" Category
                            MenuCategoryWidget(
                              image: AppImage.ricedish,
                              catname: "All",
                              isSelected: model.selectedCategoryId == null,
                              onTap: () => model.selectCategory(null),
                            ),
                            // Other Categories
                            ...?model.menuList?.data?.categories
                                .where(
                                  (cat) => cat.name?.toLowerCase() != "all",
                                ) // Avoid duplicate "All"
                                .map((category) {
                                  return MenuCategoryWidget(
                                    image: category.image?.isNotEmpty == true
                                        ? category.image!
                                        : AppImage.ricedish,
                                    catname: category.name ?? "",
                                    isSelected:
                                        model.selectedCategoryId == category.id,
                                    onTap: () =>
                                        model.selectCategory(category.id),
                                  );
                                }),
                          ],
                        ),
                      ),

                    Gap(height: 24),

                    // Header for current selection
                    TextView(
                      config: TextViewConfig(
                        text: model.selectedCategoryName ?? "All Meals",
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: AppColors.textColor,
                      ),
                    ),

                    Gap(height: 16),

                    // Meals Grid
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: model.isBusy && model.menuList == null
                          ? const SizedBox(height: 200, child: ShimmerLoader())
                          : filteredMeals.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 60),
                                child: Text(
                                  "No meals found in this category",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 20,
                                    childAspectRatio: 0.75,
                                  ),
                              itemCount: filteredMeals.length,
                              itemBuilder: (context, index) {
                                final meal = filteredMeals[index];
                                return MealCard(
                                  imageUrl: meal.image.toString(),
                                  title: meal.name.toString(),
                                  price: "₦${meal.price}",
                                  tap: () {
                                    PageRouter.pushNamed(
                                      Routes.foodMenuDetailView,
                                      args: FoodMenuDetailViewArguments(
                                        foodName: meal.name ?? "",
                                        price: "₦${meal.price}",
                                        description: meal.description ?? "",
                                        imageUrl: meal.image.toString(),
                                        category: meal.categoryId.toString(),
                                        foodId: meal.id.toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),

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
