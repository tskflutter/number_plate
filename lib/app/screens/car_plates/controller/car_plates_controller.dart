import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/car_plate/car_plate_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/car_plates/car_plates_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class CarPlatesController extends GetxController {
  CarPlatesRepo repo;
  CarPlatesController({required this.repo});

  bool isAdvanceSearch = false;
  bool isLoading = false;

  // Pagination
  int page = 0;
  String? nextPageUrl;

  // Range values for price slider (represents actual min/max prices)
  RangeValues currentRangeValues = const RangeValues(0, 100000);
  double minPriceLimit = 0;
  double maxPriceLimit = 100000;

  TextEditingController containsTextController = TextEditingController();
  TextEditingController startWithTextController = TextEditingController();
  TextEditingController endWithTextController = TextEditingController();
  TextEditingController minPriceTextController = TextEditingController();
  TextEditingController maxPriceTextController = TextEditingController();

  List<AdsData> carPlateData = [];
  List<City> cityData = [];

  String? selectedCity;
  String? selectedFormat;
  String? selectedDigit;
  String? selectedCityId;
  String defaultCurrency = "";

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

  @override
  void onInit() {
    super.onInit();
    // Update text fields when slider changes
    ever(
      RxRangeValues(currentRangeValues),
      (_) => updatePriceTextFields(),
    );
  }

  void changeAdvanceSearchStatus() {
    isAdvanceSearch = !isAdvanceSearch;
    update();
  }

  // Update text fields based on slider values
  void updatePriceTextFields() {
    minPriceTextController.text = currentRangeValues.start.toStringAsFixed(0);
    maxPriceTextController.text = currentRangeValues.end.toStringAsFixed(0);
  }

  // Update slider based on text field values
  void updateSliderFromTextFields() {
    try {
      double minValue = double.tryParse(minPriceTextController.text) ?? minPriceLimit;
      double maxValue = double.tryParse(maxPriceTextController.text) ?? maxPriceLimit;

      // Ensure values are within limits
      minValue = minValue.clamp(minPriceLimit, maxPriceLimit);
      maxValue = maxValue.clamp(minPriceLimit, maxPriceLimit);

      // Ensure min is less than max
      if (minValue > maxValue) {
        minValue = maxValue;
      }

      currentRangeValues = RangeValues(minValue, maxValue);
      update();
    } catch (e) {
      print('Error updating slider: $e');
    }
  }

  // Extract digit count number from string (e.g., "3 Digit" -> "3")
  String getDigitCountValue() {
    if (selectedDigit == null || selectedDigit!.isEmpty) return "";
    return selectedDigit!.split(' ').first;
  }

  // Reset all filters and reload data
  void resetFilters() {
    selectedCity = null;
    selectedCityId = null;
    selectedFormat = null;
    selectedDigit = null;
    containsTextController.clear();
    startWithTextController.clear();
    endWithTextController.clear();
    minPriceTextController.clear();
    maxPriceTextController.clear();
    currentRangeValues = RangeValues(minPriceLimit, maxPriceLimit);
    update();
    loadData();
  }

  // Load data - clears list and resets pagination
  loadData() async {
    carPlateData.clear();
    page = 0;
    isLoading = true;
    update();
    await getCarPlatesData();
    isLoading = false;
    update();
  }

  // Check if there's a next page
  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty;
  }

  // Main search function with filters and pagination
  Future<void> getCarPlatesData() async {
    page = page + 1;

    if (page == 1) {
      carPlateData.clear();
      update();
    }

    isLoading = true;
    update();

    try {
      // Prepare search parameters
      String digitCountParam = getDigitCountValue();
      String cityIdParam = selectedCityId ?? "";
      String containsParam = containsTextController.text.trim();
      String startWithParam = startWithTextController.text.trim();
      String endWithParam = endWithTextController.text.trim();

      // Get price values from text fields or slider
      String minPriceParam = "";
      String maxPriceParam = "";

      if (minPriceTextController.text.isNotEmpty) {
        minPriceParam = minPriceTextController.text.trim();
      } else if (currentRangeValues.start > minPriceLimit) {
        minPriceParam = currentRangeValues.start.toStringAsFixed(0);
      }

      if (maxPriceTextController.text.isNotEmpty) {
        maxPriceParam = maxPriceTextController.text.trim();
      } else if (currentRangeValues.end < maxPriceLimit) {
        maxPriceParam = currentRangeValues.end.toStringAsFixed(0);
      }

      ResponseModel responseModel = await repo.carPlatesRepo(
        page: page.toString(),
        digitCount: digitCountParam,
        cityId: cityIdParam,
        contains: containsParam,
        startWith: startWithParam,
        endWith: endWithParam,
        minPrice: minPriceParam,
        maxPrice: maxPriceParam,
      );

      if (responseModel.statusCode == 200) {
        CarPlateResponseModel model = carPlateResponseModelFromJson(
          jsonEncode(responseModel.responseJson),
        );

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();

          // Update next page URL for pagination
          nextPageUrl = model.data?.adLists?.nextPageUrl;

          // Get the data from current page
          List<AdsData>? tempList = model.data?.adLists?.data;

          if (tempList != null && tempList.isNotEmpty) {
            carPlateData.addAll(tempList);
          }

          // Load cities from general settings if not already loaded
          if (cityData.isEmpty) {
            final gsModel = SharedPreferenceService.getGeneralSettingData();
            cityData = gsModel.data?.cities ?? [];
          }

          // Calculate price limits from data for slider (only on first page load)
          if (page == 1 && carPlateData.isNotEmpty) {
            List<double> prices = carPlateData.where((item) => item.price != null).map((item) => double.tryParse(item.price ?? "0") ?? 0).toList();

            if (prices.isNotEmpty) {
              minPriceLimit = prices.reduce((a, b) => a < b ? a : b);
              maxPriceLimit = prices.reduce((a, b) => a > b ? a : b);

              // Reset slider to full range if it's the initial load
              if (currentRangeValues.start == 0 && currentRangeValues.end == 100000) {
                currentRangeValues = RangeValues(minPriceLimit, maxPriceLimit);
              }
            }
          }

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
      print('Error fetching car plates: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      isLoading = false;
      update();
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

// Extension for reactive RangeValues
class RxRangeValues extends Rx<RangeValues> {
  RxRangeValues(RangeValues initial) : super(initial);
}
