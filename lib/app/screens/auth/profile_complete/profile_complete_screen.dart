import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/app/screens/global/widgets/country_bottom_sheet.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/account/profile_complete_controller.dart';
import 'package:ovolutter/data/model/country_model/country_model.dart';
import 'package:ovolutter/data/repo/account/profile_repo.dart';
import 'package:ovolutter/data/services/push_notification_service.dart';
import 'package:ovolutter/environment.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({super.key});

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  void initState() {
    Get.put(ProfileRepo());
    Get.put(ProfileCompleteController(profileRepo: Get.find()));
    Get.put(PushNotificationService());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      nextRoute: '',
      child: AnnotatedRegionWidget(
        systemNavigationBarColor: MyColor.darkScaffoldBackground,
        statusBarColor: MyColor.getTransparentColor(),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        child: Scaffold(
          body: GetBuilder<ProfileCompleteController>(
            builder: (controller) => Stack(
              children: [
                MyAssetImageWidget(
                  assetPath: MyImages.authBg,
                  height: double.infinity,
                  width: double.infinity,
                  boxFit: BoxFit.cover,
                ),
                LayoutBuilder(builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              spaceDown(Dimensions.space25.h),
                              MyAssetImageWidget(
                                assetPath: MyImages.demologo,
                                boxFit: BoxFit.contain,
                                height: 30,
                              ),
                              spaceDown(Dimensions.space16.h),
                              Text(
                                MyStrings.profileComplete.tr,
                                style: boldExtraLarge.copyWith(
                                  fontSize: Dimensions.space32,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'poppin',
                                  color: MyColor.white,
                                  letterSpacing: 0,
                                ),
                              ),
                              spaceDown(Dimensions.space32.h),
                              CustomAppCard(
                                radius: Dimensions.space24,
                                showBorder: false,
                                margin: EdgeInsetsDirectional.only(
                                  start: Dimensions.space16.w,
                                  end: Dimensions.space16.w,
                                  bottom: Dimensions.space40,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: Dimensions.space15),
                                    CustomTextField(
                                      focusNode: controller.usernameFocusNode,
                                      controller: controller.usernameController,
                                      nextFocus: controller.mobileNoFocusNode,
                                      onChanged: () {},
                                      labelText: MyStrings.username.toTitleCase().tr,
                                      hintText: MyStrings.enterYourUsername.tr,
                                      validator: (value) {
                                        if ((value as String).trim().isEmpty) {
                                          return MyStrings.kUsernameIsRequired.tr;
                                        } else if (value.length < 6) {
                                          return MyStrings.kShortUserNameError.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                      controller: controller.mobileNoController,
                                      focusNode: controller.mobileNoFocusNode,
                                      nextFocus: controller.addressFocusNode,
                                      onChanged: () {},
                                      labelText: MyStrings.phoneNo.toTitleCase().tr,
                                      hintText: MyStrings.enterYourPhoneNumber.tr,
                                      textInputType: TextInputType.numberWithOptions(),
                                      prefixIcon: SizedBox(
                                        width: 100,
                                        child: FittedBox(
                                          child: Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  CountryBottomSheet.countryBottomSheet(context, onSelectedData: (Countries data) {
                                                    controller.selectACountry(countryDataValue: data);
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space12),
                                                  decoration: BoxDecoration(
                                                    color: MyColor.getTransparentColor(),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Row(
                                                    children: [
                                                      MyNetworkImageWidget(
                                                        imageUrl: UrlContainer.countryFlagImageLink.replaceAll("{countryCode}", (controller.countryData?.countryCode ?? Environment.defaultCountryCode).toLowerCase()),
                                                        height: Dimensions.space25,
                                                        width: Dimensions.space40 + 2,
                                                      ),
                                                      const SizedBox(width: Dimensions.space5),
                                                      Text(controller.countryData?.countryCode ?? ''),
                                                      const SizedBox(width: Dimensions.space3),
                                                      Icon(
                                                        Icons.arrow_drop_down_rounded,
                                                        color: MyColor.getAccent1Color(),
                                                      ),
                                                      Container(
                                                        width: 2,
                                                        height: Dimensions.space12,
                                                        color: MyColor.getBorderColor(),
                                                      ),
                                                      const SizedBox(width: Dimensions.space8)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if ((value as String).trim().isEmpty) {
                                          return MyStrings.kPhoneNumberIsRequired.tr;
                                        } else if (value.length < 6) {
                                          return MyStrings.kPhoneNumberIsRequired.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                      focusNode: controller.addressFocusNode,
                                      controller: controller.addressController,
                                      nextFocus: controller.stateFocusNode,
                                      onChanged: () {},
                                      labelText: MyStrings.address.toTitleCase().tr,
                                      hintText: MyStrings.enterYourAddress.tr,
                                      validator: (value) {
                                        if ((value as String).trim().isEmpty) {
                                          return MyStrings.kAddressIsRequired.tr;
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                      focusNode: controller.stateFocusNode,
                                      controller: controller.stateController,
                                      nextFocus: controller.cityFocusNode,
                                      onChanged: () {},
                                      labelText: MyStrings.state.toTitleCase().tr,
                                      hintText: MyStrings.enterYourState.tr,
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                      focusNode: controller.cityFocusNode,
                                      controller: controller.cityController,
                                      nextFocus: controller.zipCodeFocusNode,
                                      onChanged: () {
                                        return;
                                      },
                                      labelText: MyStrings.city.toTitleCase().tr,
                                      hintText: MyStrings.enterYourCity.tr,
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                      focusNode: controller.zipCodeFocusNode,
                                      controller: controller.zipCodeController,
                                      onChanged: () {},
                                      labelText: MyStrings.zipCode.toTitleCase().tr,
                                      hintText: MyStrings.enterYourZipCode.tr,
                                    ),
                                    const SizedBox(height: Dimensions.space35),
                                    CustomElevatedBtn(
                                      isLoading: controller.submitLoading,
                                      text: MyStrings.updateProfile.tr,
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          controller.profileCompleteSubmit();
                                        }
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
