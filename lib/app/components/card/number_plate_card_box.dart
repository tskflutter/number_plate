import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/glass_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class NumberPlateCardBox extends StatelessWidget {
  final String? number;
  final String? letter;
  final String? duration;
  final String? price;
  final String? cityId;
  final String? phNumber;
  final String? priceType;
  const NumberPlateCardBox({super.key, this.number = "G", this.letter = "1234", this.duration = "", this.price = "0", this.cityId = "", this.priceType, this.phNumber});

  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      radius: Dimensions.space5,
      showBorder: false,
      boxShadow: [
        BoxShadow(
          color: MyColor.black.withValues(alpha: .20),
          blurRadius: 3,
          offset: Offset(0, 2),
        ),
      ],
      showShadow: true,
      width: double.infinity,
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: CustomGlassContainer(
                borderRadius: Dimensions.space4,
                height: Dimensions.space120,
                padding: EdgeInsets.all(Dimensions.space8),
                hasColor: true,
                child: CustomAppCard(
                    borderWidth: 1,
                    borderColor: MyColor.headingTextColor,
                    radius: Dimensions.space5,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.symmetric(vertical: Dimensions.space30, horizontal: Dimensions.space8),
                    child: Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(color: MyColor.orangeShade, borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(Dimensions.space4), bottomStart: Radius.circular(Dimensions.space4))),
                            width: Dimensions.space20,
                            height: context.height,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                "I\nR\nQ\nKR",
                                textAlign: TextAlign.center,
                                style: boldDefault.copyWith(fontFamily: 'FE-FONT', color: MyColor.headingTextColor, letterSpacing: 0, height: 1.1, fontSize: Dimensions.space8, fontWeight: FontWeight.w900),
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
                                        text: cityId ?? "",
                                        style: boldExtraLarge.copyWith(
                                          fontFamily: 'FE-FONT',
                                          fontWeight: FontWeight.w400,
                                          fontSize: Dimensions.space32,
                                        ),
                                      ),
                                      TextSpan(
                                        text: " • ",
                                        style: boldExtraLarge.copyWith(
                                          fontSize: Dimensions.space32,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "$letter $number",
                                        style: boldExtraLarge.copyWith(
                                          fontFamily: 'FE-FONT',
                                          fontWeight: FontWeight.w400,
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
            ),
            Container(
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
              child: priceType == "1"
                  ? GestureDetector(
                      onTap: () async {
                        var url = Uri.parse("tel:$phNumber");
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          throw Exception('Could not launch $url');
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              MyStrings.callForPrice.tr,
                              style: regularDefault.copyWith(
                                color: MyColor.hintTextColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          MyAssetImageWidget(
                            assetPath: MyImages.call,
                            isSvg: true,
                            color: MyColor.headingTextColor,
                            height: Dimensions.space16.w,
                            width: Dimensions.space16.w,
                          ),
                        ],
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            duration ?? "",
                            style: regularDefault.copyWith(
                              color: MyColor.hintTextColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            price ?? "",
                            style: regularDefault.copyWith(
                              fontFamily: 'Inter-regular',
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
            ),
          ],
        ),
      ),
    );
  }
}
