import 'package:get/get.dart';

import 'package:ovolutter/data/controller/splash/splash_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/data/repo/splash/splash_repo.dart';

initDependency() async {
  Get.lazyPut(() => SplashRepo());
  Get.lazyPut(() => SplashController(repo: Get.find()));
  Get.lazyPut(() => GeneralSettingRepo());
}
