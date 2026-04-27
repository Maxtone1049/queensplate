import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/dashboard_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/widgets/cart_item_card.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/shimmer_loader.dart';
import 'package:stacked/stacked.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          if (!model.hasCachedCartData) {
            await model.fetchCartItem();
          } else {
            model.refreshCart(); // silent background refresh
          }
        });
      },
      builder: (_, model, __) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            child: RefreshIndicator(
              onRefresh: () => model.refreshCart(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // Header, Title, etc.
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(height: 23),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.logo,
                                imageType: ImageType.asset,
                                height: 32.h,
                              ),
                            ),
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.notify,
                                imageType: ImageType.svg,
                                height: 32.h,
                                onTap: () => PageRouter.pushNamed(
                                  Routes.notificationView,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(height: 20),
                        TextView(
                          config: TextViewConfig(
                            text: "My cart",
                            color: AppColors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextView(
                          config: TextViewConfig(
                            text:
                                model.cartResModel?.data?.items.isEmpty ?? true
                                ? ""
                                : "You have ${model.cartResModel?.data?.items.length} items in your cart",
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Gap(height: 13),
                      ],
                    ),
                  ),
                  // Loading or Cart Content
                  if (model.isBusy)
                    const SliverFillRemaining(
                      child: Center(child: ShimmerLoader()),
                    )
                  else if (model.cartResModel?.data?.items.isEmpty ?? true)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ImageView(
                              imageConfig: ImageConfig(
                                imageURL: AppImage.cart,
                                imageType: ImageType.svg,
                                height: 125.h,
                              ),
                            ),
                            Gap(height: 23),
                            TextView(
                              config: TextViewConfig(
                                text: "Your cart is empty",
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextView(
                              config: TextViewConfig(
                                text: "Browse the menu and add some items",
                                color: AppColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Gap(height: 36),
                            ButtonWidget(
                              config: ButtonConfig(
                                text: "Browse menu",
                                onPressed: () =>
                                    locator<DashboardViewModel>().setIndex(1),
                                height: 50,
                                width: 279,
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                textColor: AppColors.white,
                                radius: 18.r,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverList(
                      delegate: SliverChildListDelegate([
                        // Cart items
                        ...?model.cartResModel?.data?.items.map(
                          (cart) => CartItemCard(
                            image: cart.foodItem!.image.toString(),
                            itemName: cart.foodItem!.name.toString(),
                            price: cart.foodItem!.price.toString(),
                            quantity: cart.quantity.toString(),
                            totalPrice: cart.totalPrice.toString(),
                            increase: () =>
                                model.increaseQuantity(cart.id.toString()),
                            decrease: () =>
                                model.decreaseQuantity(cart.id.toString()),
                            delete: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Delete Item"),
                                  content: const Text(
                                    "Are you sure you want to remove this item from your cart?",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: TextView(
                                        config: TextViewConfig(
                                          text: "Cancel",
                                          color: AppColors.black,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        model.deleteCartItem(
                                          cart.id.toString(),
                                        );
                                        Navigator.pop(context);
                                      },
                                      child: TextView(
                                        config: TextViewConfig(
                                          text: "Delete",
                                          color: AppColors.red100,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        // Order summary
                        Gap(height: 32),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 23,
                            horizontal: 14.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.yellow100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Subtotal",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.cartResModel!.data!.summary!.subtotal.toString()}",
                                      color: AppColors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Delivery Fee",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.cartResModel?.data?.summary?.deliveryFee ?? 0.0}",
                                      color: AppColors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Tax",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.cartResModel?.data?.summary?.taxAmount ?? 0.0}",
                                      color: AppColors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextView(
                                    config: TextViewConfig(
                                      text: "Total",
                                      color: AppColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  TextView(
                                    config: TextViewConfig(
                                      text:
                                          "₦${model.cartResModel!.data!.summary!.total.toString()}",
                                      color: AppColors.primary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(height: 36),
                        Center(
                          child: ButtonWidget(
                            config: ButtonConfig(
                              text: "Checkout",
                              onPressed: () =>
                                  PageRouter.pushNamed(Routes.checkoutView),
                              height: 50,
                              width: 279,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.white,
                              radius: 18.r,
                            ),
                          ),
                        ),
                        Gap(height: 40), // extra bottom spacing
                      ]),
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
