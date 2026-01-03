import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class NotLoggedinWidget extends StatelessWidget {
  final double margin;
  final String? text;
  const NotLoggedinWidget({
    super.key,
    this.margin = 4,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height / margin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          MyAssetImageWidget(isSvg: true, assetPath: MyImages.personImage, height: Dimensions.space100.h, width: Dimensions.space100.w),
          const SizedBox(height: Dimensions.space3),
          Text(
            MyStrings.youAreNotLoggedIn.tr,
            style: semiBoldMediumLarge.copyWith(color: MyColor.primaryTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
          ),
          spaceDown(Dimensions.space5),
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: semiBoldMediumLarge.copyWith(color: MyColor.hintTextColor, fontWeight: FontWeight.w400, fontFamily: 'poppins'),
          ),
          spaceDown(Dimensions.space160),
          CustomElevatedBtn(
            text: MyStrings.login.tr,
            onTap: () {
              Get.offAllNamed(RouteHelper.loginScreen);
            },
            height: 55,
            radius: Dimensions.largeRadius,
          ),
        ],
      ),
    );
  }
}
