import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/app_ui_components.dart';
import 'package:queen_plate_delivery/common/AppUtils/date_formatter.dart';
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
import 'package:queen_plate_delivery/core/router/page_router.dart';
import 'package:queen_plate_delivery/screens/dashboard/models/send_review_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class FeedbackView extends StatefulWidget {
  const FeedbackView({super.key});

  @override
  State<FeedbackView> createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView> {
  bool isViewingReviews = false; // Toggle between Give Feedback & View Reviews
  int selectedRating = 0;
  final comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await model.getAllFeeback();
        });
      },
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            backgroundColor: AppColors.background,
            child: Column(
              children: [
                Gap(height: 30),
                Row(
                  children: [
                    ImageView(
                      imageConfig: ImageConfig(
                        imageURL: AppImage.circlebackarrow,
                        imageType: ImageType.svg,
                        onTap: () => PageRouter.pop(),
                      ),
                    ),
                    const Spacer(),
                    TextView(
                      config: TextViewConfig(
                        text: isViewingReviews ? "Food Review" : "Feedback",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Gap(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      buildTabButton("View Food Review", !isViewingReviews, () {
                        setState(() => isViewingReviews = true);
                      }),
                      Gap(width: 12.w),
                      buildTabButton("Give Feedback", isViewingReviews, () {
                        setState(() => isViewingReviews = false);
                      }),
                    ],
                  ),
                ),
                Gap(height: 24),
                Expanded(
                  child: isViewingReviews
                      ? buildReviewsList(model)
                      : buildGiveFeedbackForm(model),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildGiveFeedbackForm(ProfileViewModel model) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextView(
            config: TextViewConfig(
              text: "How was your food?",
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(height: 11),
          // Star Rating
          Row(
            children: List.generate(5, (index) {
              return GestureDetector(
                onTap: () => setState(() => selectedRating = index + 1),
                child: Icon(
                  index < selectedRating ? Icons.star : Icons.star_border,
                  color: index < selectedRating
                      ? AppColors.primary
                      : Colors.grey,
                  size: 42.sp,
                ),
              );
            }),
          ),

          Gap(height: 29),

          TextView(
            config: TextViewConfig(
              text: "Anything else you'd like to share?",
              color: AppColors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(height: 12.h),

          // Feedback Text Field
          EditFormField(
            config: EditFieldConfig(
              maxLines: 4,
              minLines: 3,
              label: "Review here",
              controller: comment,
              alignLabelWithHint: true,
            ),
          ),

          Gap(height: 32.h),

          // Submit Button
          Center(
            child: ButtonWidget(
              config: ButtonConfig(
                text: "Submit Review",
                width: 279,
                loading: model.isLoad ?? false,
                onPressed: () {
                  // Handle submit
                  if (comment.text.isNotEmpty) {
                    model.submitFeedback(
                      SendReviewModel(
                        comment: comment.text,
                        rating: selectedRating.toString(),
                      ),
                      context,
                    );
                  } else {
                    AppUiComponents.triggerNotification(
                      "Kindly Fill in a Comment",
                      error: false,
                    );
                  }
                },
                height: 50,
                radius: 18.r,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // View Food Reviews List
  Widget buildReviewsList(ProfileViewModel model) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      itemCount: model.allFeedback?.data.length ?? 0,
      itemBuilder: (context, index) {
        final review = model.allFeedback!.data[index];
        final createdAt = review.createdAt;
        final formattedDate = createdAt is DateTime
            ? dateFormat(createdAt)
            : '';
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundImage: const NetworkImage(
                "https://picsum.photos/id/64/200/200",
              ),
            ),
            Gap(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      TextView(
                        config: TextViewConfig(
                          text: model.name,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(width: 6),
                      Expanded(
                        child: TextView(
                          config: TextViewConfig(
                            text: formattedDate,
                            fontSize: 14,
                            color: AppColors.grey1000,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(height: 6.h),
                  Row(
                    children: List.generate(
                      int.tryParse(review.rating.toString()) ?? 0,
                      (i) => Icon(
                        Icons.star,
                        color: AppColors.primary,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  Gap(height: 8.h),
                  TextView(
                    config: TextViewConfig(
                      text: review.comment.toString(),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildTabButton(String text, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColors.red50 : AppColors.primary,
          border: isActive
              ? null
              : Border.all(width: 4.w, color: AppColors.red50),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextView(
          config: TextViewConfig(
            text: text,
            color: isActive ? AppColors.primary : AppColors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
