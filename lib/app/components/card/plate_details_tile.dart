import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class PlateDetailsTile extends StatelessWidget {
  final String image;
  final String title;
  final String value;
  final String cardButtonText;
  final bool showCard;
  const PlateDetailsTile({super.key, required this.image, required this.title, this.cardButtonText = "", required this.showCard, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.space12.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Row(
              children: [
                image != ""
                    ? MyAssetImageWidget(
                        assetPath: image,
                        isSvg: true,
                        height: Dimensions.space16.h,
                        width: Dimensions.space16.h,
                      )
                    : SizedBox.shrink(),
                spaceSide(Dimensions.space2),
                Text(
                  title.tr,
                  style: regularDefault.copyWith(
                    color: MyColor.hintTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          showCard == true
              ? CustomAppCard(
                  gradient: LinearGradient(
                    colors: MyColor.colors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  useGradient: true,
                  radius: Dimensions.cardRadius + 3,
                  padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space4.h, horizontal: Dimensions.space16.w),
                  child: Text(cardButtonText.tr,
                      style: regularLarge.copyWith(
                        color: MyColor.headingTextColor,
                        fontWeight: FontWeight.w600,
                      )))
              : Flexible(
                  child: Text(
                    value,
                    style: regularLarge.copyWith(
                      color: MyColor.headingTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
        ],
      ),
    );
  }
}
