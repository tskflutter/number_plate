import 'dart:convert';
import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/data/repo/menu_repo/menu_repo.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:in_app_review/in_app_review.dart';
import '../../model/authorization/authorization_response_model.dart';

class MyMenuController extends GetxController {
  MenuRepo menuRepo;
  GeneralSettingRepo repo;
  MyMenuController({required this.menuRepo, required this.repo});

  bool logoutLoading = false;
  bool isLoading = true;
  bool noInternet = false;
  String token = "";

  bool balTransferEnable = true;
  bool langSwitchEnable = true;
  GlobalUser user = GlobalUser();
  final InAppReview inAppReview = InAppReview.instance;

  void loadData() async {
    isLoading = true;
    update();
    user = SharedPreferenceService.getUserData();
    print(user.imagePath);
    print(">>>>>>>>>>>>>>>>>>>>>>>>>");
    await configureMenuItem();
    isLoading = false;
    update();
  }

  bool removeLoading = false;
  Future<void> removeAccount() async {
    removeLoading = true;
    update();

    final responseModal = await menuRepo.removeAccount();
    if (responseModal.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(jsonDecode(responseModal.responseJson));
      if (model.status?.toLowerCase() == MyStrings.success) {
        await menuRepo.clearSharedPrefData();
        Get.offAllNamed(RouteHelper.loginScreen);
        CustomSnackBar.success(successList: model.message ?? [MyStrings.accountDeletedSuccessfully]);
      } else {
        CustomSnackBar.error(errorList: model.message ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModal.message]);
    }

    removeLoading = false;
    update();
  }

  Future<void> logout() async {
    logoutLoading = true;
    update();

    await menuRepo.logout();
    CustomSnackBar.success(successList: [MyStrings.logoutSuccessMsg]);

    logoutLoading = false;
    update();
    Get.offAllNamed(RouteHelper.loginScreen);
  }

  bool isTransferEnable = true;
  bool isWithdrawEnable = true;
  bool isInvoiceEnable = true;

  configureMenuItem() async {
    update();

    ResponseModel response = await repo.getGeneralSetting();

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(response.responseJson);
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        bool langStatus = model.data?.generalSetting?.multiLanguage == '0' ? false : true;
        langSwitchEnable = langStatus;
        //TODO
        // repo.apiClient.storeGeneralSetting(model);
        update();
      } else {
        List<String> message = [MyStrings.somethingWentWrong];
        CustomSnackBar.error(errorList: model.message ?? message);
        return;
      }
    } else {
      if (response.statusCode == 503) {
        //noInternet=true;
        update();
      }
      CustomSnackBar.error(errorList: [response.message]);
      return;
    }
  }
}
