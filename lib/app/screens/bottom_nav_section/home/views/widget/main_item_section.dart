import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/circle_animated_button_with_text.dart';
import 'package:ovolutter/app/components/image/custom_svg_picture.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/data/controller/home/home_controller.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/my_strings.dart';

class MainItemSection extends StatelessWidget {
  const MainItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space10),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CircleAnimatedButtonWithText(
                        buttonName: MyStrings.deposit,
                        backgroundColor: MyColor.getInformationColor().withValues(alpha: 0.1),
                        child: Image.asset(MyImages.addMoney, color: MyColor.getInformationColor(), height: 20, width: 20),
                        onTap: () => Get.toNamed(
                              RouteHelper.depositsHistoryScreen,
                            ))),
                Expanded(child: CircleAnimatedButtonWithText(buttonName: MyStrings.depositHistory, backgroundColor: MyColor.getInformationColor().withValues(alpha: 0.1), child: Image.asset(MyImages.addMoneyHistory, color: MyColor.getInformationColor(), height: 20, width: 20), onTap: () => Get.toNamed(RouteHelper.addMoneyHistoryScreen))),
                Expanded(
                    child: CircleAnimatedButtonWithText(
                        buttonName: MyStrings.transactions,
                        //height: 40, width: 40,
                        backgroundColor: MyColor.getInformationColor().withValues(alpha: 0.1),
                        child: CustomSvgPicture(image: MyImages.viewTransaction, color: MyColor.getInformationColor(), height: 20, width: 20),
                        onTap: () => Get.toNamed(RouteHelper.transactionHistoryScreen))),
                Expanded(child: CircleAnimatedButtonWithText(buttonName: MyStrings.withdrawHistory, backgroundColor: MyColor.getInformationColor().withValues(alpha: 0.1), child: Image.asset(MyImages.withdrawHistory, color: MyColor.getInformationColor(), height: 17, width: 17), onTap: () => Get.toNamed(RouteHelper.withdrawScreen))),
                Expanded(
                    child: CircleAnimatedButtonWithText(
                  buttonName: MyStrings.withdrawMoney,
                  backgroundColor: MyColor.getInformationColor().withValues(alpha: 0.1),
                  child: Image.asset(
                    MyImages.withdrawMoney,
                    height: 20,
                    width: 20,
                    color: MyColor.getInformationColor(),
                  ),
                  onTap: () => Get.toNamed(RouteHelper.addWithdrawMethodScreen),
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
