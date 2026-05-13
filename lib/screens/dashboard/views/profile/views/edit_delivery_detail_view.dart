import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:queen_plate_delivery/assets/app_colors.dart';
import 'package:queen_plate_delivery/assets/app_image.dart';
import 'package:queen_plate_delivery/common/AppUtils/Form_Validator.dart';
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
import 'package:queen_plate_delivery/screens/dashboard/models/update_user_profile.dart';
import 'package:queen_plate_delivery/screens/dashboard/view_model/profile_view_model.dart';
import 'package:queen_plate_delivery/screens/dashboard/views/profile/views/edit_delivery_detail_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

@FormView(
  fields: [
    FormTextField(name: 'address'),
    FormTextField(name: 'apartment'),
    FormTextField(name: 'country'),
    FormTextField(name: 'state'),
    FormTextField(name: 'phone'),
    FormTextField(name: 'name'),
  ],
)
class EditDeliveryDetailView extends StatelessWidget
    with $EditDeliveryDetailView {
  const EditDeliveryDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => locator<ProfileViewModel>(),
      disposeViewModel: false,
      onViewModelReady: (model) {},
      onDispose: (viewModel) => disposeForm(),
      builder: (_, model, _) {
        return BodyWidget(
          config: BodyConfig(
            childPadding: EdgeInsets.symmetric(horizontal: 16),
            backgroundColor: AppColors.background,
            child: SingleChildScrollView(
              child: Form(
                key: model.updateKey,
                child: Column(
                  children: [
                    Gap(height: 20),
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
                            text: "Residential / Profile Details",
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Gap(height: 30),
                    EditFormField(
                      config: EditFieldConfig(
                        label: model.name,
                        title: "Name",
                        controller: nameController,
                      ),
                    ),
                    Gap(height: 16),
                    EditFormField(
                      config: EditFieldConfig(
                        label: "Kubwa",
                        title: 'Street Address',
                        controller: addressController,
                        validator: FieldValidator.validateString(),
                      ),
                    ),
                    Gap(height: 16),
                    EditFormField(
                      config: EditFieldConfig(
                        label: "suit 200",
                        title: 'Apartment / Suit (Optional)',
                        controller: apartmentController,
                      ),
                    ),
                    Gap(height: 16),
                    EditFormField(
                      config: EditFieldConfig(
                        label: "Nigeria",
                        title: 'Country',
                        controller: countryController,
                        validator: FieldValidator.validateString(),
                      ),
                    ),
                    Gap(height: 16),
                    EditFormField(
                      config: EditFieldConfig(
                        label: "FCT",
                        title: 'State',
                        controller: stateController,
                        validator: FieldValidator.validateString(),
                      ),
                    ),
                    Gap(height: 16),
                    EditFormField(
                      config: EditFieldConfig(
                        label: "+234 900 2993 399",
                        title: 'Phone Number',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        validator: FieldValidator.validatePhone(),
                      ),
                    ),
                    Gap(height: 26),
                    ButtonWidget(
                      config: ButtonConfig(
                        text: "Save",
                        loading: model.isLoad ?? false,
                        onPressed: () {
                          phoneFocusNode.unfocus();
                          addressFocusNode.unfocus();
                          stateFocusNode.unfocus();
                          countryFocusNode.unfocus();
                          phoneFocusNode.unfocus();
                          apartmentFocusNode.unfocus();
                          if (model.updateKey.currentState!.validate()) {
                            model.updateProfile(
                              UpdateUserProfile(
                                name: nameController.text.isNotEmpty
                                    ? nameController.text
                                    : model.name,
                                email: model.email,
                                streetAddress: addressController.text.isNotEmpty
                                    ? addressController.text
                                    : model.deliveryAddress,
                                apartmentSuite: apartmentController.text,
                                city: stateController.text,
                                state: stateController.text,
                                country: countryController.text,
                                phoneNumber: phoneController.text,
                                isDefault: true,
                              ),
                            );
                          }
                        },
                        height: 50,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.white,
                        width: 279,
                        radius: 18.r,
                      ),
                    ),
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
