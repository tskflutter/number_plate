import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/forget_password/reset_password_controller.dart';
import 'package:ovolutter/data/repo/auth/login_repo.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(LoginRepo());
    final controller = Get.put(ResetPasswordController(loginRepo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.email = Get.arguments[0];
      controller.code = Get.arguments[1];
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
      child: WillPopWidget(
          nextRoute: RouteHelper.loginScreen,
          child: Scaffold(
              body: GetBuilder<ResetPasswordController>(
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                spaceDown(Dimensions.space50),
                                MyAssetImageWidget(
                                  assetPath: MyImages.demologo,
                                  boxFit: BoxFit.contain,
                                  height: 30,
                                ),
                                spaceDown(Dimensions.space32.h),
                                Text(
                                  MyStrings.resetPassword.tr,
                                  style: boldExtraLarge.copyWith(fontSize: Dimensions.space32, fontWeight: FontWeight.w800, fontFamily: 'poppin', color: MyColor.white, letterSpacing: 0),
                                ),
                                spaceDown(Dimensions.space32.h),
                                Flexible(
                                  child: CustomAppCard(
                                    radius: Dimensions.cardRadius * 2,
                                    margin: EdgeInsetsDirectional.only(start: Dimensions.space16.w, end: Dimensions.space16.w, bottom: Dimensions.space40),
                                    child: Form(
                                      key: formKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          spaceDown(Dimensions.space24),
                                          Text(
                                            MyStrings.enterNewPassword.toTitleCase().tr,
                                            style: boldExtraLarge.copyWith(fontSize: Dimensions.fontHeader.sp - 2),
                                          ),
                                          spaceDown(Dimensions.space16),
                                          Text(
                                            MyStrings.setComplexPass.tr,
                                            textAlign: TextAlign.center,
                                            style: regularLarge.copyWith(
                                              color: MyColor.hintTextColor,
                                            ),
                                          ),
                                          spaceDown(Dimensions.space16),
                                          CustomTextField(
                                            controller: controller.passController,
                                            onChanged: () {
                                              return;
                                            },
                                            fillColor: MyColor.transparent,
                                            borderColor: MyColor.headingTextColor,
                                            labelText: MyStrings.newPassword.toTitleCase().tr,
                                            hintText: MyStrings.passwordHint.tr,
                                            isPassword: true,
                                            isShowSuffixIcon: true,
                                            validator: (value) {
                                              if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                                                return MyStrings.kMatchPassError.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          spaceDown(Dimensions.space24),
                                          CustomTextField(
                                            controller: controller.confirmPassController,
                                            onChanged: () {
                                              return;
                                            },
                                            fillColor: MyColor.transparent,
                                            borderColor: MyColor.headingTextColor,
                                            labelText: MyStrings.confirmPassword.toTitleCase().tr,
                                            hintText: MyStrings.passwordHint.tr,
                                            isPassword: true,
                                            isShowSuffixIcon: true,
                                            validator: (value) {
                                              if (controller.passController.text.toLowerCase() != controller.confirmPassController.text.toLowerCase()) {
                                                return MyStrings.kMatchPassError.tr;
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                          const SizedBox(height: Dimensions.space30),
                                          CustomElevatedBtn(
                                            isLoading: controller.submitLoading,
                                            text: MyStrings.setNewPassword.tr,
                                            onTap: () {
                                              if (formKey.currentState!.validate()) {
                                                controller.resetPassword();
                                              }
                                            },
                                          ),
                                          spaceDown(Dimensions.space10)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )));
                })
              ],
            ),
          ))),
    );
  }
}
