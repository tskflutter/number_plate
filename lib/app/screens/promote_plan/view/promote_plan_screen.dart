import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/buttons/price_selection_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/screens/promote_plan/controller/promote_plan_controller.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/repo/promote_plan_repo/promote_plan_repo.dart';

class PromotePlanScreen extends StatefulWidget {
  const PromotePlanScreen({super.key});

  @override
  State<PromotePlanScreen> createState() => _PromotePlanScreenState();
}

class _PromotePlanScreenState extends State<PromotePlanScreen> {
  @override
  void initState() {
    Get.put(PromotePlanRepo());
    final controller = Get.put(PromotePlanController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Load the prices from shared preferences
      controller.adId = Get.arguments[0];
      controller.myAdsData = Get.arguments[1];
      controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.promotePlan.tr,
      centerTitle: true,
      body: GetBuilder<PromotePlanController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MyStrings.chooseYourPromotionPlan.tr,
                style: regularLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
              ),
              spaceDown(Dimensions.space10),
              Row(
                children: [
                  Expanded(
                    child: PriceSelectionButton(
                      prefixIcon: MyAssetImageWidget(
                        assetPath: MyImages.vip,
                        isSvg: true,
                        height: Dimensions.space16.h,
                        width: Dimensions.space16.h,
                      ),
                      gradient: LinearGradient(
                        colors: MyColor.vipCard,
                        end: Alignment.topCenter,
                        begin: Alignment.bottomCenter,
                      ),
                      // FIXED: callForPrice false means VIP is selected
                      isActive: controller.callForPrice == false,
                      text: MyStrings.vip,
                      onTap: () {
                        // If not already VIP, toggle to VIP
                        if (controller.callForPrice == true) {
                          controller.changeAdvanceSearchStatus();
                        }
                      },
                    ),
                  ),
                  spaceSide(Dimensions.space16),
                  Expanded(
                    child: PriceSelectionButton(
                      // FIXED: callForPrice true means Featured is selected
                      isActive: controller.callForPrice == true,
                      text: MyStrings.price,
                      onTap: () {
                        // If not already Featured, toggle to Featured
                        if (controller.callForPrice == false) {
                          controller.changeAdvanceSearchStatus();
                        }
                      },
                    ),
                  ),
                ],
              ),
              spaceDown(Dimensions.space16),
              Text(
                MyStrings.selectDate.tr,
                style: regularLarge.copyWith(color: MyColor.headingTextColor, fontWeight: FontWeight.w600, fontFamily: 'poppins'),
              ),
              spaceDown(Dimensions.space12),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  filterButtons(MyStrings.from, MyStrings.dateTimeHint, context, isFromDate: true, controller: controller),
                  spaceSide(Dimensions.space12),
                  filterButtons(
                    MyStrings.to,
                    MyStrings.dateTimeHint,
                    context,
                    isFromDate: false,
                    controller: controller,
                  )
                ],
              ),
              CustomDivider(),
              CustomAppCard(
                boxShadow: [],
                showBorder: false,
                showShadow: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      MyStrings.planSummery.tr,
                      style: regularLarge.copyWith(fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                    ),
                    spaceDown(Dimensions.space16),
                    // Show the correct plan type
                    planSummuryTile(
                      title: MyStrings.promotionalPlan,
                      value: controller.getPlanTypeName(),
                    ),
                    spaceDown(Dimensions.space12),
                    // Show actual total days
                    planSummuryTile(
                      title: MyStrings.promotionDuration,
                      value: "${controller.getTotalDays()} ${controller.getTotalDays() == 1 ? 'Day' : 'Days'}",
                      valueColor: MyColor.headingTextColor,
                    ),

                    spaceDown(Dimensions.space12),
                    // Show total amount
                    planSummuryTile(
                      title: MyStrings.amount,
                      value: "${controller.defaultCurrency}${controller.getFormattedTotalPrice()}",
                      valueColor: MyColor.lightSuccess,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNav: GetBuilder<PromotePlanController>(
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
              CardButton(
                icon: "",
                isLoading: controller.boostLoading,
                press: () {
                  // Validate dates are selected
                  if (controller.pickedFromDate == null || controller.pickedToDate == null) {
                    Get.snackbar(
                      'Error',
                      'Please select both From and To dates',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: MyColor.lightError,
                      colorText: MyColor.white,
                    );
                    return;
                  }
                  controller.boostAdData();
                },
                borderColor: MyColor.blackColorShadow,
                text: MyStrings.continue_,
              ),
              spaceDown(Dimensions.space25)
            ],
          ),
        ),
      ),
    );
  }

  Widget filterButtons(String text, String hintText, BuildContext context, {required bool isFromDate, required PromotePlanController controller}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text.tr,
            style: regularLarge.copyWith(color: MyColor.hintTextColor),
          ),
          spaceDown(Dimensions.space8),
          GestureDetector(
            onTap: () async {
              if (isFromDate) {
                controller.pickFromDate(context);
              } else {
                controller.pickToDate(context);
              }
            },
            child: CustomAppCard(
              boxShadow: [
                BoxShadow(
                  color: MyColor.black.withValues(alpha: .26),
                  blurRadius: 3,
                  offset: const Offset(0, 1.5),
                ),
              ],
              showBorder: false,
              padding: EdgeInsetsDirectional.all(Dimensions.space12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isFromDate ? (controller.pickedFromDate != null ? DateFormat('dd/MM/yyyy').format(controller.pickedFromDate!) : hintText.tr) : (controller.pickedToDate != null ? DateFormat('dd/MM/yyyy').format(controller.pickedToDate!) : hintText.tr),
                    style: regularDefault.copyWith(
                      color: (isFromDate ? controller.pickedFromDate != null : controller.pickedToDate != null) ? MyColor.headingTextColor : MyColor.hintTextColor,
                    ),
                  ),
                  MyAssetImageWidget(
                    assetPath: MyImages.calender,
                    isSvg: true,
                    color: MyColor.headingTextColor,
                    height: Dimensions.space24.h,
                    width: Dimensions.space24.h,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget planSummuryTile({
    String title = "",
    String value = "",
    String? image,
    String? planName,
    Color? valueColor,
    bool isPlan = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.tr,
          style: regularLarge.copyWith(fontFamily: 'poppins', color: MyColor.hintTextColor),
        ),
        isPlan
            ? Row(
                children: [
                  if (planName != null) ...[
                    Text(
                      planName,
                      style: regularLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'poppins',
                        color: MyColor.headingTextColor,
                      ),
                    ),
                    spaceSide(Dimensions.space8),
                  ],
                  MyAssetImageWidget(
                    assetPath: image ?? "",
                    height: Dimensions.space22,
                    width: Dimensions.space55,
                  ),
                ],
              )
            : Flexible(
                child: Text(
                  value,
                  style: regularLarge.copyWith(fontWeight: FontWeight.w600, fontFamily: 'poppins', color: valueColor),
                ),
              ),
      ],
    );
  }
}
