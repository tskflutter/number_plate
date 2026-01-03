import 'dart:async';
import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/authorization/authorization_response_model.dart';
import 'package:ovolutter/data/model/authorization/email_verify_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/repo/auth/sms_email_verification_repo.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class EmailVerificationController extends GetxController {
  SmsEmailVerificationRepo repo;

  EmailVerificationController({required this.repo});

  String currentText = "";
  String userMail = "";
  bool needTwoFactor = false;
  bool submitLoading = false;
  bool isLoading = false;
  bool resendLoading = false;

  loadData() async {
    isLoading = true;
    update();
    ResponseModel responseModel = await repo.sendAuthorizationRequest();

    if (responseModel.statusCode == 200) {
      AuthorizationResponseModel model = AuthorizationResponseModel.fromJson(responseModel.responseJson);
      userMail = SharedPreferenceService.getUserEmail();
      if (model.status == 'error') {
        CustomSnackBar.error(errorList: model.message ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    update();
  }

  Future<void> verifyEmail(String text) async {
    if (text.isEmpty) {
      CustomSnackBar.error(errorList: [MyStrings.otpFieldEmptyMsg]);
      return;
    }

    submitLoading = true;
    update();

    ResponseModel responseModel = await repo.verify(text);

    if (responseModel.statusCode == 200) {
      EmailVerifyResponseModel model = EmailVerifyResponseModel.fromJson(responseModel.responseJson);

      bool isSMSVerificationEnable = model.data?.user?.sv == "0" ? true : false;

      if (model.status == MyStrings.success) {
        CustomSnackBar.success(successList: model.message ?? [(MyStrings.emailVerificationSuccess)]);
        if (isSMSVerificationEnable) {
          Get.offAndToNamed(RouteHelper.smsVerificationScreen);
        } else {
          Get.offAndToNamed(RouteHelper.bottomNavBar);
        }
      } else {
        CustomSnackBar.error(errorList: model.message ?? [(MyStrings.emailVerificationFailed)]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    submitLoading = false;
    update();
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

  Future<void> sendCodeAgain() async {
    resendLoading = true;
    update();

    await repo.resendVerifyCode(isEmail: true);
    startResendTimer();
    resendLoading = false;
    update();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
