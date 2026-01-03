import 'dart:async';
import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/authorization/authorization_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/repo/auth/sms_email_verification_repo.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class SmsVerificationController extends GetxController {
  SmsEmailVerificationRepo repo;
  SmsVerificationController({required this.repo});

  bool hasError = false;
  bool isLoading = false;
  String currentText = '';
  String mobileNumber = '';

  Future<void> intData() async {
    isLoading = true;
    update();
    await repo.sendAuthorizationRequest();
    mobileNumber = SharedPreferenceService.getString(SharedPreferenceService.userPhoneNumberKey);
    isLoading = false;
    update();
    return;
  }

  bool isResendLoading = false;

  int resendSeconds = 60;
  Timer? _timer;
  bool canResend = false;

  @override
  void onInit() {
    startResendTimer();
    super.onInit();
  }

  void startResendTimer() {
    canResend = false;
    resendSeconds = 60;
    update();

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      resendSeconds--;

      if (resendSeconds <= 0) {
        timer.cancel();
        canResend = true;
      }
      update();
    });
  }

  bool submitLoading = false;
  verifyYourSms(String currentText) async {
    if (currentText.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg.tr]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(currentText, isEmail: false);

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(responseModel.responseJson);

      bool is2FAEnable = model.data?.user?.tv == "0" ? true : false;

      if (model.status == MyStrings.success) {
        CustomSnackBar.success(successList: model.message ?? ['${MyStrings.sms.tr} ${MyStrings.verificationSuccess.tr}']);

        Get.offAndToNamed(RouteHelper.bottomNavBar);
      } else {
        CustomSnackBar.error(errorList: model.message ?? ['${MyStrings.sms.tr} ${MyStrings.verificationFailed}']);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
  }

  bool resendLoading = false;
  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();
    await repo.resendVerifyCode(isEmail: false);
    resendLoading = false;
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
