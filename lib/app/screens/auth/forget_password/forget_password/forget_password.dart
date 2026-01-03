import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/custom_svg_picture.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/forget_password/forget_password_controller.dart';
import 'package:ovolutter/data/repo/auth/login_repo.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.put(LoginRepo());
    Get.put(ForgetPasswordController(loginRepo: Get.find()));

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ForgetPasswordController>(
      builder: (auth) => Stack(
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
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                            spaceDown(Dimensions.space12.h),
                            Padding(
                              padding: Dimensions.screenPadding,
                              child: Text(
                                MyStrings.forgetPasswordSubText.tr,
                                textAlign: TextAlign.center,
                                style: regularDefault.copyWith(color: MyColor.white),
                              ),
                            ),
                            spaceDown(Dimensions.space20.h),
                            Flexible(
                              child: CustomAppCard(
                                radius: Dimensions.cardRadius * 2,
                                margin: EdgeInsetsDirectional.only(start: Dimensions.space16.w, end: Dimensions.space16.w, bottom: Dimensions.space40),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const SizedBox(height: Dimensions.space30),
                                    CustomSvgPicture(
                                      image: MyImages.emailVerifyImage,
                                      height: 100,
                                      width: 125,
                                    ),
                                    spaceDown(Dimensions.space24),
                                    Text(
                                      MyStrings.enterYourEmailAddress.toTitleCase().tr,
                                      style: boldExtraLarge.copyWith(fontSize: Dimensions.fontHeader.sp - 2),
                                    ),
                                    spaceDown(Dimensions.space24),
                                    Text(
                                      MyStrings.weWillSendInstruction.tr,
                                      style: regularLarge.copyWith(
                                        color: MyColor.hintTextColor,
                                      ),
                                    ),
                                    spaceDown(Dimensions.space16),
                                    CustomTextField(
                                        controller: auth.emailOrUsernameController,
                                        onChanged: () {
                                          return;
                                        },
                                        fillColor: MyColor.transparent,
                                        borderColor: MyColor.headingTextColor,
                                        labelText: MyStrings.emailAddress.toTitleCase().tr,
                                        hintText: MyStrings.emailHint.tr,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(Dimensions.space12),
                                          child: MyAssetImageWidget(
                                            assetPath: MyImages.mail,
                                            isSvg: true,
                                            height: Dimensions.space24.h,
                                            width: Dimensions.space24.h,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (auth.emailOrUsernameController.text.isEmpty) {
                                            return MyStrings.enterEmailOrUserName.tr;
                                          } else {
                                            return null;
                                          }
                                        }),
                                    const SizedBox(height: Dimensions.space30),
                                    CustomElevatedBtn(
                                      isLoading: auth.submitLoading,
                                      text: MyStrings.sendVerificationCode.tr,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          auth.submitForgetPassCode();
                                        }
                                      },
                                    ),
                                    spaceDown(Dimensions.space10)
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )));
          })
        ],
      ),
    ));
  }
}
