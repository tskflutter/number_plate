import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/util.dart';

import 'package:ovolutter/data/controller/splash/splash_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    MyUtils.splashScreen();

    Get.put(GeneralSettingRepo());
    final controller = Get.put(SplashController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.gotoNextPage();
    });
  }

  @override
  void dispose() {
    MyUtils.allScreen();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      builder: (controller) => AnnotatedRegionWidget(
        systemNavigationBarColor: MyColor.darkScaffoldBackground,
        statusBarColor: MyColor.getTransparentColor(),
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        padding: EdgeInsets.zero,
        child: Scaffold(
          backgroundColor: controller.noInternet ? MyColor.white : MyColor.getPrimaryColor(),
          body: Stack(
            children: [
              controller.isBgLoading
                  ? CustomLoader()
                  : MyNetworkImageWidget(
                      imageUrl: controller.splashImage,
                      height: double.infinity,
                      width: double.infinity,
                    ),
              Positioned(
                right: 0,
                left: 0,
                bottom: 280,
                child: MyAssetImageWidget(
                  height: 100,
                  width: 100,
                  boxFit: BoxFit.contain,
                  assetPath: MyImages.demoAppIcon,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
