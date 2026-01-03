import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class CardButton extends StatelessWidget {
  final VoidCallback press;
  final String icon;
  final String? text;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final Color contentColor;
  final Color loaderColor;
  final bool isText;
  final bool showShadow;
  final bool showBorder;
  final bool? isLoading;

  const CardButton({super.key, this.showBorder = true, this.text, required this.icon, this.isText = true, this.bgColor = MyColor.black, this.loaderColor = MyColor.primaryTextColor, this.contentColor = MyColor.white, required this.press, required this.borderColor, this.textColor = MyColor.white, this.showShadow = true, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: CustomAppCard(
        showShadow: showShadow,
        borderColor: showBorder ? borderColor.withValues(alpha: .9) : MyColor.transparent,
        borderWidth: 2,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: Dimensions.space12.w,
          vertical: Dimensions.space14.h,
        ),
        backgroundColor: bgColor,
        child: isLoading == true
            ? CustomLoader(loaderColor: loaderColor)
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text?.tr ?? "",
                    style: semiBoldLarge.copyWith(color: textColor),
                  ),
                  spaceSide(icon != "" ? Dimensions.space8.w : 0),
                  icon != ""
                      ? MyAssetImageWidget(
                          assetPath: icon,
                          isSvg: true,
                          height: Dimensions.space16.h,
                          width: Dimensions.space16.h,
                        )
                      : SizedBox.shrink()
                ],
              ),
      ),
    );
  }
}
