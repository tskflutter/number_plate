import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/plate_details_card.dart';
import 'package:ovolutter/app/components/card/plate_details_tile.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/screens/list_plate/controller/liast_plate_controller.dart';
import 'package:ovolutter/app/screens/pay_now/controller/pay_now_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/list_plate/list_plate_repo.dart';
import 'package:ovolutter/data/repo/pay_now/pay_now_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class PayNowScreen extends StatefulWidget {
  const PayNowScreen({super.key});

  @override
  State<PayNowScreen> createState() => _PayNowScreenState();
}

class _PayNowScreenState extends State<PayNowScreen> {
  @override
  void initState() {
    Get.put(PayNowRepo());
    final controller = Get.put(PayNowController(repo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.myAdsData = Get.arguments[0];
      SharedPreferenceService.setMyAdsData(controller.myAdsData ?? AdsData());
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.listYourPlate.tr,
      centerTitle: true,
      body: GetBuilder<PayNowController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppCard(
                  showShadow: false,
                  borderColor: MyColor.dropDownFieldBorder,
                  child: Column(
                    children: [
                      MyAssetImageWidget(
                        assetPath: MyImages.fee,
                        isSvg: true,
                        height: Dimensions.space40.h,
                        width: Dimensions.space45.h,
                      ),
                      spaceDown(Dimensions.space12),
                      Text(
                        MyStrings.listingFeeRequired.tr,
                        style: semiBoldOverLarge.copyWith(fontSize: Dimensions.space22, color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                      ),
                      spaceDown(Dimensions.space4),
                      Text(
                        "${MyStrings.asANewSeller.tr} ${controller.defaultCurrency} ${AppConverter.formatNumber(controller.firstListingFee)} ${MyStrings.toPost.tr}",
                        textAlign: TextAlign.center,
                        style: regularLarge.copyWith(
                          color: MyColor.hintTextColor,
                        ),
                      )
                    ],
                  )),
              spaceDown(Dimensions.space24),
              CustomAppCard(
                  showShadow: false,
                  borderColor: MyColor.dropDownFieldBorder,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.money,
                            isSvg: true,
                            height: Dimensions.space40.h,
                            width: Dimensions.space45.h,
                          ),
                          spaceSide(Dimensions.space5),
                          Flexible(
                            child: Text(
                              MyStrings.listingFeeStructure.tr,
                              style: semiBoldOverLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                            ),
                          ),
                        ],
                      ),
                      spaceDown(Dimensions.space12),
                      feeStructureCard(
                        bgColor: MyColor.orangeShade.withValues(alpha: .08),
                        borderColor: MyColor.orangeShade,
                        text1: MyStrings.currentFirstListing,
                        text2: "${controller.defaultCurrency} ${AppConverter.formatNumber(controller.firstListingFee)}",
                        text3: MyStrings.youAreHere,
                        text4: MyStrings.oneTimeFirstlistiingFee,
                      ),
                      spaceDown(Dimensions.space12),
                      feeStructureCard(
                        bgColor: MyColor.greenShade.withValues(alpha: .08),
                        borderColor: MyColor.greenShade,
                        text1: MyStrings.nextListing,
                        text2: "${controller.defaultCurrency} ${AppConverter.formatNumber(controller.nextListingFee)}",
                        text3: "${controller.discountPercentage}% OFF",
                        text4: MyStrings.oneTimeFirstlistiingFee,
                      ),
                    ],
                  )),
              spaceDown(Dimensions.space24),
              Text(
                MyStrings.listingSummery.tr,
                style: semiBoldOverLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
              ),
              spaceDown(Dimensions.space24 / 4),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    MyStrings.totalAmount.tr,
                    style: regularDefault.copyWith(color: MyColor.headingTextColor),
                  ),
                  Flexible(
                    child: Text(
                      "${controller.defaultCurrency} ${AppConverter.formatNumber(controller.myAdsData?.listingFee ?? "")}",
                      style: regularDefault.copyWith(color: MyColor.headingTextColor, fontFamily: 'poppins', fontSize: Dimensions.space22.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              spaceDown(Dimensions.space16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyAssetImageWidget(
                    assetPath: MyImages.lock,
                    isSvg: true,
                    height: Dimensions.space16.h,
                    width: Dimensions.space16.h,
                  ),
                  Flexible(
                    child: Text(
                      MyStrings.yourPaymentInformationIsSafe.tr,
                      style: regularDefault.copyWith(color: MyColor.hintTextColor, fontFamily: 'poppins', fontSize: Dimensions.space12.sp),
                    ),
                  ),
                ],
              ),
              spaceDown(Dimensions.space16),
              CardButton(
                loaderColor: MyColor.white,
                icon: "",
                press: () {
                  Get.toNamed(RouteHelper.newDepositScreenScreen, arguments: [AppConverter.formatNumber(controller.myAdsData?.listingFee ?? ""), controller.myAdsData?.id, false]);
                  //     Get.toNamed(RouteHelper.paymentConfirmationScreen);
                },
                borderColor: MyColor.blackColorShadow,
                text: MyStrings.payAndSubmit,
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
