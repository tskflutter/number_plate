import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/data/middleware/app_middleware.dart';

class KycMiddleware implements AppMiddleware {
  static bool isRedirecting = false;

  @override
  void handleResponse(response) {
    var responseData = response as dio.Response;

    if (responseData.data['remark'] == 'kyc_verification') {
      // if (!isRedirecting) {
      // isRedirecting = true; // Set the flag to true to prevent further redirects
      Get.offNamed(RouteHelper.kycScreen);
      // }
    }
  }
}
