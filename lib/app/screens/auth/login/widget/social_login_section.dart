import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/buttons/custom_outlined_button.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/auth/social_login_controller.dart';
import 'package:ovolutter/data/repo/auth/social_login_repo.dart';
import 'package:get/get.dart';

import '../../../../../core/utils/my_color.dart';
import '../../../../../core/utils/my_images.dart';
import '../../../../../core/utils/my_strings.dart';

class SocialLoginSection extends StatefulWidget {
  const SocialLoginSection({super.key});

  @override
  State<SocialLoginSection> createState() => _SocialLoginSectionState();
}

class _SocialLoginSectionState extends State<SocialLoginSection> {
  @override
  void initState() {
    Get.put(SocialLoginRepo());
    Get.put(SocialLoginController(repo: Get.find()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<SocialLoginController>(builder: (controller) {
      return Visibility(
        visible: controller.checkSocialAuthActiveOrNot(provider: 'all'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (controller.checkSocialAuthActiveOrNot(provider: 'google')) ...[
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithGoogle.tr,
                onTap: () {
                  controller.signInWithGoogle();
                },
                isLoading: controller.isGoogleSignInLoading,
                radius: 12,
                height: 50,
                icon: MyAssetImageWidget(
                  assetPath: MyImages.google,
                  height: Dimensions.space18.h,
                  width: Dimensions.space18.h,
                  boxFit: BoxFit.cover,
                ),
              ),
            ],
            if (controller.checkSocialAuthActiveOrNot(provider: 'linkedin')) ...[
              const SizedBox(height: 15),
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithLinkedin.tr,
                onTap: () {
                  controller.signInWithLinkedin(context);
                },
                isLoading: controller.isLinkedinLoading,
                textColor: MyColor.getBodyTextColor(),
                radius: 12,
                height: 50,
                icon: Image.asset(
                  MyImages.linkedin,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
            if (controller.checkSocialAuthActiveOrNot(provider: 'facebook')) ...[
              const SizedBox(height: 15),
              CustomOutlinedBtn(
                btnText: MyStrings.signInWithFacebook.tr,
                onTap: () {},
                textColor: MyColor.getBodyTextColor(),
                radius: 12,
                height: 50,
                icon: Image.asset(
                  MyImages.facebook,
                  height: 22,
                  width: 22,
                ),
              ),
            ],
            Padding(
              padding: EdgeInsets.symmetric(vertical: Dimensions.space24.h),
              child: Row(
                children: [
                  Expanded(child: CustomDivider(space: 0)),
                  spaceSide(Dimensions.space16),
                  Text(
                    MyStrings.or.tr,
                    style: regularSmall.copyWith(color: MyColor.hintTextColor),
                  ),
                  spaceSide(Dimensions.space16),
                  Expanded(child: CustomDivider(space: 0)),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
