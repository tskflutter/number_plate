import 'dart:async';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/repo/home/home_repo.dart';
import 'package:get/get.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

import '../../../core/utils/util_exporter.dart';
import '../../model/global/response_model/response_model.dart';
import '../../model/profile/profile_response_model.dart';

class HomeController extends GetxController {
  HomeRepo homeRepo;
  HomeController({required this.homeRepo});
  String isKycVerified = '1';
  String email = "";
  bool isLoading = true;
  String username = "";
  String siteName = "";
  String totalCarPlate = "";
  String imagePath = "";

  String defaultCurrencySymbol = "";
  GeneralSettingResponseModel generalSettingResponseModel = GeneralSettingResponseModel();

  Future<void> initialData({bool shouldLoad = true}) async {
    isLoading = shouldLoad ? true : false;
    update();

    await loadInitialData();
    isLoading = false;
    update();
  }

  Future<void> loadInitialData() async {
    username = SharedPreferenceService.getUserName();
    email = SharedPreferenceService.getUserEmail();

    generalSettingResponseModel = SharedPreferenceService.getGeneralSettingData();
    defaultCurrencySymbol = SharedPreferenceService.getCurrencySymbol();
    siteName = generalSettingResponseModel.data?.generalSetting?.siteName ?? "";

    await loadUserProfileData();

    update();

    isLoading = false;
    update();
  }

  //Balance animation
  RxBool isAnimation = false.obs;
  RxBool isBalanceShown = false.obs;
  RxBool isBalance = true.obs;
  RxBool isClickable = true.obs; // Add this boolean flag

  void changeState() async {
    if (!isClickable.value) {
      return;
    }

    isClickable.value = false; // Disable clicking during animation and showing balance
    isAnimation.value = true;
    isBalance.value = false;

    // First animation: Show balance text
    await Future.delayed(const Duration(milliseconds: 500));
    isBalanceShown.value = true;

    // Third animation: Hide the circle
    await Future.delayed(const Duration(seconds: 3));
    isAnimation.value = false;
    isBalanceShown.value = false;
    // Fourth animation: Show balance text again
    await Future.delayed(const Duration(milliseconds: 500));
    isBalance.value = true;

    isClickable.value = true; // Re-enable clicking after the animation
  }

  bool showMoreWidget = false;
  changeShowMoreWidgetState() async {
    showMoreWidget = !showMoreWidget;
    update();
  }

  Future<void> loadUserProfileData() async {
    try {
      ResponseModel responseModel = await homeRepo.getUserInfoData();

      if (responseModel.statusCode == 200) {
        ProfileResponseModel model = ProfileResponseModel.fromJson(responseModel.responseJson);
        if (model.status == 'success') {
          await SharedPreferenceService.setString(SharedPreferenceService.userPhoneNumberKey, model.data?.user?.mobile ?? '');
          await SharedPreferenceService.setString(SharedPreferenceService.userNameKey, model.data?.user?.username ?? '');
          await SharedPreferenceService.setString(SharedPreferenceService.userEmailKey, model.data?.user?.email ?? '');
        } else {}
      } else {}
    } catch (e) {
      printX(e.toString());
    }
  }
}
