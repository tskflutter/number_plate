import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/plate_details_card.dart';
import 'package:ovolutter/app/components/card/plate_details_tile.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/screens/pay_now/controller/pay_now_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  const PaymentConfirmationScreen({super.key});

  @override
  State<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.listingConfirmation.tr,
      centerTitle: true,
      body: GetBuilder<PayNowController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  MyAssetImageWidget(
                    assetPath: MyImages.submited,
                    isSvg: true,
                    height: Dimensions.space72.h,
                    width: Dimensions.space72.h,
                  ),
                  spaceDown(Dimensions.space12),
                  Text(
                    MyStrings.listingSubmitted.tr,
                    style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space22, color: MyColor.headingTextColor, fontWeight: FontWeight.w700, fontFamily: 'poppins'),
                  ),
                  spaceDown(Dimensions.space4),
                  Text(
                    MyStrings.yourPaymentConfirmed.tr,
                    textAlign: TextAlign.center,
                    style: regularLarge.copyWith(
                      color: MyColor.hintTextColor,
                    ),
                  )
                ],
              ),
              spaceDown(Dimensions.space32),
              PlateDetailsCard(
                isVip: controller.myAdsData?.adBoost != null
                    ? controller.myAdsData?.adBoost?.boostingType == "1"
                        ? true
                        : false
                    : false,
                cityId: controller.myAdsData?.cityId ?? "",
                letter: controller.myAdsData?.plateLetter ?? "",
                number: controller.myAdsData?.plateNumber ?? "",
                detailsSection: Column(
                  children: [
                    PlateDetailsTile(
                      image: MyImages.price,
                      title: MyStrings.price,
                      value: "${controller.defaultCurrency}${AppConverter.formatNumber(controller.myAdsData?.price ?? "", precision: 2)}",
                      showCard: false,
                    ),
                    spaceDown(Dimensions.space12),
                    PlateDetailsTile(
                      image: MyImages.vehicleType,
                      title: MyStrings.vehicleType,
                      value: "",
                      showCard: true,
                      cardButtonText: controller.myAdsData?.adType?.type ?? "",
                    ),
                    spaceDown(Dimensions.space12),
                    PlateDetailsTile(
                      image: MyImages.calender,
                      title: MyStrings.published,
                      value: DateConverter.isoStringToLocalDateOnly(controller.myAdsData?.createdAt ?? ""),
                      showCard: false,
                    ),
                    spaceDown(Dimensions.space12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNav: GetBuilder<PayNowController>(
        builder: (controller) => Container(
          padding: EdgeInsets.all(Dimensions.space16),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: MyColor.black.withValues(alpha: .15),
              blurRadius: 4,
              spreadRadius: 4,
              offset: const Offset(6, 0),
            ),
          ], color: MyColor.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.cardRadius), topRight: Radius.circular(Dimensions.cardRadius))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              spaceDown(Dimensions.space16),
              Row(
                children: [
                  Expanded(
                    child: CardButton(
                      icon: "",
                      press: () {
                        Get.offAllNamed(RouteHelper.bottomNavBar);
                      },
                      showShadow: false,
                      bgColor: MyColor.lightBackground,
                      borderColor: MyColor.lightTextFieldBorder,
                      text: MyStrings.allPlates,
                      textColor: MyColor.headingTextColor,
                    ),
                  ),
                  spaceSide(Dimensions.space8),
                  Expanded(
                    child: CardButton(
                      icon: "",
                      press: () {
                        Get.offAndToNamed(RouteHelper.myAdsScreen);
                      },
                      borderColor: MyColor.blackColorShadow,
                      text: MyStrings.goToMyListing,
                    ),
                  ),
                ],
              ),
              spaceDown(Dimensions.space25)
            ],
          ),
        ),
      ),
    );
  }

  Widget feeStructureCard({required Color bgColor, required Color borderColor, required String text1, text2, text3, text4}) {
    return CustomAppCard(
        showShadow: false,
        backgroundColor: bgColor,
        borderColor: borderColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    text1,
                    style: regularLarge.copyWith(
                      color: MyColor.headingTextColor,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    text2,
                    style: semiBoldOverLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                  ),
                ),
              ],
            ),
            spaceDown(Dimensions.space16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomAppCard(
                    radius: Dimensions.space35,
                    padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space4.h, horizontal: Dimensions.space8.h),
                    showBorder: false,
                    backgroundColor: borderColor,
                    child: Text(
                      text3,
                      style: regularSmall.copyWith(
                        color: MyColor.headingTextColor,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    text4,
                    style: regularSmall.copyWith(
                      color: MyColor.headingTextColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
