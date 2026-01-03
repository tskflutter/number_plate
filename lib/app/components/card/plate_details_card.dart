import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/glass_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class PlateDetailsCard extends StatefulWidget {
  final Widget? detailsSection;
  final Widget? promotionWidget;
  final bool isVip;
  final bool isPromotion;
  final bool showView;
  final bool showShadow;
  final String view;
  final String? cityId;
  final String? letter;
  final String? number;
  const PlateDetailsCard({super.key, required this.detailsSection, this.isVip = false, this.showView = false, this.view = "", this.showShadow = true, this.promotionWidget, this.isPromotion = false, this.cityId = "", this.letter = "", this.number = ""});

  @override
  State<PlateDetailsCard> createState() => _PlateDetailsCardState();
}

class _PlateDetailsCardState extends State<PlateDetailsCard> {
  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      radius: Dimensions.space12,
      borderColor: MyColor.plateBgColor,
      boxShadow: [
        widget.showShadow
            ? BoxShadow(
                color: MyColor.black.withValues(alpha: .30),
                blurRadius: 5,
                offset: Offset(0, .8),
              )
            : BoxShadow(),
      ],
      showShadow: widget.showShadow,
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.space4),
            child: Stack(
              children: [
                CustomGlassContainer(
                  borderRadius: Dimensions.space8,
                  margin: EdgeInsets.all(Dimensions.space4),
                  height: Dimensions.space170,
                  width: double.infinity,
                  hasColor: true,
                  child: CustomAppCard(
                      borderWidth: 1,
                      borderColor: MyColor.headingTextColor,
                      radius: Dimensions.space8,
                      padding: EdgeInsets.zero,
                      margin: EdgeInsets.symmetric(vertical: 40, horizontal: Dimensions.space45),
                      child: Row(
                        children: [
                          Container(
                              decoration: BoxDecoration(color: MyColor.orangeShade, borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(Dimensions.space8), bottomStart: Radius.circular(Dimensions.space8))),
                              height: context.height,
                              width: 30,
                              child: Center(
                                child: Text(
                                  "I\nR\nQ\nKR",
                                  textAlign: TextAlign.center,
                                  style: boldDefault.copyWith(fontFamily: 'FE-FONT', color: MyColor.headingTextColor, letterSpacing: 1, height: 1.1, fontSize: Dimensions.space14, fontWeight: FontWeight.w900),
                                ),
                              )),
                          Container(
                            decoration: BoxDecoration(color: MyColor.headingTextColor, borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(Dimensions.space4), bottomStart: Radius.circular(Dimensions.space4))),
                            height: context.height,
                            width: 1,
                          ),
                          Expanded(
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: Dimensions.space10),
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: boldExtraLarge.copyWith(
                                        color: MyColor.headingTextColor,
                                        // fontFamily removed
                                      ),
                                      children: [
                                        TextSpan(
                                          text: widget.cityId ?? "",
                                          style: boldExtraLarge.copyWith(
                                            fontFamily: 'FE-FONT',
                                            fontSize: Dimensions.space32,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " • ",
                                          style: boldExtraLarge.copyWith(
                                            fontSize: Dimensions.space32,
                                          ),
                                        ), // spacing instead of •
                                        TextSpan(
                                          text: "${widget.letter} ${widget.number}",
                                          style: boldExtraLarge.copyWith(
                                            fontFamily: 'FE-FONT',
                                            fontSize: Dimensions.space32,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        ],
                      )),
                ),
                widget.isPromotion
                    ? Positioned(
                        top: 0,
                        left: 0,
                        child: GlassContainer(
                          color: MyColor.white.withValues(alpha: .3),
                          blur: 2,
                          opacity: .05,
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(Dimensions.cardRadius), topLeft: Radius.circular(Dimensions.space8)),
                          child: Padding(
                            padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space8.w, horizontal: Dimensions.space16.h),
                            child: widget.promotionWidget,
                          ),
                        ),
                      )
                    : SizedBox(),
                widget.isVip
                    ? Positioned(
                        top: 10,
                        right: Dimensions.space10,
                        child: MyAssetImageWidget(
                          assetPath: MyImages.vipCard,
                          width: 55,
                          height: 25,
                          boxFit: BoxFit.contain,
                        ),
                      )
                    : SizedBox(),
                widget.showView
                    ? Positioned(
                        bottom: 8,
                        left: 8,
                        child: CustomAppCard(
                            radius: Dimensions.space8,
                            borderColor: MyColor.hintTextColor.withValues(alpha: .5),
                            padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space8.w, vertical: Dimensions.space2),
                            child: Row(
                              children: [
                                MyAssetImageWidget(
                                  assetPath: MyImages.eyeVisibleIcon,
                                  isSvg: true,
                                  height: Dimensions.space16.h,
                                  width: Dimensions.space16.h,
                                ),
                                Text(
                                  "${widget.view} Views",
                                  style: semiBoldDefault.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w600),
                                ),
                                spaceSide(Dimensions.space4),
                                MyAssetImageWidget(
                                  assetPath: MyImages.up,
                                  isSvg: true,
                                  height: Dimensions.space16.h,
                                  width: Dimensions.space16.h,
                                )
                              ],
                            )),
                      )
                    : SizedBox()
              ],
            ),
          ),
          widget.detailsSection != null
              ? Container(
                  padding: EdgeInsets.symmetric(
                    vertical: Dimensions.space8,
                    horizontal: Dimensions.space8,
                  ),
                  decoration: BoxDecoration(
                    color: MyColor.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(Dimensions.cardRadius - 2),
                      bottomRight: Radius.circular(Dimensions.cardRadius - 1),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: widget.detailsSection)
              : SizedBox(),
        ],
      ),
    );
  }
}
