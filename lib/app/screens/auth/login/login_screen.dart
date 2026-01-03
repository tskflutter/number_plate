import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/login_controller.dart';
import 'package:ovolutter/data/controller/auth/social_login_controller.dart';
import 'package:ovolutter/data/repo/auth/login_repo.dart';
import 'package:ovolutter/data/repo/auth/social_login_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:ovolutter/environment.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/buttons/my_text_button.dart';
import 'package:ovolutter/app/components/text-field/label_text_field.dart';
import 'package:ovolutter/app/components/text/default_text.dart';
import 'package:ovolutter/app/screens/auth/login/widget/social_login_section.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(LoginRepo());
    Get.put(LoginController(loginRepo: Get.find()));
    Get.put(SocialLoginRepo());
    Get.put(SocialLoginController(repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<LoginController>().remember = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegionWidget(
      systemNavigationBarColor: MyColor.darkScaffoldBackground,
      statusBarColor: MyColor.getTransparentColor(),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      padding: EdgeInsets.zero,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // CHANGED: Set to false to prevent resizing
        backgroundColor: MyColor.transparent,
        body: GetBuilder<LoginController>(
          builder: (controller) => Stack(
            children: [
              // CHANGED: Positioned to fill entire screen regardless of keyboard
              Positioned.fill(
                child: MyAssetImageWidget(
                  assetPath: MyImages.authBg,
                  height: double.infinity,
                  width: double.infinity,
                  boxFit: BoxFit.cover, // CHANGED: Use cover instead of contain
                ),
              ),
              // CHANGED: Wrap content in SafeArea and make scrollable
              SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom, // CHANGED: Add padding for keyboard
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.demologo,
                            boxFit: BoxFit.contain,
                            height: 30,
                          ),
                          spaceDown(Dimensions.space32.h),
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
                            MyStrings.enterEmailPassToContinue.tr,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SocialLoginSection(),
                                      CustomTextField(
                                        controller: controller.emailController,
                                        onChanged: () {},
                                        labelText: MyStrings.enterYourEmail.toTitleCase().tr,
                                        hintText: MyStrings.emailHint.tr,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return MyStrings.fieldErrorMsg.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      spaceDown(Dimensions.space16),
                                      CustomTextField(
                                        onChanged: () {},
                                        labelText: MyStrings.password.tr,
                                        controller: controller.passwordController,
                                        hintText: MyStrings.passwordHint,
                                        isPassword: true,
                                        isShowSuffixIcon: true,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return MyStrings.fieldErrorMsg.tr;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      spaceDown(Dimensions.space16),
                                      GestureDetector(
                                        onTap: () {
                                          controller.changeRememberMe();
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                  height: 25,
                                                  child: Checkbox(
                                                    shape: ContinuousRectangleBorder(
                                                      borderRadius: BorderRadius.circular(Dimensions.space8),
                                                    ),
                                                    overlayColor: WidgetStatePropertyAll(MyColor.getPrimaryColor()),
                                                    splashRadius: 4,
                                                    activeColor: MyColor.darkInformation,
                                                    checkColor: MyColor.white,
                                                    value: controller.remember,
                                                    side: WidgetStateBorderSide.resolveWith(
                                                      (states) => BorderSide(
                                                        width: 1.0,
                                                        color: controller.remember ? MyColor.getBorderColor() : MyColor.getBorderColor(),
                                                      ),
                                                    ),
                                                    onChanged: (value) {
                                                      controller.changeRememberMe();
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                DefaultText(
                                                  text: MyStrings.rememberMe.tr,
                                                  textColor: MyColor.headingTextColor,
                                                  textStyle: regularDefault.copyWith(fontWeight: FontWeight.w400),
                                                )
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.clearTextField();
                                                Get.toNamed(RouteHelper.forgotPasswordScreen);
                                              },
                                              child: DefaultText(
                                                text: MyStrings.forgotPassword.tr,
                                                textStyle: regularDefault.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  color: MyColor.darkInformation,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      spaceDown(Dimensions.space24),
                                      CustomElevatedBtn(
                                        isLoading: controller.isSubmitLoading,
                                        text: MyStrings.login.tr,
                                        onTap: () {
                                          if (formKey.currentState!.validate()) {
                                            controller.loginUser();
                                          }
                                        },
                                        height: 55,
                                        radius: Dimensions.largeRadius,
                                      ),
                                      spaceDown(Dimensions.space20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            MyStrings.doNotHaveAccount.tr,
                                            overflow: TextOverflow.ellipsis,
                                            style: regularDefault.copyWith(
                                              color: MyColor.headingTextColor,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(width: Dimensions.space5),
                                          CustomTextButton(
                                            onTap: () {
                                              Get.offAndToNamed(RouteHelper.registrationScreen);
                                            },
                                            text: MyStrings.createAnAccount.tr,
                                            style: regularDefault.copyWith(
                                              color: MyColor.darkInformation,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                      spaceDown(Dimensions.space20),
                                      GestureDetector(
                                        onTap: () {
                                          SharedPreferenceService.setAccessToken("");
                                          Get.toNamed(RouteHelper.bottomNavBar);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              MyStrings.continueAsGuest.tr,
                                              overflow: TextOverflow.ellipsis,
                                              style: regularDefault.copyWith(
                                                color: MyColor.headingTextColor,
                                                letterSpacing: 0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(width: Dimensions.space5),
                                            MyAssetImageWidget(
                                              assetPath: MyImages.guest,
                                              isSvg: true,
                                              height: Dimensions.space20.h,
                                              width: Dimensions.space20.h,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
