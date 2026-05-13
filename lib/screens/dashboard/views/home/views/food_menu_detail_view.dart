import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/Common/Gap.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
// import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/add_cart_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/background_skin/background_skin.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/out_door_service.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/home/widgets/quantity_button.dart';
import 'package:stacked/stacked.dart';

class FoodMenuDetailView extends StatelessWidget {
  final String foodName;
  final String price;
  final String foodId;
  final String description;
  final String imageUrl;
  final String category;

  const FoodMenuDetailView({
    super.key,
    required this.foodName,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.foodId,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await model.fetchMenuDetail(foodId);
          model.resetQuantity();
        });
      },
      builder: (context, model, child) {
        String _getCurrentQuantity(CartViewModel model) {
          final cartQty = model.menuDetail?.data?.cartDetails?.quantity;
          if (cartQty != null && cartQty.isNotEmpty) {
            return cartQty;
          }
          return model.quantity.toString();
        }

        return Scaffold(
          // backgroundColor: AppColors.yellow50,
          body: SafeArea(
            child: BackgroundSkin(
              image: imageUrl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Food Image with Back Button
                  Expanded(
                    flex: 1,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 16,
                          left: 16,
                          child: InkWell(
                            onTap: () => PageRouter.pop(),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: ImageView(
                                  imageConfig: ImageConfig(
                                    imageURL: AppImage.backarrow,
                                    imageType: ImageType.svg,
                                    height: 20,
                                    onTap: () {
                                      PageRouter.pop();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: TextView(
                              config: TextViewConfig(
                                text: "Food Details",
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.yellow50,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(40.r),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 23.h,
                        horizontal: 23.w,
                      ),
                      child: SingleChildScrollView(
                        child:
                            //  model.isBusy
                            //     ? SizedBox(height: 150, child: ShimmerLoader())
                            //     :
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category & Review
                                Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 26.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.yellow500,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextView(
                                        config: TextViewConfig(
                                          text:
                                              model
                                                  .menuDetail
                                                  ?.data
                                                  ?.category
                                                  ?.name ??
                                              "",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 12.w,
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.red50,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: TextView(
                                        config: TextViewConfig(
                                          text: "View Food Review",
                                          fontSize: 9,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Gap(height: 31),
                                TextView(
                                  config: TextViewConfig(
                                    text: foodName,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),

                                Gap(height: 20),

                                TextView(
                                  config: TextViewConfig(
                                    text: description,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),

                                Gap(height: 20),

                                // Price & Quantity
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextView(
                                      config: TextViewConfig(
                                        text: price,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primary,
                                      ),
                                    ),

                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: AppColors.yellow100,
                                      ),
                                      child: Row(
                                        children: [
                                          QuantityButton(
                                            icon: Icons.remove,
                                            onTap: () {
                                              final cartItemId =
                                                  model
                                                      .menuDetail
                                                      ?.data
                                                      ?.cartDetails
                                                      ?.id
                                                      ?.toString() ??
                                                  '';
                                              final foodId =
                                                  model.menuDetail?.data?.id
                                                      ?.toString() ??
                                                  'foodId'; // fallback

                                              model.detailDecrease(
                                                cartItemId,
                                                foodId,
                                              );
                                            },
                                          ),

                                          Container(
                                            width: 40,
                                            alignment: Alignment.center,
                                            child: TextView(
                                              config: TextViewConfig(
                                                text: _getCurrentQuantity(
                                                  model,
                                                ), // Use helper
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),

                                          QuantityButton(
                                            icon: Icons.add,
                                            onTap: () {
                                              final cartItemId =
                                                  model
                                                      .menuDetail
                                                      ?.data
                                                      ?.cartDetails
                                                      ?.id
                                                      ?.toString() ??
                                                  '';
                                              final foodId =
                                                  model.menuDetail?.data?.id
                                                      ?.toString() ??
                                                  "foodId";

                                              model.detailIncrease(
                                                cartItemId,
                                                foodId,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                Gap(height: 28),

                                Center(
                                  child: ButtonWidget(
                                    config: ButtonConfig(
                                      text: "Add to cart",
                                      loading: model.isLoad ?? false,
                                      onPressed: () {
                                        // model.sendToCart(
                                        //   AddCartModel(
                                        //     foodItemId:
                                        //         model.menuDetail!.data!.id,
                                        //     quantity: model.quantity,
                                        //   ),
                                        // );
                                        model.addToCart(
                                          context: context,
                                          foodName: foodName,
                                          price: price,
                                          quantity: model.quantity,
                                          imageUrl: imageUrl,
                                          model: AddCartModel(
                                            foodItemId:
                                                model.menuDetail?.data?.id,
                                            quantity: model.quantity,
                                          ),
                                        );
                                      },
                                      height: 57,
                                      radius: 12.r,
                                      width: 279,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),

                                Gap(height: 24),

                                OutdoorServiceWidget(),
                              ],
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
