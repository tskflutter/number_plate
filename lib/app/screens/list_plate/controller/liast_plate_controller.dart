import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/country_model/country_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/list_plate/list_plate_data_model.dart';
import 'package:ovolutter/data/model/list_plate/list_plate_data_response_model.dart';
import 'package:ovolutter/data/model/list_plate/list_plate_responde_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/car_plates/car_plates_repo.dart';
import 'package:ovolutter/data/repo/list_plate/list_plate_repo.dart';
import 'package:ovolutter/data/repo/request_plates/request_plates_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:ovolutter/environment.dart';

class ListPlatesController extends GetxController {
  ListPlateRepo repo;

  ListPlatesController({required this.repo});

  TextEditingController priceController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController whatsAppNoController = TextEditingController();
  TextEditingController plateNoController = TextEditingController();
  TextEditingController plateLetterController = TextEditingController();
  String? selectedCity;
  String? selectedCityId;
  String? carId;
  String? userId;
  String? token;
  bool? isRequest;
  String? listingFee;
  String? whatsAppDialCode;
  AdsData? ad;
  String? mobileNumberDialCode;
  int currentIndex = -1;
  int currentPage = 1;

  List<City> cities = [];
  List<AdType> plateTypes = [];
  bool callForPrice = false;
  GlobalUser user = GlobalUser();
  bool countryLoading = true;
  bool isLoading = false;
  String defaultCurrency = "";
  String userImagePath = "";
  Countries? whatsAppCountryData;
  Countries? phoneCountryData;

  // CHANGED: Make this a List instead of single Countries object
  List<Countries> countriesList = [];

  void selectWhatsAppCountry({Countries? countryDataValue}) {
    whatsAppCountryData = countryDataValue;
    if (whatsAppCountryData != null) {
      whatsAppDialCode = whatsAppCountryData?.dialCode ?? "";
    }
    update();
  }

  void selectPhoneCountry({Countries? countryDataValue}) {
    phoneCountryData = countryDataValue;
    if (phoneCountryData != null) {
      mobileNumberDialCode = phoneCountryData?.dialCode ?? "";
    }
    update();
  }

  void changeAdvanceSearchStatus() {
    callForPrice = !callForPrice;
    update();
  }

  void plateDetailsData() async {
    isLoading = true;
    update();

    try {
      ResponseModel responseModel = await repo.getData();

      if (responseModel.statusCode == 200) {
        ListPlateDataResponseModel model = listPlateDataResponseModelFromJson(jsonEncode(responseModel.responseJson));

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();

          cities = model.data?.cities ?? [];
          plateTypes = model.data?.adTypes ?? [];
          user = model.data?.user ?? GlobalUser();
          userImagePath = model.data?.userImagePath ?? "";

          // Load countries list if available in your model
          // countriesList = model.data?.countries ?? [];

          // Initialize default country after data is loaded
          initializeDefaultCountry();

          update();
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.requestFail]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      isLoading = false;
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  void initializeDefaultCountry() {
    // If you have a countries list from API, use it
    if (countriesList.isNotEmpty) {
      final defaultCountry = countriesList.firstWhere(
        (country) => country.countryCode == Environment.defaultCountryCode,
        orElse: () => Countries(
          countryCode: Environment.defaultCountryCode,
          dialCode: Environment.defaultPhoneCode,
        ),
      );

      whatsAppCountryData = defaultCountry;
      phoneCountryData = defaultCountry;

      whatsAppDialCode = defaultCountry.dialCode ?? '';
      mobileNumberDialCode = defaultCountry.dialCode ?? '';
    } else {
      // If no countries list, create default country directly
      final defaultCountry = Countries(
        countryCode: Environment.defaultCountryCode,
        dialCode: Environment.defaultPhoneCode,
        country: 'Bangladesh', // or get from Environment
      );

      whatsAppCountryData = defaultCountry;
      phoneCountryData = defaultCountry;

      whatsAppDialCode = defaultCountry.dialCode ?? '';
      mobileNumberDialCode = defaultCountry.dialCode ?? '';
    }

    update();
  }

  bool isSubmitLoading = false;
  void addPlate() async {
    try {
      isSubmitLoading = true;
      update();
      ListPlateDataModel data = getListData();
      print("thi sis $isRequest");
      ResponseModel model = await repo.listPlate(isRequest ?? false, data);

      if (model.statusCode == 200) {
        ListPlateAddResponseModel listPlateAddModel = ListPlateAddResponseModel.fromJson(model.responseJson);

        if (listPlateAddModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          ad = listPlateAddModel.data?.ad;
          isRequest == true ? Get.offAndToNamed(RouteHelper.bottomNavBar) : Get.toNamed(RouteHelper.payNowScreen, arguments: [ad]);
          CustomSnackBar.success(
            successList: listPlateAddModel.message ?? [MyStrings.somethingWentWrong.tr],
          );
          update();
        } else {
          CustomSnackBar.error(
            errorList: listPlateAddModel.message ?? [MyStrings.somethingWentWrong.tr],
          );
        }
      } else {
        CustomSnackBar.error(errorList: [model.message]);
      }
    } catch (e) {
      CustomSnackBar.error(errorList: [MyStrings.somethingWentWrong]);
    } finally {
      isSubmitLoading = false;
      update();
    }
  }

  ListPlateDataModel getListData() {
    return ListPlateDataModel(
      price: priceController.text,
      plateNumber: plateNoController.text,
      plateLetter: plateLetterController.text,
      cityId: selectedCityId.toString(),
      carId: carId.toString(),
      priceType: callForPrice ? "1" : "2",
      userId: userId.toString(),
      whatsAppNumber: "$whatsAppDialCode${whatsAppNoController.text}",
      phoneNumber: "$mobileNumberDialCode${mobileNoController.text}",
    );
  }

  resetData() {
    priceController.text = "";
    plateNoController.text = "";
    plateLetterController.text = "";
    mobileNoController.text = "";
    mobileNoController.text = "";
    selectedCityId = "";
    carId = "";
    userId = "";
    update();
  }

  void changeCarType(int index) {
    currentIndex = index;
    carId = plateTypes[index].id;
    print(currentIndex);
    update();
  }
}
