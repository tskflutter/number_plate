import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/bottom-nav-bar/bottom_nav_1.dart';
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
import 'package:ovolutter/app/screens/plate_details/controller/plate_details_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/repo/plate_details/plate_details_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class RequestPlateDetailsScreen extends StatefulWidget {
  const RequestPlateDetailsScreen({super.key});

  @override
  State<RequestPlateDetailsScreen> createState() => _RequestPlateDetailsScreenState();
}

class _RequestPlateDetailsScreenState extends State<RequestPlateDetailsScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    Get.put(MyAdsPlateDetailsRepo());
    final controller = Get.put(PlateDetailsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.id = Get.arguments[0];

      controller.plateDetailsData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PlateDetailsController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.details.tr,
        actionButton: [
          ActionButton(
              ontap: () {
                Get.back();
                Get.back();
                bottomNavKey.currentState?.changeTab(1);
              },
              image: MyImages.fav),
          spaceSide(Dimensions.space8),
        ],
        body: controller.isLoading
            ? CustomLoader()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  spaceDown(Dimensions.space5),
                  Text(
                    MyStrings.plateDetails.tr,
                    style: regularLarge.copyWith(fontFamily: 'poppins', fontWeight: FontWeight.w500),
                  ),
                  spaceDown(Dimensions.space5),
                  PlateDetailsCard(
                    isVip: controller.adsData?.adBoost != null
                        ? controller.adsData?.adBoost?.boostingType == "1"
                            ? true
                            : false
                        : false,
                    cityId: controller.adsData?.cityId ?? "",
                    letter: controller.adsData?.plateLetter ?? "",
                    number: controller.adsData?.plateNumber ?? "",
                    detailsSection: Column(
                      children: [
                        PlateDetailsTile(
                          image: MyImages.price,
                          title: MyStrings.price,
                          value: "${controller.defaultCurrency}${AppConverter.formatNumber(controller.adsData?.price ?? "", precision: 2)}",
                          showCard: false,
                        ),
                        spaceDown(Dimensions.space12),
                        PlateDetailsTile(
                          image: MyImages.vehicleType,
                          title: MyStrings.vehicleType,
                          value: "",
                          showCard: true,
                          cardButtonText: controller.adsData?.adType?.type ?? "",
                        ),
                        spaceDown(Dimensions.space12),
                        PlateDetailsTile(
                          image: MyImages.location,
                          title: MyStrings.location,
                          value: controller.adsData?.user?.address ?? "",
                          showCard: false,
                        ),
                        spaceDown(Dimensions.space12),
                        PlateDetailsTile(
                          image: MyImages.calender,
                          title: MyStrings.published,
                          value: DateConverter.isoStringToLocalDateOnly(controller.adsData?.createdAt ?? ""),
                          showCard: false,
                        ),
                        spaceDown(Dimensions.space12),
                      ],
                    ),
                  ),
                  spaceDown(Dimensions.space20),
                  Text(
                    MyStrings.contactDetails.tr,
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
                            name: controller.user.username ?? "",
                            subtitle: "${MyStrings.memberSince} ${DateConverter().formatRelativeDateFromJson(controller.user.createdAt ?? "")}",
                            userImage: "${UrlContainer.domainUrl}/${controller.user.imagePath}/${controller.user.image}",
                          ),
                          spaceDown(Dimensions.space20),
                          Row(
                            children: [
                              Expanded(
                                child: CardButton(
                                  text: MyStrings.call,
                                  press: () async {
                                    var url = Uri.parse("tel:+${controller.user.countryCode}${controller.user.mobile}");
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
                                    final url = Uri.parse("https://wa.me/${controller.user.countryCode}${controller.user.mobile}?text=${Uri.encodeComponent(MyStrings.hello.tr)}");
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
                      ))
                ],
              ),
      ),
    );
  }
}
