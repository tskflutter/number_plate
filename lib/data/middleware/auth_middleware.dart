import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/data/middleware/app_middleware.dart';

class AuthMiddleware implements AppMiddleware {
  static bool isRedirecting = false;

  @override
  void handleResponse(response) {
    Get.toNamed(RouteHelper.loginScreen);
  }
}
