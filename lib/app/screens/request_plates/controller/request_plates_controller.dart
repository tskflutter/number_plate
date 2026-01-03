import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/model/my_request_ads/my_request_ads_response_model.dart';
import 'package:ovolutter/data/repo/request_plates/request_plates_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class RequestPlatesController extends GetxController {
  RequestPlatesRepo repo;

  RequestPlatesController({required this.repo});

  bool isAdvanceSearch = false;
  bool isLoading = false;
  bool isLoadMore = false;

  int page = 0;
  String? nextPageUrl;

  String defaultCurrency = "";

  // Text controllers for filters
  TextEditingController containsTextController = TextEditingController();
  TextEditingController startWithTextController = TextEditingController();
  TextEditingController endWithTextController = TextEditingController();
  TextEditingController minPriceTextController = TextEditingController();
  TextEditingController maxPriceTextController = TextEditingController();

  MyRequestedAdList myRequestedAdList = MyRequestedAdList();
  List<City> cityData = [];

  String? selectedCity;
  String? selectedCityId;
  String? selectedStatus;
  String? selectedFormat;
  String? selectedDigit;

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
    'Pending',
    'Approved',
    'Rejected',
  ];

  @override
  void onInit() {
    super.onInit();
    final gsModel = SharedPreferenceService.getGeneralSettingData();
    cityData = gsModel.data?.cities ?? [];
  }

  void changeAdvanceSearchStatus() {
    isAdvanceSearch = !isAdvanceSearch;
    update();
  }

  String getDigitCountValue() {
    if (selectedDigit == null || selectedDigit!.isEmpty) return "";
    return selectedDigit!.split(' ').first;
  }

  String getStatusValue() {
    if (selectedStatus == null || selectedStatus == 'All') return "";
    return selectedStatus!.toLowerCase();
  }

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
    loadData();
  }

  Future<void> loadData() async {
    page = 0;
    myRequestedAdList.data = [];
    isLoading = true;
    update();
    await getMyRequestAdsData();
    isLoading = false;
    update();
  }

  Future<void> getMyRequestAdsData({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasNext() || isLoadMore) return;
      isLoadMore = true;
    } else {
      page = 0;
      myRequestedAdList.data = [];
      isLoading = true;
    }

    update();

    page++;

    try {
      ResponseModel responseModel = await repo.getMyRequestAdsRepo(
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
        MyRequestAdsResponseModel model = myRequestAdsResponseModelFromJson(jsonEncode(responseModel.responseJson));

        if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();
          nextPageUrl = model.data?.myRequestedAdList?.nextPageUrl;

          final tempList = model.data?.myRequestedAdList?.data;
          if (tempList != null && tempList.isNotEmpty) {
            myRequestedAdList.data!.addAll(tempList);
          }
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.somethingWentWrong]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print('Error fetching request ads: $e');
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
