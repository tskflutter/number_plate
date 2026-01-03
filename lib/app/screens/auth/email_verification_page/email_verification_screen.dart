import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/auth/email_verification_controler.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/data/repo/auth/sms_email_verification_repo.dart';

import '../../../components/image/custom_svg_picture.dart';
import '../../../components/otp_field_widget/otp_field_widget.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    Get.put(SmsEmailVerificationRepo());
    Get.put(GeneralSettingRepo());
    final controller = Get.put(EmailVerificationController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return WillPopWidget(
      nextRoute: RouteHelper.loginScreen,
      child: Scaffold(
          body: GetBuilder<EmailVerificationController>(
        builder: (controller) => controller.isLoading
            ? Center(child: CircularProgressIndicator(color: MyColor.getPrimaryColor()))
            : Stack(
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
                                    MyStrings.emailVerification.tr,
                                    style: boldExtraLarge.copyWith(fontSize: Dimensions.space32, fontWeight: FontWeight.w800, fontFamily: 'poppin', color: MyColor.white, letterSpacing: 0),
                                  ),
                                  spaceDown(Dimensions.space12.h),
                                  Text(
                                    MyStrings.verifyCode.tr,
                                    style: regularDefault.copyWith(color: MyColor.white),
                                  ),
                                  spaceDown(Dimensions.space32.h),
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
                                            MyStrings.confirmYourEmail,
                                            style: boldExtraLarge.copyWith(fontSize: Dimensions.fontHeader.sp - 2),
                                          ),
                                          spaceDown(Dimensions.space8),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: MyStrings.weveSend6DigitCodeTo.tr,
                                                  style: regularLarge.copyWith(
                                                    color: MyColor.hintTextColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: " ${controller.userMail}",
                                                  style: regularLarge.copyWith(
                                                    color: MyColor.darkInformation,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          spaceDown(Dimensions.space24),
                                          Align(
                                            alignment: AlignmentDirectional.centerStart,
                                            child: Text(
                                              MyStrings.enterVerificationCode,
                                              style: regularDefault.copyWith(color: MyColor.headingTextColor),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          spaceDown(Dimensions.space16),
                                          Flexible(
                                            child: OTPFieldWidget(
                                              onChanged: (value) {
                                                controller.currentText = value;
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: Dimensions.space30),
                                          Row(
                                            children: [
                                              MyAssetImageWidget(
                                                assetPath: MyImages.watch,
                                                isSvg: true,
                                                height: Dimensions.space16.h,
                                                width: Dimensions.space16.h,
                                              ),
                                              const SizedBox(width: 6),

                                              /// Countdown Text
                                              controller.canResend
                                                  ? Text(
                                                      MyStrings.didNotReceiveCode.tr,
                                                      style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
                                                    )
                                                  : Text(
                                                      "Resend code in 00:${controller.resendSeconds.toString().padLeft(2, '0')}",
                                                      style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
                                                    ),

                                              const Spacer(),

                                              /// Resend Button
                                              controller.isResendLoading
                                                  ? SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(
                                                        color: MyColor.getPrimaryColor(),
                                                        strokeWidth: 2,
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: controller.canResend
                                                          ? () {
                                                              controller.sendCodeAgain();
                                                            }
                                                          : null,
                                                      child: Text(
                                                        MyStrings.resendCode.tr,
                                                        style: theme.textTheme.labelMedium?.copyWith(
                                                          fontWeight: FontWeight.w600,
                                                          color: controller.canResend ? MyColor.getPrimaryColor() : MyColor.hintTextColor,
                                                          decoration: controller.canResend ? TextDecoration.underline : TextDecoration.none,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                          const SizedBox(height: Dimensions.space30),
                                          CustomElevatedBtn(
                                            isLoading: controller.submitLoading,
                                            text: MyStrings.verify.tr,
                                            onTap: () {
                                              controller.verifyEmail(controller.currentText);
                                            },
                                          ),
                                          spaceDown(Dimensions.space10)
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )));
                  })
                ],
              ),
      )),
    );
  }
}
