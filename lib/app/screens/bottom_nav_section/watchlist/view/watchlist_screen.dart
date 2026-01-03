import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/card/number_plate_card_box.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/not_logged_in.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/watchlist/controller/watchlist_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/app_style.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/repo/watchlist/watchlist_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
      Get.find<WatchlistScreenController>().getWatchlistData(loadMore: true);
    }
  }

  @override
  void initState() {
    Get.put(WatchlistRepo());
    final controller = Get.put(WatchlistScreenController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      String token = SharedPreferenceService.getAccessToken();

      if (token != "") {
        controller.loadData();
      }
      scrollController.addListener(scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchlistScreenController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.myWatchList,
        centerTitle: true,
        showBackButton: false,
        body: controller.isLoading
            ? CustomLoader()
            : controller.watchlistData.isEmpty
                ? NotLoggedinWidget(
                    text: MyStrings.logIntoSeeWatchlist.tr,
                  )
                : LayoutBuilder(
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
                          controller.isLoading
                              ? CustomLoader()
                              : Expanded(
                                  child: GridView.builder(
                                    controller: scrollController,
                                    itemCount: controller.watchlistData.length + (controller.hasNext() ? 1 : 0),
                                    padding: EdgeInsets.zero,
                                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: constraints.maxWidth / getGridCrossAxisCount(constraints.maxWidth),
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      mainAxisExtent: 180,
                                    ),
                                    itemBuilder: (context, index) {
                                      // Last item: show loader if next page exists
                                      if (index == controller.watchlistData.length) {
                                        return const CustomLoader(isPagination: true);
                                      }

                                      final watchlistData = controller.watchlistData[index];

                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            RouteHelper.plateDetailsScreen,
                                            arguments: [watchlistData.ad?.id],
                                          );
                                        },
                                        child: NumberPlateCardBox(
                                          letter: watchlistData.ad?.plateLetter,
                                          number: watchlistData.ad?.plateNumber,
                                          phNumber: "+${watchlistData.ad?.dialCode}${watchlistData.ad?.phoneNumber}",
                                          cityId: watchlistData.ad?.cityId,
                                          priceType: watchlistData.ad?.priceType,
                                          duration: DateConverter().formatRelativeDateFromJson(watchlistData.createdAt ?? ""),
                                          price: "${controller.defaultCurrency}${AppConverter.formatNumber(
                                            watchlistData.ad?.price ?? "",
                                            precision: 2,
                                          )}",
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
    );
  }
}
