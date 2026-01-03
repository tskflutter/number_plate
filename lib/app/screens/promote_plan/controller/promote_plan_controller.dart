import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/util.dart';
import 'package:ovolutter/data/model/ads_details/ad_boost_model.dart';
import 'package:ovolutter/data/model/country_model/country_model.dart';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/promote_plan_repo/promote_plan_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:ovolutter/environment.dart';

class PromotePlanController extends GetxController {
  PromotePlanRepo repo;

  PromotePlanController({required this.repo});

  TextEditingController priceController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  String? selectedCity;
  String? defaultCurrency;
  String? adId;
  String? boostAdId;
  int currentIndex = -1;
  int currentPage = 1;
  double vipPrice = 0.0;
  double featuredPrice = 0.0;
  AdsData? myAdsData;
  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  final List<String> cities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Phoenix',
  ];
  bool callForPrice = false;
  DateTime? pickedFromDate;
  DateTime? pickedToDate;

  void pickFromDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: pickedFromDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      pickedFromDate = selectedDate;
      // Clear "to" date if it's before the new "from" date
      if (pickedToDate != null && pickedToDate!.isBefore(selectedDate)) {
        pickedToDate = null;
      }
      update();
    }
  }

  void pickToDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: pickedToDate ?? (pickedFromDate ?? DateTime.now()),
      firstDate: pickedFromDate ?? DateTime.now(), // "To" date must be after "from" date
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      pickedToDate = selectedDate;
      update();
    }
  }

  bool boostLoading = false;
  void getData() {
    generalSettingResponseModel = SharedPreferenceService.getGeneralSettingData();
    vipPrice = double.tryParse(generalSettingResponseModel.data?.generalSetting?.vipListingFee.toString() ?? "") ?? 0.0;
    featuredPrice = double.tryParse(generalSettingResponseModel.data?.generalSetting?.featureListingFee.toString() ?? "") ?? 0.0;
    defaultCurrency = SharedPreferenceService.getCurrencySymbol();
  }

  void boostAdData() async {
    boostLoading = true;
    update();
    try {
      ResponseModel responseModel = await repo.boosting(adId ?? "", callForPrice ? "2" : "1", pickedFromDate, pickedToDate);

      if (responseModel.statusCode == 200) {
        AdBoostingResponseModel adBoostingResponseModel = AdBoostingResponseModel.fromJson(responseModel.responseJson);

        if (adBoostingResponseModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          Get.toNamed(RouteHelper.newDepositScreenScreen, arguments: [AppConverter.formatNumber(getFormattedTotalPrice()), adBoostingResponseModel.data?.ad?.id ?? "", true]);
        } else {
          CustomSnackBar.error(
            errorList: adBoostingResponseModel.message ?? [MyStrings.loginFailedTryAgain],
          );
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      printX('Error fetching plate delete: $e');
      boostLoading = false;
      update();
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    }
    boostLoading = false;
    update();
  }

  bool countryLoading = true;
  Countries? countryData;
  RangeValues currentRangeValues = const RangeValues(20, 80);

  void changeAdvanceSearchStatus() {
    callForPrice = !callForPrice;
    update();
  }

  selectACountry({Countries? countryDataValue}) {
    countryData = countryDataValue;
    if (countryData != null) {
      countryController.text = countryData!.country!;
    } else {
      countryController.text = SharedPreferenceService.getCountryJsonDataData().data?.countries?.firstWhere((v) => v.countryCode == Environment.defaultCountryCode).country ?? "";
    }

    update();
  }

  void changeCarType(int index) {
    currentIndex = index;
    print(currentIndex);
    update();
  }

  // Calculate total days between from and to date
  int getTotalDays() {
    if (pickedFromDate == null || pickedToDate == null) {
      return 0;
    }
    return pickedToDate!.difference(pickedFromDate!).inDays + 1; // +1 to include both start and end date
  }

  // Calculate total price based on plan type and total days
  double calculateTotalPrice() {
    int totalDays = getTotalDays();

    if (totalDays <= 0) {
      return 0.0;
    }

    if (callForPrice) {
      // Featured price * total days
      return featuredPrice * totalDays;
    } else {
      // VIP price * total days
      return vipPrice * totalDays;
    }
  }

  // Get formatted total price
  String getFormattedTotalPrice() {
    double totalPrice = calculateTotalPrice();
    return totalPrice.toStringAsFixed(2);
  }

  // Get plan type name
  String getPlanTypeName() {
    return callForPrice ? "Featured" : "VIP";
  }

  // Get current plan price per day
  double getPricePerDay() {
    return callForPrice ? featuredPrice : vipPrice;
  }
}
