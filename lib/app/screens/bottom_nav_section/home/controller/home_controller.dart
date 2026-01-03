import 'dart:convert';

import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/homescreen/homescren_response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/home/home_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class HomeScreenController extends GetxController {
  HomeRepo repo;

  HomeScreenController({required this.repo});

  bool isAdvanceSearch = false;
  bool isLoading = false;
  bool latestAdsLoading = false;
  bool vipAdsLoading = false;
  bool featuredAdsLoading = false;

  String defaultCurrency = "";
  String otherScreens = "";
  String otherImagePath = "";
  String offerImagePath = "";
  String unreadNotifications = "";
  String totalCarPlate = "";
  String requestedAds = "";
  String id = "";

  // Pagination for each tab
  int latestPage = 0;
  int vipPage = 0;
  int featuredPage = 0;
  String? latestNextPageUrl;
  String? vipNextPageUrl;
  String? featuredNextPageUrl;

  String token = "";

  // Current active tab
  String currentTab = "";

  List<AdsData> adsData = [];
  List<Offer> offers = [];

  // Load initial data for a tab
  void loadData(String tabName) async {
    currentTab = tabName;
    adsData.clear();
    resetPaginationForTab(tabName);
    isLoading = true;
    update();
    token = SharedPreferenceService.getAccessToken();

    await getHomeplateData(tabName);
    isLoading = false;
    update();
  }

  // Reset pagination for specific tab
  void resetPaginationForTab(String tabName) {
    if (tabName == "") {
      latestPage = 0;
      latestNextPageUrl = null;
    } else if (tabName == "1") {
      vipPage = 0;
      vipNextPageUrl = null;
    } else if (tabName == "2") {
      featuredPage = 0;
      featuredNextPageUrl = null;
    }
  }

  // Check if there's a next page for current tab
  bool hasNext(String tabName) {
    if (tabName == "") {
      return latestNextPageUrl != null && latestNextPageUrl!.isNotEmpty;
    } else if (tabName == "1") {
      return vipNextPageUrl != null && vipNextPageUrl!.isNotEmpty;
    } else if (tabName == "2") {
      return featuredNextPageUrl != null && featuredNextPageUrl!.isNotEmpty;
    }
    return false;
  }

  // Get current page for tab
  int getCurrentPage(String tabName) {
    if (tabName == "") return latestPage;
    if (tabName == "1") return vipPage;
    if (tabName == "2") return featuredPage;
    return 0;
  }

  // Increment page for tab
  void incrementPage(String tabName) {
    if (tabName == "") {
      latestPage++;
    } else if (tabName == "1") {
      vipPage++;
    } else if (tabName == "2") {
      featuredPage++;
    }
  }

  // Update next page URL for tab
  void updateNextPageUrl(String tabName, String? url) {
    if (tabName == "") {
      latestNextPageUrl = url;
    } else if (tabName == "1") {
      vipNextPageUrl = url;
    } else if (tabName == "2") {
      featuredNextPageUrl = url;
    }
  }

  Future<void> getHomeplateData(String tabName, {bool loadMore = false}) async {
    // Prevent multiple simultaneous requests
    if (loadMore && isLoading) return;

    // Check if there's more data to load
    if (loadMore && !hasNext(tabName)) return;

    currentTab = tabName;

    // Increment page
    incrementPage(tabName);

    // Clear data only on first page
    if (getCurrentPage(tabName) == 1) {
      adsData.clear();
      update();
    }

    // Set loading flags
    if (tabName == "") {
      vipAdsLoading = true;
    } else if (tabName == "1") {
      featuredAdsLoading = true;
    } else if (tabName == "2") {
      latestAdsLoading = true;
    }

    isLoading = true;
    update();

    try {
      ResponseModel responseModel = await repo.homeRepo(
          tabName == ""
              ? "1"
              : tabName == "1"
                  ? "2"
                  : "",
          getCurrentPage(tabName).toString(),
          token);

      if (responseModel.statusCode == 200) {
        HomescreenResponseModel model = homescreenResponseModelFromJson(jsonEncode(responseModel.responseJson));

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();

          // Update next page URL
          updateNextPageUrl(tabName, model.data?.trendingAds?.nextPageUrl);

          // Get data from current page
          List<AdsData>? tempList = model.data?.trendingAds?.data;

          if (tempList != null && tempList.isNotEmpty) {
            adsData.addAll(tempList);
          }

          // Load offers and other data only on first page
          if (getCurrentPage(tabName) == 1) {
            offers = model.data?.offers ?? [];

            final generalSettingsModel = SharedPreferenceService.getGeneralSettingData();
            otherScreens = generalSettingsModel.data?.generalSetting?.carPlateScreen ?? "";
            otherImagePath = generalSettingsModel.data?.carPlateScreenFilePath ?? "";
            requestedAds = model.data?.requestedAds ?? "";
            totalCarPlate = model.data?.carPlates ?? "";
            unreadNotifications = model.data?.unreadNotifications ?? "";
            offerImagePath = model.data?.offerImagePath ?? "";
          }

          update();
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.requestFail]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print('Error fetching home plate data: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      latestAdsLoading = false;
      vipAdsLoading = false;
      featuredAdsLoading = false;
      isLoading = false;
      update();
    }
  }
}
