import 'dart:async';

import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/auth/verification/email_verification_model.dart';
import 'package:ovolutter/data/repo/auth/login_repo.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';

class VerifyPasswordController extends GetxController {
  LoginRepo loginRepo;
  VerifyPasswordController({required this.loginRepo});

  String email = '';
  String password = '';
  bool isLoading = false;
  bool remember = false;
  bool hasError = false;

  List<String> errors = [];
  String currentText = "";
  String confirmPassword = '';

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

  void resendForgetPassCode() async {
    isResendLoading = true;
    update();
    String value = email;
    String type = 'email';
    await loginRepo.forgetPassword(type, value);
    startResendTimer();
    isResendLoading = false;
    update();
  }

  bool verifyLoading = false;

  void verifyForgetPasswordCode(String value) async {
    if (value.isNotEmpty) {
      verifyLoading = true;
      update();

      EmailVerificationModel model = await loginRepo.verifyForgetPassCode(value);

      if (model.code == 200) {
        verifyLoading = false;
        Get.offAndToNamed(RouteHelper.resetPasswordScreen, arguments: [email, value]);
      } else {
        verifyLoading = false;
        update();
        List<String> errorList = [MyStrings.verificationFailed];
        CustomSnackBar.error(errorList: model.message ?? errorList);
      }
    }
  }

  String getFormatedMail() {
    try {
      List<String> tempList = email.split('@');
      int maskLength = tempList[0].length;
      String maskValue = tempList[0][0].padRight(maskLength, '*');
      String value = '$maskValue@${tempList[1]}';
      return value;
    } catch (e) {
      return email;
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
