import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/number_plate_card_box.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/home/controller/home_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/repo/home/home_repo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  final List<String> tabs = [
    MyStrings.vipPlates.tr,
    MyStrings.featurePlates.tr,
    MyStrings.latestPlates.tr,
  ];

  void _scrollListener() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final controller = Get.find<HomeScreenController>();
      String currentTab = _tabController.index == 0
          ? ''
          : _tabController.index == 1
              ? '1'
              : '2';

      if (controller.hasNext(currentTab)) {
        controller.getHomeplateData(currentTab, loadMore: true);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    Get.put(HomeRepo());
    final controller = Get.put(HomeScreenController(repo: Get.find()));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData("");
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GetBuilder<HomeScreenController>(
        builder: (controller) => MyCustomScaffold(
          screenBgColor: MyColor.transparent,
          showAppBar: false,
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      spaceDown(Dimensions.space20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.homeLogo,
                            isSvg: true,
                            height: Dimensions.space24,
                            boxFit: BoxFit.contain,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CustomAppCard(
                                  onPressed: () {
                                    if (controller.token != "") {
                                      Get.toNamed(RouteHelper.notificationScreen);
                                    } else {
                                      CustomSnackBar.error(errorList: [MyStrings.toViewKindlyLoginFirst.tr]);
                                    }
                                  },
                                  backgroundColor: MyColor.plateBgColor,
                                  showBorder: false,
                                  padding: EdgeInsets.all(Dimensions.space10),
                                  radius: Dimensions.space100,
                                  child: MyAssetImageWidget(
                                    assetPath: MyImages.notificationBell,
                                    isSvg: true,
                                    height: Dimensions.space24.h,
                                    width: Dimensions.space24.h,
                                  )),
                              controller.unreadNotifications != "0"
                                  ? Positioned(
                                      top: -4,
                                      left: -4,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                          color: MyColor.lightError,
                                          shape: BoxShape.circle,
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 20,
                                          minHeight: 20,
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller.unreadNotifications,
                                            textAlign: TextAlign.center,
                                            style: regularSmall.copyWith(color: MyColor.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          )
                        ],
                      ),
                      spaceDown(Dimensions.space25),
                      CustomAppCard(
                          backgroundColor: MyColor.transparent,
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
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.carPlatesScreen);
                                },
                                child: MyNetworkImageWidget(
                                  imageUrl: "${UrlContainer.domainUrl}/${controller.otherImagePath}/${controller.otherScreens}",
                                  width: double.infinity,
                                  height: Dimensions.space170,
                                  boxFit: BoxFit.cover,
                                  radius: Dimensions.cardRadius - 1,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteHelper.carPlatesScreen);
                                },
                                child: MyAssetImageWidget(
                                  assetPath: MyImages.carPlateShadow,
                                  width: double.infinity,
                                  isSvg: true,
                                  height: Dimensions.space170,
                                  boxFit: BoxFit.cover,
                                  radius: Dimensions.cardRadius - 1,
                                ),
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
                              controller.totalCarPlate != ""
                                  ? Positioned(
                                      top: -10,
                                      right: 10,
                                      child: CustomAppCard(
                                          backgroundColor: MyColor.lightPrimary,
                                          showBorder: false,
                                          padding: EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space4),
                                          child: Text(
                                            controller.totalCarPlate,
                                            style: regularSmall.copyWith(color: MyColor.white),
                                          )))
                                  : SizedBox()
                            ],
                          )),
                      spaceDown(Dimensions.space24),
                      Row(
                        children: [
                          _box(
                            title: MyStrings.request,
                            count: controller.requestedAds,
                            image: MyImages.search,
                            hasCount: controller.requestedAds != "" ? true : false,
                            ontap: () {
                              Get.toNamed(RouteHelper.requestPlatesScreen);
                            },
                          ),
                          spaceSide(Dimensions.space16),
                          _box(
                            title: MyStrings.quickSales,
                            hasCount: false,
                            image: MyImages.quickSale,
                            ontap: () {
                              Get.toNamed(RouteHelper.quickSalesScreen);
                            },
                          ),
                        ],
                      ),
                      spaceDown(Dimensions.space32),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * .22),
                        child: ListView.separated(
                            separatorBuilder: (context, index) => spaceSide(Dimensions.space16),
                            itemCount: controller.offers.length,
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return horizontalBoxes(routePage: controller.offers[index].screen, image: "${UrlContainer.domainUrl}/${controller.offerImagePath}/${controller.offers[index].image}");
                            }),
                      ),
                      spaceDown(Dimensions.space24),
                      Row(
                        children: [
                          MyAssetImageWidget(
                            assetPath: MyImages.fire,
                            isSvg: true,
                            height: Dimensions.space24.h,
                            width: Dimensions.space24.h,
                          ),
                          Text(
                            MyStrings.trendingAds,
                            style: boldOverLarge.copyWith(fontSize: Dimensions.space22, fontWeight: FontWeight.w500, fontFamily: 'poppins'),
                          )
                        ],
                      ),
                      spaceDown(Dimensions.space5),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarDelegate(
                    TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      labelColor: MyColor.getPrimaryColor(),
                      tabAlignment: TabAlignment.center,
                      unselectedLabelColor: MyColor.hintTextColor,
                      indicatorColor: MyColor.getPrimaryColor(),
                      dividerColor: MyColor.dividerColor.withValues(alpha: .2),
                      indicatorWeight: 2,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: tabs.map((e) => Tab(text: e)).toList(),
                      onTap: (value) {
                        String tabName = value == 0
                            ? '' // Trending (empty means trending)
                            : value == 1
                                ? '1' // VIP (BOOSTING_TYPE_VIP = 1)
                                : "2"; // Featured (BOOSTING_TYPE_FEATURED = 2)

                        // Always load data when tab is tapped
                        controller.loadData(tabName);
                      },
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: tabs.asMap().entries.map((entry) {
                int tabIndex = entry.key;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    int getGridCrossAxisCount(double width) {
                      if (width < 600) return 2;
                      if (width < 900) return 3;
                      return 4;
                    }

                    String currentTab = tabIndex == 0
                        ? ''
                        : tabIndex == 1
                            ? '1'
                            : '2';

                    // Check if this tab's data is loaded
                    bool isCurrentTab = _tabController.index == tabIndex;
                    bool hasData = controller.adsData.isNotEmpty && controller.currentTab == currentTab;

                    // Show loading only if it's the current tab and has no data
                    if (isCurrentTab && !hasData && controller.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    // Show empty state if no data
                    if (isCurrentTab && !hasData && !controller.isLoading) {
                      return Center(
                        child: Text(
                          'No plates found',
                          style: regularDefault.copyWith(color: MyColor.getBodyTextColor()),
                        ),
                      );
                    }

                    return GridView.builder(
                      itemCount: controller.adsData.length + (controller.hasNext(currentTab) ? 1 : 0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: Dimensions.space16),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: (constraints.maxWidth / getGridCrossAxisCount(constraints.maxWidth)),
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                        mainAxisExtent: 180,
                      ),
                      itemBuilder: (context, index) {
                        if (index == controller.adsData.length) {
                          // Pagination loader
                          return GridView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: getGridCrossAxisCount(constraints.maxWidth),
                              mainAxisExtent: 180,
                            ),
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                child: const CustomLoader(isPagination: true),
                              ),
                            ],
                          );
                        }

                        return GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.plateDetailsScreen, arguments: [controller.adsData[index].id]);
                            },
                            child: NumberPlateCardBox(
                              letter: controller.adsData[index].plateLetter,
                              number: controller.adsData[index].plateNumber,
                              phNumber: "+${controller.adsData[index].dialCode}${controller.adsData[index].phoneNumber}",
                              cityId: controller.adsData[index].cityId,
                              priceType: controller.adsData[index].priceType,
                              duration: DateConverter().formatRelativeDateFromJson(controller.adsData[index].createdAt ?? ""),
                              price: "${controller.defaultCurrency}${AppConverter.formatNumber(controller.adsData[index].price ?? "", precision: 2)}",
                            ));
                      },
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _box({String? title, String? image, String? count, bool hasCount = false, VoidCallback? ontap}) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CustomAppCard(
              onPressed: ontap,
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
                      assetPath: image ?? "",
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
                      title ?? "",
                      style: boldLarge.copyWith(color: MyColor.headingTextColor),
                    ),
                  ),
                ],
              )),
          hasCount == true
              ? Positioned(
                  top: -10,
                  right: 10,
                  child: CustomAppCard(
                      backgroundColor: MyColor.lightPrimary,
                      showBorder: false,
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.space12, vertical: Dimensions.space4),
                      child: Text(
                        count ?? "",
                        style: regularSmall.copyWith(color: MyColor.white),
                      )))
              : SizedBox.shrink()
        ],
      ),
    );
  }

  Widget horizontalBoxes({
    String? title,
    String? image,
    String? routePage,
    HomeScreenController? homeController,
    bool isVip = false,
  }) {
    return CustomAppCard(
      onPressed: () {
        if (homeController?.token != "") {
          if (routePage == "request_plate") {
            Get.toNamed(RouteHelper.requestPlatesScreen);
          } else if (routePage == "quick_sale") {
            Get.toNamed(RouteHelper.quickSalesScreen);
          } else if (routePage == "car_plate") {
            Get.toNamed(RouteHelper.carPlatesScreen);
          } else if (routePage == "vip_plate") {
            _tabController.index == 1;
            homeController?.update();
          } else if (routePage == "feature_plate") {
            _tabController.index == 2;
            homeController?.update();
          }
        } else {
          CustomSnackBar.error(errorList: [MyStrings.toViewKindlyLoginFirst.tr]);
        }
      },
      padding: EdgeInsets.zero,
      radius: Dimensions.cardRadius,
      child: AspectRatio(aspectRatio: 16 / 9, child: MyNetworkImageWidget(imageUrl: image ?? "")),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: MyColor.transparent,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_TabBarDelegate oldDelegate) => false;
}
