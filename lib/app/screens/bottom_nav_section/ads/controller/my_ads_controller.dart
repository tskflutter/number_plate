import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/util.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/model/quick_sales/quick_sales_response_model.dart';
import 'package:ovolutter/data/repo/my_ads/my_ads_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class MyAdsController extends GetxController {
  MyAdsRepo repo;

  MyAdsController({required this.repo});

  bool isAdvanceSearch = false;
  bool isLoading = false; // Initial load
  bool isLoadMore = false; // Pagination loader

  int page = 0;
  String? nextPageUrl;
  bool adsDetailsLoading = false;
  String defaultCurrency = "";
  String id = "";

  // Text controllers for filters
  TextEditingController containsTextController = TextEditingController();
  TextEditingController startWithTextController = TextEditingController();
  TextEditingController endWithTextController = TextEditingController();
  TextEditingController minPriceTextController = TextEditingController();
  TextEditingController maxPriceTextController = TextEditingController();

  List<AdsData> adsData = [];
  List<City> cityData = [];

  String? selectedCity;
  String? selectedCityId;
  String? selectedStatus;
  String? selectedFormat;
  String? selectedDigit;

  AdsData? myAdsData;
  SimilarAd? similarAd;

  final List<String> digitCount = [
    '1 Digit',
    '2 Digit',
    '3 Digit',
    '4 Digit',
    '5 Digit',
  ];

  final List<String> formatCount = [
    'Digit Repeated 2x',
    'Digit Repeated 3x',
    'Digit Repeated 4x',
    'X???X (5 Digit)',
    'XYZYX (5 Digit)',
    'XXZXX (5 Digit)',
    '?XXX? (5 Digit)',
  ];

  final List<String> statusOptions = [
    'All',
    'Active',
    'Pending',
    'Rejected',
    'Sold',
  ];

  @override
  void onInit() {
    super.onInit();
    // Load cities from general settings
    final gsModel = SharedPreferenceService.getGeneralSettingData();
    cityData = gsModel.data?.cities ?? [];
  }

  void changeAdvanceSearchStatus() {
    isAdvanceSearch = !isAdvanceSearch;
    update();
  }

  // Extract digit count number from string
  String getDigitCountValue() {
    if (selectedDigit == null || selectedDigit!.isEmpty) return "";
    return selectedDigit!.split(' ').first;
  }

  String getStatusValue() {
    if (selectedStatus == null || selectedStatus == 'All') return "";
    return selectedStatus!.toLowerCase();
  }

  // Reset all filters
  void resetFilters() {
    selectedCity = null;
    selectedCityId = null;
    selectedStatus = null;
    selectedFormat = null;
    selectedDigit = null;
    containsTextController.clear();
    startWithTextController.clear();
    endWithTextController.clear();
    minPriceTextController.clear();
    maxPriceTextController.clear();
    update();
    getMyAdsData();
  }

  Future<void> loadData() async {
    page = 0;
    adsData.clear();
    isLoading = true;
    update();
    await getMyAdsData();
    isLoading = false;
    update();
  }

  Future<void> getMyAdsData({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasNext() || isLoadMore) return;
      isLoadMore = true;
    } else {
      page = 0;
      adsData.clear();
      isLoading = true;
    }

    update();

    page++;

    try {
      ResponseModel responseModel = await repo.getMyAdsRepo(
        digitCount: getDigitCountValue(),
        cityId: selectedCityId ?? "",
        status: getStatusValue(),
        contains: containsTextController.text.trim(),
        startWith: startWithTextController.text.trim(),
        endWith: endWithTextController.text.trim(),
        minPrice: minPriceTextController.text.trim(),
        maxPrice: maxPriceTextController.text.trim(),
      );

      if (responseModel.statusCode == 200) {
        MyAdsResponseModel model = myAdsResponseModelFromJson(jsonEncode(responseModel.responseJson));
        if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();
          nextPageUrl = model.data?.adLists?.nextPageUrl;
          final tempList = model.data?.adLists?.data;
          if (tempList != null && tempList.isNotEmpty) {
            adsData.addAll(tempList);
          }
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print("Error fetching ads: $e");
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      isLoading = false;
      isLoadMore = false;
      update();
    }
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty;
  }

  void plateDetailsData() async {
    adsDetailsLoading = true;
    update();

    try {
      ResponseModel responseModel = await repo.plateDetailsRepo(id);

      if (responseModel.statusCode == 200) {
        AdsDetailsResponseModel model = adsDetailsResponseModelFromJson(
          jsonEncode(responseModel.responseJson),
        );

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          myAdsData = model.data?.ad ?? AdsData();
          similarAd = model.data?.similarAd;
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();
          watchListData();
          update();
        } else {
          CustomSnackBar.error(
            errorList: model.message ?? [MyStrings.requestFail],
          );
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print('Error fetching plate details: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      adsDetailsLoading = false;
      update();
    }
  }

  bool deletingPlate = false;
  void deletePlate(String plateId) async {
    deletingPlate = true;
    update();

    try {
      ResponseModel responseModel = await repo.plateDeleteRepo(plateId);

      if (responseModel.statusCode == 200) {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      printX('Error fetching plate delete: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      deletingPlate = false;
      update();
    }
  }

  bool soldPlate = false;
  void soldPlateData() async {
    soldPlate = true;
    update();

    try {
      ResponseModel responseModel = await repo.plateDeleteRepo(id);

      if (responseModel.statusCode == 200) {
        Get.offAndToNamed(RouteHelper.bottomNavBar);
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      printX('Error fetching plate delete: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      soldPlate = false;
      update();
    }
  }

  void watchListData() async {
    try {
      ResponseModel responseModel = await repo.plateWatchRepo(id);

      if (responseModel.statusCode == 200) {
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      printX('Error fetching plate delete: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    }
  }

  @override
  void dispose() {
    containsTextController.dispose();
    startWithTextController.dispose();
    endWithTextController.dispose();
    minPriceTextController.dispose();
    maxPriceTextController.dispose();
    super.dispose();
  }
}
