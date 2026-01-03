import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/glass_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/slider/custom_slider.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class ComponentScreen extends StatefulWidget {
  const ComponentScreen({super.key});

  @override
  State<ComponentScreen> createState() => _ComponentScreenState();
}

class _ComponentScreenState extends State<ComponentScreen> {
  String? selectedCity;

  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
  ];

  RangeValues _currentRangeValues = const RangeValues(20, 80);
  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      padding: EdgeInsets.zero,
      pageTitle: 'Components',
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // CustomTextField(
          //   onChanged: () {},
          //   labelText: "Email or Phone Number",
          //   hintText: 'eg. email@gmail.com',
          // ),
          // CustomTextField(
          //   onChanged: () {},
          //   labelText: "Password",
          //   hintText: '>>>>>>>>',
          //   isPassword: true,
          //   isShowSuffixIcon: true,
          // ),
          // CustomElevatedBtn(text: "caaaa", onTap: () {}),
          // spaceDown(Dimensions.space30),
          // OTPFieldWidget(
          //   onChanged: (value) {},
          // ),
          CustomAppCard(
              padding: EdgeInsets.zero,
              radius: Dimensions.cardRadius,
              showShadow: true,
              boxShadow: [
                BoxShadow(
                  color: MyColor.black.withValues(alpha: .25),
                  blurRadius: 6,
                  offset: Offset(0, 8),
                ),
              ],
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  MyAssetImageWidget(
                    assetPath: MyImages.carPlate,
                    width: double.infinity,
                    height: Dimensions.space170,
                    boxFit: BoxFit.cover,
                    radius: Dimensions.cardRadius - 1,
                  ),
                  Positioned(
                    bottom: Dimensions.space16,
                    left: Dimensions.zero,
                    right: Dimensions.zero,
                    child: Text(
                      MyStrings.carPlates.tr,
                      textAlign: TextAlign.center,
                      style: semiBoldLarge.copyWith(color: MyColor.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Positioned(
                      top: -10,
                      right: 10,
                      child: CustomAppCard(
                          backgroundColor: MyColor.lightPrimary,
                          showBorder: false,
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space4),
                          child: Text(
                            "45211",
                            style: regularSmall.copyWith(color: MyColor.white),
                          )))
                ],
              )),
          // spaceDown(Dimensions.space100),
          Row(
            children: [
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomAppCard(
                        height: 120,
                        width: double.infinity,
                        useGradient: true,
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.black.withValues(alpha: .25),
                            blurRadius: 4,
                            offset: Offset(0.5, 5),
                          ),
                        ],
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            spaceDown(Dimensions.space16),
                            Expanded(
                              child: MyAssetImageWidget(
                                assetPath: MyImages.search,
                                height: Dimensions.space56,
                                width: Dimensions.space56,
                              ),
                            ),
                            spaceDown(Dimensions.space5),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space16),
                              decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.cardRadius - 2), bottomRight: Radius.circular(Dimensions.cardRadius - 1))),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Quick Sale",
                                style: boldLarge.copyWith(color: MyColor.headingTextColor),
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        top: -10,
                        right: 10,
                        child: CustomAppCard(
                            backgroundColor: MyColor.lightPrimary,
                            showBorder: false,
                            padding: EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space4),
                            child: Text(
                              "45211",
                              style: regularSmall.copyWith(color: MyColor.white),
                            )))
                  ],
                ),
              ),
              spaceSide(Dimensions.space16),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomAppCard(
                        boxShadow: [
                          BoxShadow(
                            color: MyColor.black.withValues(alpha: .25),
                            blurRadius: 4,
                            offset: Offset(0.5, 5),
                          ),
                        ],
                        height: 120,
                        showShadow: true,
                        width: double.infinity,
                        useGradient: true,
                        padding: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            spaceDown(Dimensions.space16),
                            Expanded(
                              child: MyAssetImageWidget(
                                assetPath: MyImages.quickSale,
                                height: Dimensions.space56,
                                width: Dimensions.space56,
                              ),
                            ),
                            spaceDown(Dimensions.space5),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space16),
                              decoration: BoxDecoration(color: MyColor.white, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.cardRadius - 2), bottomRight: Radius.circular(Dimensions.cardRadius - 1))),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Quick Sale",
                                style: boldLarge.copyWith(color: MyColor.headingTextColor),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.separated(
                separatorBuilder: (context, index) => spaceSide(Dimensions.space16),
                padding: EdgeInsetsDirectional.only(start: Dimensions.space16),
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CustomAppCard(
                    padding: EdgeInsets.zero,
                    radius: Dimensions.cardRadius,
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.demoCar,
                            boxFit: BoxFit.cover,
                            radius: Dimensions.cardRadius,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: Dimensions.space10,
                              horizontal: Dimensions.space12,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Get VIP Numbers",
                                          overflow: TextOverflow.ellipsis,
                                          style: regularDefault.copyWith(
                                            fontFamily: 'FE-FONT',
                                            color: MyColor.white,
                                          ),
                                        ),
                                        spaceDown(Dimensions.space8),
                                        MyAssetImageWidget(
                                          assetPath: MyImages.vipCard,
                                          height: Dimensions.space24,
                                          width: Dimensions.space56,
                                        ),
                                      ],
                                    ),
                                    Flexible(
                                      child: Text(
                                        "Discover Rare Plate Numbers".toUpperCase(),
                                        textAlign: TextAlign.end,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: regularDefault.copyWith(
                                          fontFamily: 'Inter-Regular',
                                          height: 1.05,
                                          color: MyColor.white,
                                          fontSize: Dimensions.space32,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                spaceDown(Dimensions.space20),
                                Align(
                                  alignment: AlignmentGeometry.bottomRight,
                                  child: CustomGlassContainer(
                                    padding: EdgeInsetsDirectional.all(Dimensions.space8.w),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          MyStrings.viewVipNumbers.tr,
                                          style: semiBoldDefault.copyWith(fontFamily: 'Inter-Regular', fontWeight: FontWeight.w600, color: MyColor.white),
                                        ),
                                        spaceSide(Dimensions.space8),
                                        MyAssetImageWidget(
                                          assetPath: MyImages.arrowForwardRight,
                                          isSvg: true,
                                          height: Dimensions.space16.w,
                                          width: Dimensions.space16.w,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                int getGridCrossAxisCount(double width) {
                  if (width < 600) return 2; // Mobile
                  if (width < 900) return 3; // Tablet
                  return 4;
                }

                return GridView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: constraints.maxWidth / getGridCrossAxisCount(constraints.maxWidth),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 180,
                  ),
                  itemBuilder: (context, index) {
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
                                child: MyAssetImageWidget(
                                  assetPath: MyImages.demoCarPlate,
                                  height: Dimensions.space100.h,
                                  width: double.infinity,
                                  boxFit: BoxFit.fitWidth,
                                ),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "9 days ago",
                                      style: regularDefault.copyWith(
                                        fontFamily: 'Inter-regular',
                                        color: MyColor.hintTextColor,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "500.0000",
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
                  },
                );
              },
            ),
          ),
          spaceDown(Dimensions.space100),

          CustomAppCard(
            margin: EdgeInsets.all(10),
            radius: Dimensions.space12,
            borderColor: MyColor.plateBgColor,
            boxShadow: [
              BoxShadow(
                color: MyColor.black.withValues(alpha: .20),
                blurRadius: 5,
                offset: Offset(0, .8),
              ),
            ],
            showShadow: true,
            width: double.infinity,
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.space4),
                  child: CustomGlassContainer(
                    borderRadius: Dimensions.space8,
                    margin: EdgeInsets.all(Dimensions.space4),
                    height: Dimensions.space170,
                    width: double.infinity,
                    hasColor: true,
                    child: Padding(
                      padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space40, horizontal: Dimensions.space40),
                      child: MyAssetImageWidget(
                        assetPath: MyImages.demoCarPlate,
                        width: 260,
                        height: 70,
                        boxFit: BoxFit.contain,
                      ),
                    ),
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
                    child: Column(
                      children: [
                        spaceDown(Dimensions.space16),
                        builddetaisTile(MyStrings.price, "\$500.00", MyImages.price),
                        spaceDown(Dimensions.space12.h),
                        builddetaisTile(MyStrings.vehicleType, "", MyImages.vehicleType, showCard: true),
                        spaceDown(Dimensions.space12.h),
                        builddetaisTile(MyStrings.location, "Sulaymaniyah", MyImages.location),
                        spaceDown(Dimensions.space12.h),
                        builddetaisTile(MyStrings.published, "12 July 2025", MyImages.calender),
                        spaceDown(Dimensions.space20),
                      ],
                    )),
              ],
            ),
          ),
          spaceDown(100),

          // CustomAppCard(
          //   padding: EdgeInsets.symmetric(vertical: 100),
          //   child: CustomDropdown(
          //     hint: 'City',
          //     value: selectedCity,
          //     items: cities,
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         selectedCity = newValue;
          //       });
          //     },
          //   ),
          // ),

          Text(
            'Middle Value: ${(_currentRangeValues)}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 40),
          CustomRangeSlider(
            minValue: 0,
            maxValue: 100,
            currentValues: _currentRangeValues,
            onChanged: (RangeValues values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
            activeColor: MyColor.darkInformation,
            inactiveColor: MyColor.plateBgColor,
            thumbColor: MyColor.black,
            height: Dimensions.space8,
            thumbRadius: Dimensions.space10,
          ),
        ],
      ),
    );
  }
}

builddetaisTile(String title, value, image, {bool? showCard = false}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: Dimensions.space12.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Row(
            children: [
              MyAssetImageWidget(
                assetPath: image,
                isSvg: true,
                height: Dimensions.space16.h,
                width: Dimensions.space16.h,
              ),
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
                child: Text("private",
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
