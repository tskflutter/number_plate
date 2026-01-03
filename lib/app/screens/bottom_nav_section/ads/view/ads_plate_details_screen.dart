import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/action_button.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/glass_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/number_plate_card_box.dart';
import 'package:ovolutter/app/components/card/plate_details_card.dart';
import 'package:ovolutter/app/components/card/plate_details_tile.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/app/components/user_details/user_details_data.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/ads/controller/my_ads_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAdsPlateDetailsScreen extends StatefulWidget {
  const MyAdsPlateDetailsScreen({super.key});

  @override
  State<MyAdsPlateDetailsScreen> createState() => _MyAdsPlateDetailsScreenState();
}

class _MyAdsPlateDetailsScreenState extends State<MyAdsPlateDetailsScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    final controller = Get.put(MyAdsController(repo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.id = Get.arguments[0] ?? "";

      controller.plateDetailsData();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.plateDetails.tr,
      centerTitle: true,
      body: GetBuilder<MyAdsController>(
        builder: (controller) => controller.isLoading
            ? CustomLoader()
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceDown(Dimensions.space5),
                    Text(
                      MyStrings.vipNumber.tr,
                      style: regularLarge.copyWith(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                    ),
                    spaceDown(Dimensions.space5),
                    PlateDetailsCard(
                      isVip: controller.myAdsData?.adBoost != null
                          ? controller.myAdsData?.adBoost?.boostingType == "1"
                              ? true
                              : false
                          : false,
                      showView: true,
                      view: "1000",
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
                            image: MyImages.location,
                            title: MyStrings.location,
                            value: controller.myAdsData?.user?.address ?? "",
                            showCard: false,
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
                    spaceDown(Dimensions.space20),
                    Text(
                      MyStrings.myDetails.tr,
                      style: regularLarge.copyWith(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                    ),
                    spaceDown(Dimensions.space5),
                    CustomAppCard(
                        borderColor: MyColor.black.withValues(alpha: .10),
                        padding: EdgeInsetsDirectional.all(Dimensions.space16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UserDetailsData(
                              name: controller.myAdsData?.user?.username ?? "",
                              subtitle: "${MyStrings.memberSince.tr} ${DateConverter().formatRelativeDateFromJson(controller.myAdsData?.user?.createdAt ?? "")}",
                              userImage: "${UrlContainer.domainUrl}/${controller.myAdsData?.user?.imagePath}/${controller.myAdsData?.user?.image}",
                            ),
                            spaceDown(Dimensions.space20),
                            Row(
                              children: [
                                Expanded(
                                  child: CardButton(
                                    text: MyStrings.call,
                                    press: () async {
                                      var url = Uri.parse("tel:+${controller.myAdsData?.user?.countryCode}${controller.myAdsData?.user?.mobile}");
                                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                        throw Exception('Could not launch $url');
                                      }
                                    },
                                    borderColor: MyColor.blackColorShadow,
                                    icon: MyImages.call,
                                  ),
                                ),
                                spaceSide(Dimensions.space8),
                                Expanded(
                                  child: CardButton(
                                    bgColor: MyColor.greenColor,
                                    text: MyStrings.whatsApp,
                                    press: () async {
                                      final url = Uri.parse("https://wa.me/${controller.myAdsData?.user?.countryCode}${controller.myAdsData?.user?.mobile}?text=${Uri.encodeComponent(MyStrings.hello.tr)}");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(url, mode: LaunchMode.externalApplication);
                                      } else {
                                        print("Could not launch $url");
                                      }
                                    },
                                    borderColor: MyColor.greenColorShadow,
                                    icon: MyImages.chat,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    spaceDown(Dimensions.space40),
                    CustomAppCard(
                        padding: EdgeInsets.all(Dimensions.space16),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.1, 1.0],
                          colors: [
                            Color(0xFF23C97C),
                            Color(0xFF23C97C),
                            Color(0xFF24AE6E),
                          ],
                        ),
                        useGradient: true,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyAssetImageWidget(
                                  assetPath: MyImages.boost,
                                  isSvg: true,
                                  height: Dimensions.space65.h,
                                  width: Dimensions.space65.h,
                                ),
                                spaceSide(Dimensions.space4),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Text(
                                        MyStrings.boostYourListingWithPromotions.tr,
                                        style: boldOverLarge.copyWith(color: MyColor.white, fontWeight: FontWeight.w800, fontFamily: 'poppins'),
                                      ),
                                      Text(
                                        MyStrings.getTenXMore.tr,
                                        style: regularSmall.copyWith(
                                          color: MyColor.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            spaceDown(Dimensions.space20),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomAppCard(
                                        padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space7),
                                        showBorder: false,
                                        backgroundColor: MyColor.boostButtonBg,
                                        child: Column(
                                          children: [
                                            MyAssetImageWidget(
                                              assetPath: MyImages.threeStar,
                                              isSvg: true,
                                              height: Dimensions.space40,
                                            ),
                                            spaceDown(Dimensions.space4),
                                            Text(
                                              MyStrings.premiumHomePagePlacement.tr,
                                              textAlign: TextAlign.center,
                                              style: regularSmall.copyWith(color: MyColor.greenAccent, fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )),
                                  ),
                                  spaceSide(Dimensions.space8),
                                  Expanded(
                                    child: CustomAppCard(
                                        showBorder: false,
                                        backgroundColor: MyColor.boostButtonBg,
                                        child: Column(
                                          children: [
                                            MyAssetImageWidget(
                                              assetPath: MyImages.views,
                                              isSvg: true,
                                              height: Dimensions.space40,
                                            ),
                                            spaceDown(Dimensions.space4),
                                            Text(
                                              MyStrings.tenXMoreView.tr,
                                              textAlign: TextAlign.center,
                                              style: regularSmall.copyWith(color: MyColor.greenAccent, fontWeight: FontWeight.w600),
                                            )
                                          ],
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            spaceDown(Dimensions.space20),
                            CardButton(
                              icon: "",
                              press: () {
                                Get.toNamed(RouteHelper.promotePlanScreen, arguments: [controller.myAdsData?.id ?? "", controller.myAdsData]);
                              },
                              borderColor: MyColor.blackColorShadow,
                              text: MyStrings.boostNow,
                            )
                          ],
                        )),
                    spaceDown(Dimensions.space40),
                  ],
                ),
              ),
      ),
      bottomNav: GetBuilder<MyAdsController>(
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
                      isLoading: controller.soldPlate,
                      icon: "",
                      press: () {
                        controller.soldPlateData();
                      },
                      showShadow: false,
                      bgColor: MyColor.lightBackground,
                      borderColor: MyColor.lightTextFieldBorder,
                      text: MyStrings.addToPlateSold,
                      textColor: MyColor.headingTextColor,
                    ),
                  ),
                  spaceSide(Dimensions.space8),
                  Expanded(
                    child: CardButton(
                      icon: "",
                      isLoading: controller.deletingPlate,
                      press: () {
                        controller.deletePlate(controller.id);
                      },
                      bgColor: MyColor.darkError,
                      borderColor: MyColor.white.withValues(alpha: .25),
                      text: MyStrings.deletePlate,
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
}
