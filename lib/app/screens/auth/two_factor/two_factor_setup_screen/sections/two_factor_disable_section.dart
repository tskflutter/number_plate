import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/otp_field_widget/otp_field_widget.dart';
import 'package:ovolutter/app/components/text/small_text.dart';
import 'package:ovolutter/data/controller/auth/two_factor_controller.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_strings.dart';

class TwoFactorDisableSection extends StatelessWidget {
  const TwoFactorDisableSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<TwoFactorController>(builder: (twoFactorController) {
      return Column(
        children: [
          CustomAppCard(
              showBorder: false,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(
                  child: Text(
                    MyStrings.disable2Fa.tr,
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .07),
                  child: SmallText(text: MyStrings.twoFactorMsg.tr, maxLine: 3, textAlign: TextAlign.center, textStyle: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor())),
                ),
                const SizedBox(height: Dimensions.space50),
                OTPFieldWidget(
                  onChanged: (value) {
                    twoFactorController.currentText = value;
                    twoFactorController.update();
                  },
                ),
                const SizedBox(height: Dimensions.space30),
                CustomElevatedBtn(
                  isLoading: twoFactorController.submitLoading,
                  onTap: () {
                    twoFactorController.disable2fa(twoFactorController.currentText);
                  },
                  text: MyStrings.submit.tr,
                ),
                const SizedBox(height: Dimensions.space30),
              ])),
        ],
      );
    });
  }
}
