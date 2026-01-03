import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:toastification/toastification.dart';

class CustomSnackBar {
  static error({required List<String> errorList, int duration = 5}) {
    String message = '';
    if (errorList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in errorList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = AppConverter.removeQuotationAndSpecialCharacterFromString(message);
    toastification.show(
      context: Get.context,
      type: ToastificationType.error,
      style: ToastificationStyle.fillColored,
      title: Text(message, maxLines: 10, style: Get.theme.textTheme.bodyMedium?.copyWith(color: MyColor.white)),
      // description: Text("Component updates available."),
      alignment: Alignment.topCenter,
      foregroundColor: MyColor.white,
      primaryColor: MyColor.getErrorColor(),
      // backgroundColor: MyColor.redCancelTextColor.withValues(alpha: 0.6),
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: duration),
      borderRadius: BorderRadius.circular(12.0),
      applyBlurEffect: false,
    );
    // Get.closeAllSnackbars();
    // Get.rawSnackbar(
    //   progressIndicatorBackgroundColor: MyColor.getTransparentColor(),
    //   progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(MyColor.getTransparentColor()),
    //   messageText: Text(message, style: theme.textTheme.labelLarge?.copyWith(color: MyColor.white)),
    //   dismissDirection: DismissDirection.horizontal,
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: MyColor.getErrorColor().withValues(alpha: 0.7),
    //   borderRadius: 5,
    //   margin: const EdgeInsets.all(Dimensions.space8),
    //   padding: const EdgeInsets.all(Dimensions.space8),
    //   duration: Duration(seconds: duration),
    //   isDismissible: true,
    //   forwardAnimationCurve: Curves.easeIn,
    //   showProgressIndicator: true,

    //   leftBarIndicatorColor: MyColor.getTransparentColor(),
    //   icon: Icon(
    //     Icons.close_rounded,
    //     color: MyColor.white,
    //   ),
    //   animationDuration: const Duration(seconds: 1),
    //   borderColor: MyColor.getTransparentColor(),
    //   reverseAnimationCurve: Curves.easeOut,
    //   borderWidth: 2,
    // );
  }

  static success({required List<String> successList, int duration = 5}) {
    String message = '';
    if (successList.isEmpty) {
      message = MyStrings.somethingWentWrong.tr;
    } else {
      for (var element in successList) {
        String tempMessage = element.tr;
        message = message.isEmpty ? tempMessage : "$message\n$tempMessage";
      }
    }
    message = AppConverter.removeQuotationAndSpecialCharacterFromString(message);
    toastification.show(
      context: Get.context,
      type: ToastificationType.success,
      style: ToastificationStyle.fillColored,
      title: Text(message, maxLines: 10, style: Get.theme.textTheme.bodyMedium?.copyWith(color: MyColor.white)),
      // description: Text("Component updates available."),
      alignment: Alignment.topCenter,
      foregroundColor: MyColor.white,
      primaryColor: MyColor.getSuccessColor(),
      // backgroundColor: MyColor.redCancelTextColor.withValues(alpha: 0.6),
      showProgressBar: false,
      autoCloseDuration: Duration(seconds: duration),
      borderRadius: BorderRadius.circular(12.0),
      applyBlurEffect: false,
    );
    // Get.closeAllSnackbars();
    // Get.rawSnackbar(
    //   progressIndicatorBackgroundColor: MyColor.getSuccessColor(),
    //   progressIndicatorValueColor: AlwaysStoppedAnimation<Color>(MyColor.getTransparentColor()),
    //   messageText: Text(message, style: theme.textTheme.labelLarge?.copyWith(color: MyColor.white)),
    //   dismissDirection: DismissDirection.horizontal,
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: MyColor.getSuccessColor().withValues(alpha: 0.8),
    //   borderRadius: 5,
    //   margin: const EdgeInsets.all(Dimensions.space8),
    //   padding: const EdgeInsets.all(Dimensions.space8),
    //   duration: Duration(seconds: duration),
    //   isDismissible: true,
    //   forwardAnimationCurve: Curves.easeInOutCubicEmphasized,
    //   showProgressIndicator: true,
    //   leftBarIndicatorColor: MyColor.getTransparentColor(),
    //   icon: Icon(
    //     Icons.check_circle_outline_rounded,
    //     color: MyColor.white,
    //   ),
    //   animationDuration: const Duration(seconds: 2),
    //   borderColor: MyColor.getTransparentColor(),
    //   reverseAnimationCurve: Curves.easeOut,
    //   borderWidth: 2,
    // );
  }
}
