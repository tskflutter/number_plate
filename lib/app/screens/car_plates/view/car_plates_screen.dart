import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/buttons/action_button.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/number_plate_card_box.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/slider/custom_slider.dart';
import 'package:ovolutter/app/components/text-field/custom_drop_down.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/screens/car_plates/controller/car_plates_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/repo/car_plates/car_plates_repo.dart';

class CarPlatesScreen extends StatefulWidget {
  const CarPlatesScreen({super.key});

  @override
  State<CarPlatesScreen> createState() => _CarPlatesScreenState();
}

class _CarPlatesScreenState extends State<CarPlatesScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<CarPlatesController>().hasNext()) {
        Get.find<CarPlatesController>().getCarPlatesData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(CarPlatesRepo());
    final controller = Get.put(CarPlatesController(repo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarPlatesController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.carPlates.tr,
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          color: MyColor.black,
          child: NestedScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                            CustomDropdown(
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
                                  filterButtons(
                                    "Contains",
                                    controller.containsTextController,
                                    "123",
                                  ),
                                  spaceSide(Dimensions.space8),
                                  filterButtons(
                                    "Start with",
                                    controller.startWithTextController,
                                    "123",
                                  ),
                                  spaceSide(Dimensions.space8),
                                  filterButtons(
                                    "Ends with",
                                    controller.endWithTextController,
                                    "123",
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
                                      onChanged: () {
                                        controller.updateSliderFromTextFields();
                                      },
                                      showShadow: true,
                                      fillColor: MyColor.white,
                                      hintText: MyStrings.minPrice.tr,
                                      textInputType: TextInputType.number,
                                    ),
                                  ),
                                  spaceSide(Dimensions.space8),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: controller.maxPriceTextController,
                                      onChanged: () {
                                        controller.updateSliderFromTextFields();
                                      },
                                      showShadow: true,
                                      fillColor: MyColor.white,
                                      hintText: MyStrings.maxPrice.tr,
                                      textInputType: TextInputType.number,
                                    ),
                                  ),
                                ],
                              ),
                              spaceDown(Dimensions.space12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    MyStrings.priceRange,
                                    style: regularDefault.copyWith(
                                      color: MyColor.headingTextColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  spaceDown(Dimensions.space8),
                                  CustomRangeSlider(
                                    minValue: controller.minPriceLimit,
                                    maxValue: controller.maxPriceLimit,
                                    currentValues: controller.currentRangeValues,
                                    onChanged: (RangeValues values) {
                                      controller.currentRangeValues = values;
                                      controller.updatePriceTextFields();
                                      controller.update();
                                    },
                                    activeColor: MyColor.darkInformation,
                                    inactiveColor: MyColor.plateBgColor,
                                    thumbColor: MyColor.black,
                                    height: Dimensions.space8,
                                    thumbRadius: Dimensions.space10,
                                  ),
                                  spaceDown(Dimensions.space4),
                                ],
                              ),
                            ],
                            spaceDown(Dimensions.space24),
                            CustomElevatedBtn(
                              text: MyStrings.search,
                              onTap: () {
                                controller.loadData();
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
                  if (width < 600) return 2;
                  if (width < 900) return 3;
                  return 4;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    spaceDown(Dimensions.space25),
                    Expanded(
                      child: GridView.builder(
                        itemCount: controller.carPlateData.length + 1,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: constraints.maxWidth / getGridCrossAxisCount(constraints.maxWidth),
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          mainAxisExtent: 180,
                        ),
                        itemBuilder: (context, index) {
                          if (controller.carPlateData.length == index) {
                            return controller.hasNext() ? const Center(child: CustomLoader(isPagination: true)) : const SizedBox();
                          }

                          var carPlatesData = controller.carPlateData[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.plateDetailsScreen, arguments: [carPlatesData.id]);
                            },
                            child: NumberPlateCardBox(
                              letter: carPlatesData.plateLetter,
                              number: carPlatesData.plateNumber,
                              phNumber: "+${carPlatesData.dialCode}${carPlatesData.phoneNumber}",
                              cityId: carPlatesData.cityId,
                              priceType: carPlatesData.priceType,
                              duration: DateConverter().formatRelativeDateFromJson(carPlatesData.createdAt ?? ""),
                              price: "${controller.defaultCurrency}${AppConverter.formatNumber(carPlatesData.price ?? "", precision: 2)}",
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget filterButtons(String text, TextEditingController textController, String hint) {
    return Expanded(
      child: CustomTextField(
        isPhone: false,
        controller: textController,
        onChanged: () {},
        showShadow: true,
        fillColor: MyColor.white,
        hintText: text.tr,
        validator: (value) {
          if (value!.isEmpty) {
            return MyStrings.fieldErrorMsg.tr;
          } else {
            return null;
          }
        },
      ),
    );
  }
}
