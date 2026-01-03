import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/buttons/my_text_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/custom_no_data_found_class.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/app/screens/auth/login/widget/social_login_section.dart';
import 'package:ovolutter/app/screens/auth/registration/widget/registration_form.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/auth/registration_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/data/repo/auth/signup_repo.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    Get.put(GeneralSettingRepo());
    Get.put(RegistrationRepo());
    Get.put(RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<RegistrationController>().initData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegistrationController>(
      builder: (controller) => WillPopWidget(
        nextRoute: RouteHelper.loginScreen,
        child: AnnotatedRegionWidget(
          systemNavigationBarColor: MyColor.darkScaffoldBackground,
          statusBarColor: MyColor.getTransparentColor(),
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
          padding: EdgeInsets.zero,
          child: Scaffold(
            body: controller.noInternet
                ? NoDataOrInternetScreen(
                    isNoInternet: true,
                    onChanged: (value) {
                      controller.changeInternet(value);
                    },
                  )
                : controller.isLoading
                    ? const CustomLoader()
                    : Stack(
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.authBg,
                            height: double.infinity,
                            width: double.infinity,
                            boxFit: BoxFit.cover,
                          ),
                          SafeArea(
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight,
                                    ),
                                    child: IntrinsicHeight(
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
                                            MyStrings.signIn.tr,
                                            style: boldExtraLarge.copyWith(
                                              fontSize: Dimensions.space32,
                                              fontWeight: FontWeight.w800,
                                              fontFamily: 'poppin',
                                              color: MyColor.white,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          spaceDown(Dimensions.space12.h),
                                          Text(
                                            MyStrings.enterDataToReg.tr,
                                            style: regularDefault.copyWith(color: MyColor.white),
                                          ),
                                          spaceDown(Dimensions.space32.h),
                                          CustomAppCard(
                                            margin: EdgeInsetsDirectional.only(
                                              start: Dimensions.space16.w,
                                              end: Dimensions.space16.w,
                                              bottom: Dimensions.space40,
                                            ),
                                            child: Column(
                                              children: [
                                                spaceDown(Dimensions.space10),
                                                const SocialLoginSection(),
                                                const RegistrationForm(),
                                                spaceDown(Dimensions.space24),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      MyStrings.alreadyAccount.tr,
                                                      style: regularDefault.copyWith(
                                                        color: MyColor.headingTextColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: Dimensions.space5),
                                                    CustomTextButton(
                                                      onTap: () {
                                                        controller.clearAllData();
                                                        Get.offAndToNamed(RouteHelper.loginScreen);
                                                      },
                                                      text: MyStrings.login.tr,
                                                      style: regularDefault.copyWith(fontWeight: FontWeight.w600, color: MyColor.darkInformation),
                                                    )
                                                  ],
                                                ),
                                                spaceDown(Dimensions.space20),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(MyStrings.continueAsGuest.tr, overflow: TextOverflow.ellipsis, style: regularDefault.copyWith(color: MyColor.headingTextColor, letterSpacing: 0, fontWeight: FontWeight.w600)),
                                                    const SizedBox(width: Dimensions.space5),
                                                    MyAssetImageWidget(
                                                      assetPath: MyImages.guest,
                                                      isSvg: true,
                                                      height: Dimensions.space20.h,
                                                      width: Dimensions.space20.h,
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
          ),
        ),
      ),
    );
  }
}
