import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/Body/BodyWidget.dart';
import 'package:queen_plate_delivery/common/Body/Model/BodyConfig.dart';
import 'package:queen_plate_delivery/common/Button/ButtonWidget.dart';
import 'package:queen_plate_delivery/common/Button/Model/ButtonConfig.dart';
import 'package:queen_plate_delivery/common/EditField/EditFieldView.dart';
import 'package:queen_plate_delivery/common/EditField/Model/EditFieldConfig.dart';
import 'package:queen_plate_delivery/common/Gap.dart';
import 'package:queen_plate_delivery/common/Image/ImageView.dart';
import 'package:queen_plate_delivery/common/Image/Model/ImageConfig.dart';
import 'package:queen_plate_delivery/common/TextView/Models/TextViewConfig.dart';
import 'package:queen_plate_delivery/common/TextView/TextView.dart';
import 'package:queen_plate_delivery/core/main_core/app.locator.dart';
import 'package:queen_plate_delivery/core/main_core/app.router.dart';
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/checkout_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/cart_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/views/checkout_view.form.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/cart/widgets/checkout_widget.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/order/widgets/shimmer_loader.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(fields: [FormTextField(name: 'note')])
class CheckoutView extends StatelessWidget with $CheckoutView {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartViewModel>.reactive(
      viewModelBuilder: () => locator<CartViewModel>(),
      disposeViewModel: false,
      onDispose: (model) => disposeForm(),
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          model.selectedPaymentMethod = '';
          await model.fetchCartItem(forceRefresh: true);
        });
      },
      builder: (_, model, _) {
        void showAddressBottomSheet(BuildContext context, CartViewModel model) {
          String? tempSelectedAddress = model.customDeliveryAddress;
          final TextEditingController newAddressController =
              TextEditingController();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                      left: 20.w,
                      right: 20.w,
                      top: 20.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 50.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: AppColors.grey200,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ),
                        Gap(height: 20.h),
                        TextView(
                          config: TextViewConfig(
                            text: "Select Delivery Address",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Gap(height: 16.h),

                        // Current location option
                        ListTile(
                          leading: Icon(
                            Icons.my_location,
                            color: AppColors.primary,
                          ),
                          title: TextView(
                            config: TextViewConfig(
                              text: "Use my current location",
                              fontSize: 14,
                            ),
                          ),
                          trailing: Radio<String>(
                            value: "current",
                            groupValue:
                                tempSelectedAddress == model.deliveryAddress
                                ? "current"
                                : null,
                            onChanged: (_) async {
                              // Fetch current location if not already available
                              if (model.deliveryAddress.contains("Fetching") ||
                                  model.deliveryAddress.contains("Unable")) {
                                await model.getCurrentDeliveryAddress();
                              }
                              setState(() {
                                tempSelectedAddress = model.deliveryAddress;
                              });
                            },
                          ),
                        ),

                        // Saved addresses from ProfileViewModel
                        ...model.addresses.map((address) {
                          final fullAddress =
                              "${address.streetAddress}, ${address.state}, ${address.country}";
                          return ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: AppColors.primary,
                            ),
                            title: TextView(
                              config: TextViewConfig(
                                text: fullAddress,
                                fontSize: 14,
                                maxLines: 2,
                              ),
                            ),
                            trailing: Radio<String>(
                              value: fullAddress,
                              groupValue: tempSelectedAddress,
                              onChanged: (_) {
                                setState(() {
                                  tempSelectedAddress = fullAddress;
                                });
                              },
                            ),
                          );
                        }),

                        // Manual entry
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: TextField(
                            controller: newAddressController,
                            decoration: InputDecoration(
                              hintText: "Or enter a new address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                            ),
                          ),
                        ),

                        ButtonWidget(
                          config: ButtonConfig(
                            text: "Use this address",
                            onPressed: () {
                              String finalAddress = tempSelectedAddress ?? "";
                              if (newAddressController.text.trim().isNotEmpty) {
                                finalAddress = newAddressController.text.trim();
                              }
                              if (finalAddress.isNotEmpty) {
                                model.setDeliveryAddress(finalAddress);
                              }
                              Navigator.pop(context);
                            },
                            height: 50.h,
                            radius: 12.r,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(height: 20.h),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }

        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(height: 23.h),

                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ImageView(
                        imageConfig: ImageConfig(
                          imageURL: AppImage.circlebackarrow,
                          imageType: ImageType.svg,
                          onTap: () => PageRouter.pop(),
                        ),
                      ),
                      ImageView(
                        imageConfig: ImageConfig(
                          imageURL: AppImage.notify,
                          imageType: ImageType.svg,
                        ),
                      ),
                    ],
                  ),

                  Gap(height: 20.h),
                  TextView(
                    config: TextViewConfig(
                      text: "Checkout",
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  Gap(height: 24.h),

                  // Delivery Address (unchanged)
                  Row(
                    children: [
                      ImageView(
                        imageConfig: ImageConfig(
                          imageURL: AppImage.locatorIndicator,
                          imageType: ImageType.svg,
                        ),
                      ),
                      Gap(width: 8.w),
                      TextView(
                        config: TextViewConfig(
                          text: "Delivery Address",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Gap(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextView(
                            config: TextViewConfig(
                              text:
                                  model.customDeliveryAddress ??
                                  (model.addressMain != "N/A"
                                      ? model.addressMain
                                      : model.deliveryAddress),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        TextView(
                          config: TextViewConfig(
                            text: "Edit",
                            fontSize: 16,
                            onTap: () => showAddressBottomSheet(context, model),
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(height: 16.h),
                  EditFormField(
                    config: EditFieldConfig(
                      title: 'Note',
                      label: 'Write a Delivery Note',
                      controller: noteController,
                      focusNode: noteFocusNode,
                      labelStyle: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      textStyle: GoogleFonts.dmSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                      alignLabelWithHint: true,
                      maxLines: 4,
                      minLines: 3,
                    ),
                  ),
                  Gap(height: 16.h),

                  // Order Summary
                  if (model.isBusy)
                    SizedBox(height: 150, child: ShimmerLoader())
                  else
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            config: TextViewConfig(
                              text: "Order Summary",
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                          Gap(height: 20.h),
                          ...?model.cartResModel?.data?.items.map(
                            (item) => buildOrderItem(
                              item.foodItem!.name.toString(),
                              int.tryParse(item.quantity.toString()) ?? 0,
                              int.tryParse(
                                    item.totalPrice.toString().replaceAll(
                                      ".00",
                                      "",
                                    ),
                                  ) ??
                                  0,
                            ),
                          ),
                          Gap(height: 12.h),
                          const Divider(thickness: 1, color: Color(0xFFF0F0F0)),
                          Gap(height: 12.h),
                          buildSummaryRow(
                            "Subtotal",
                            "₦${model.cartResModel?.data?.summary?.subtotal ?? 0}",
                          ),
                          buildSummaryRow(
                            "Delivery Fee",
                            "₦${model.cartResModel?.data?.summary?.deliveryFee ?? 0}",
                          ),
                          buildSummaryRow(
                            "Tax",
                            "₦${model.cartResModel?.data?.summary?.taxAmount ?? 0}",
                          ),
                          Gap(height: 16.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "₦${model.cartResModel?.data?.summary?.total ?? 0}",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                  Gap(height: 20.h),

                  // Payment Options
                  buildPaymentOption(
                    model: model,
                    type: "paystack",
                    iconPath: "assets/images/paystack.png",
                  ),

                  // Gap(height: 12.h),
                  // buildPaymentOption(
                  //   model: model,
                  //   type: "opay",
                  //   iconPath: "assets/images/opay.png",
                  // ),
                  Gap(height: 40.h),

                  // Place Order Button
                  ButtonWidget(
                    config: ButtonConfig(
                      text: "Place order",
                      loading: model.isLoad ?? false,
                      onPressed: () {
                        if (model.selectedPaymentMethod.isEmpty) {
                          return null;
                        } else if (model.phoneNumber.isEmpty) {
                          AppUiComponents.triggerNotification(
                            "Kindly Update Your Profile",
                          );
                          PageRouter.pushNamed(Routes.editDeliveryDetailView);
                        } else {
                          model.makePayment(
                            CheckoutModel(
                              deliveryAddress:
                                  model.customDeliveryAddress ??
                                  (model.addressMain != "N/A"
                                      ? "${model.addressMain}, ${model.addressState}, ${model.addressCountry}"
                                      : model.deliveryAddress),
                              paymentMethod: model.selectedPaymentMethod,
                              checkoutNote: noteController.text,
                            ),
                          );
                        }
                      },
                      height: 56,
                      enabled:
                          model.selectedPaymentMethod.isNotEmpty &&
                          model.phoneNumber.isNotEmpty,
                      buttonColor: model.selectedPaymentMethod.isNotEmpty
                          ? AppColors.primary
                          : AppColors.grey1000,
                      buttonOutlinedColor:
                          model.selectedPaymentMethod.isNotEmpty
                          ? AppColors.primary
                          : AppColors.grey1000,
                      radius: 18.r,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.white,
                    ),
                  ),
                  Gap(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
