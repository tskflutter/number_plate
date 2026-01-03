import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/number_plate_card_box.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/not_logged_in.dart';
import 'package:ovolutter/app/components/text-field/custom_drop_down.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/ads/controller/my_ads_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/repo/my_ads/my_ads_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class MyAdsScreen extends StatefulWidget {
  const MyAdsScreen({super.key});

  @override
  State<MyAdsScreen> createState() => _MyAdsScreenState();
}

class _MyAdsScreenState extends State<MyAdsScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      Get.find<MyAdsController>().getMyAdsData(loadMore: true);
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(MyAdsRepo());
    final controller = Get.put(MyAdsController(repo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      String token = SharedPreferenceService.getAccessToken();

      if (token != "") {
        controller.loadData();
      }
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAdsController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.myAds.tr,
        showBackButton: false,
        centerTitle: true,
        body: controller.isLoading
            ? CustomLoader()
            : controller.adsData.isEmpty
                ? NotLoggedinWidget(
                    text: MyStrings.logIntoSeeAds.tr,
                  )
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              spaceDown(Dimensions.space5),
                              CustomAppCard(
                                showShadow: false,
                                borderColor: MyColor.black.withValues(alpha: .10),
                                padding: EdgeInsetsDirectional.all(Dimensions.space16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          MyStrings.filters.tr,
                                          style: regularLarge.copyWith(
                                            fontFamily: 'poppins',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.resetFilters();
                                          },
                                          child: Text(
                                            MyStrings.reset.tr,
                                            style: regularLarge.copyWith(
                                              fontFamily: 'poppins',
                                              fontWeight: FontWeight.w500,
                                              color: MyColor.darkError,
                                              decoration: TextDecoration.underline,
                                              decorationColor: MyColor.darkError,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    spaceDown(Dimensions.space8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomDropdown(
                                            hint: MyStrings.city,
                                            value: controller.selectedCity,
                                            items: controller.cityData.map((e) => e.name ?? '').toList(),
                                            onChanged: (String? newValue) {
                                              controller.selectedCity = newValue;
                                              final city = controller.cityData.firstWhere(
                                                (c) => c.name == newValue,
                                                orElse: () => City(),
                                              );
                                              controller.selectedCityId = city.id;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                        spaceSide(Dimensions.space8),
                                        Expanded(
                                          child: CustomDropdown(
                                            hint: 'Status',
                                            value: controller.selectedStatus,
                                            items: controller.statusOptions,
                                            onChanged: (String? newValue) {
                                              controller.selectedStatus = newValue;
                                              controller.update();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    spaceDown(Dimensions.space12),
                                    if (controller.isAdvanceSearch) ...[
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomDropdown(
                                              hint: 'Digit Count',
                                              value: controller.selectedDigit,
                                              items: controller.digitCount,
                                              onChanged: (String? newValue) {
                                                controller.selectedDigit = newValue;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                          spaceSide(Dimensions.space8),
                                          Expanded(
                                            child: CustomDropdown(
                                              hint: 'Format',
                                              value: controller.selectedFormat,
                                              items: controller.formatCount,
                                              onChanged: (String? newValue) {
                                                controller.selectedFormat = newValue;
                                                controller.update();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceDown(Dimensions.space12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller: controller.containsTextController,
                                              onChanged: () {},
                                              showShadow: true,
                                              fillColor: MyColor.white,
                                              labelText: "Contains".tr,
                                              hintText: "123",
                                            ),
                                          ),
                                          spaceSide(Dimensions.space8),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: controller.startWithTextController,
                                              onChanged: () {},
                                              showShadow: true,
                                              fillColor: MyColor.white,
                                              labelText: "Start with".tr,
                                              hintText: "123",
                                            ),
                                          ),
                                          spaceSide(Dimensions.space8),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: controller.endWithTextController,
                                              onChanged: () {},
                                              showShadow: true,
                                              fillColor: MyColor.white,
                                              labelText: "Ends with".tr,
                                              hintText: "123",
                                            ),
                                          ),
                                        ],
                                      ),
                                      spaceDown(Dimensions.space12),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller: controller.minPriceTextController,
                                              onChanged: () {},
                                              showShadow: true,
                                              fillColor: MyColor.white,
                                              labelText: "Min price".tr,
                                              hintText: "0",
                                              textInputType: TextInputType.number,
                                            ),
                                          ),
                                          spaceSide(Dimensions.space8),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: controller.maxPriceTextController,
                                              onChanged: () {},
                                              showShadow: true,
                                              fillColor: MyColor.white,
                                              labelText: "Max price".tr,
                                              hintText: "10000",
                                              textInputType: TextInputType.number,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                    spaceDown(Dimensions.space24),
                                    CustomElevatedBtn(
                                      text: MyStrings.search,
                                      onTap: () {
                                        controller.getMyAdsData();
                                      },
                                    ),
                                    spaceDown(Dimensions.space14),
                                    GestureDetector(
                                      onTap: () {
                                        controller.changeAdvanceSearchStatus();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            controller.isAdvanceSearch ? MyStrings.hideSearchOption.tr : MyStrings.advanceSearchOptions.tr,
                                            style: regularDefault.copyWith(
                                              color: MyColor.headingTextColor,
                                            ),
                                          ),
                                          spaceSide(Dimensions.space8),
                                          MyAssetImageWidget(
                                            assetPath: MyImages.down,
                                            isSvg: true,
                                            height: Dimensions.space12.h,
                                            width: Dimensions.space12.h,
                                            boxFit: BoxFit.contain,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ];
                    },
                    body: LayoutBuilder(
                      builder: (context, constraints) {
                        int getGridCrossAxisCount(double width) {
                          if (width < 600) return 2; // Mobile
                          if (width < 900) return 3; // Tablet
                          return 4;
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            spaceDown(Dimensions.space25),
                            Expanded(
                              child: controller.isLoading && controller.adsData.isEmpty
                                  ? const Center(child: CircularProgressIndicator())
                                  : controller.adsData.isEmpty
                                      ? Center(
                                          child: Text(
                                            'No ads found',
                                            style: regularDefault.copyWith(color: MyColor.getBodyTextColor()),
                                          ),
                                        )
                                      : GridView.builder(
                                          controller: scrollController,
                                          itemCount: controller.adsData.length + (controller.hasNext() ? 1 : 0),
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: constraints.maxWidth / getGridCrossAxisCount(constraints.maxWidth),
                                            crossAxisSpacing: 15,
                                            mainAxisSpacing: 15,
                                            mainAxisExtent: 180,
                                          ),
                                          itemBuilder: (context, index) {
                                            // Last item loader for pagination
                                            if (index == controller.adsData.length) {
                                              return const CustomLoader(isPagination: true);
                                            }

                                            final ad = controller.adsData[index];
                                            return GestureDetector(
                                              onTap: () {
                                                Get.toNamed(
                                                  RouteHelper.myAdsPlateDetailsScreen,
                                                  arguments: [ad.id.toString()],
                                                );
                                              },
                                              child: NumberPlateCardBox(
                                                letter: ad.plateLetter,
                                                number: ad.plateNumber,
                                                phNumber: "+${ad.dialCode}${ad.phoneNumber}",
                                                cityId: ad.cityId,
                                                priceType: ad.priceType,
                                                duration: DateConverter().formatRelativeDateFromJson(ad.createdAt ?? ""),
                                                price: "${controller.defaultCurrency}${AppConverter.formatNumber(ad.price ?? "", precision: 2)}",
                                              ),
                                            );
                                          },
                                        ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
      ),
    );
  }
}
