import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/app_style.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_images.dart';
import '../../../core/utils/my_strings.dart';
import 'intro-screen-widgets/onboard_body.dart';

class OnBoardIntroScreen extends StatefulWidget {
  const OnBoardIntroScreen({super.key});

  @override
  State<OnBoardIntroScreen> createState() => _OnBoardIntroScreenState();
}

class _OnBoardIntroScreenState extends State<OnBoardIntroScreen> {
  late PageController _pageController;
  var currentPageID = 0;

  List<OnboardingScreen>? onboardingScreen;
  String imagePath = "";

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _loadOnboardingData();
  }

  Future<void> _loadOnboardingData() async {
    final model = SharedPreferenceService.getGeneralSettingData();
    setState(() {
      onboardingScreen = model.data?.generalSetting?.onboardingScreen ?? [];
      imagePath = model.data?.onboardingScreenFilePath ?? "";
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      for (int i = 0; i < MyImages.onboardImages.length; i++) ...[
        OnboardingPage(
          imagePath: "${UrlContainer.domainUrl}/$imagePath/${onboardingScreen?[i].onboardingImage ?? ""}",
          index: i,
          title: onboardingScreen?[i].onboardingTitle ?? "",
          description: onboardingScreen?[i].onboardingSubtitle ?? "",
        ),
      ],
    ];

    return AnnotatedRegionWidget(
      systemNavigationBarColor: MyColor.darkScaffoldBackground,
      statusBarColor: MyColor.getTransparentColor(),
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
      padding: EdgeInsets.zero,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: MyImages.onboardImages.length,
              onPageChanged: (index) {
                setState(() => currentPageID = index);
              },
              itemBuilder: (_, index) {
                return MyNetworkImageWidget(
                  imageUrl: "${UrlContainer.domainUrl}/$imagePath/${onboardingScreen?[index].onboardingImage ?? ""}",
                  boxFit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
            MyAssetImageWidget(
              assetPath: MyImages.shade,
              boxFit: BoxFit.cover,
              isSvg: true,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.space15,
                  vertical: Dimensions.space10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyAssetImageWidget(
                      assetPath: MyImages.demologo,
                      boxFit: BoxFit.contain,
                    ),
                    if (currentPageID != 2)
                      InkWell(
                        onTap: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: CustomAppCard(
                          showBorder: false,
                          backgroundColor: MyColor.white.withValues(alpha: .64),
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.space16,
                            vertical: Dimensions.space4,
                          ),
                          child: Text(
                            MyStrings.skip.tr,
                            style: regularLarge.copyWith(
                              color: MyColor.headingTextColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: Dimensions.space20,
                ),
                child: Column(
                  children: [
                    Text(
                      onboardingScreen?[currentPageID].onboardingTitle ?? "",
                      textAlign: TextAlign.center,
                      style: regularLarge.copyWith(
                        fontSize: 30,
                        color: MyColor.white,
                      ),
                    ),
                    Text(
                      onboardingScreen?[currentPageID].onboardingSubtitle ?? "",
                      textAlign: TextAlign.center,
                      style: boldOverLarge.copyWith(
                        fontSize: 40,
                        color: MyColor.lightSecondary,
                        fontWeight: FontWeight.w900,
                        height: 1.2,
                      ),
                    ),
                    Text(
                      onboardingScreen?[currentPageID].onboardingDescription ?? "",
                      textAlign: TextAlign.center,
                      style: regularDefault.copyWith(
                        color: MyColor.white.withValues(alpha: .60),
                        height: 1.5,
                      ),
                    ),

                    spaceDown(Dimensions.space60),

                    /// 🔹 Buttons & indicators (UNCHANGED)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildBottomButtons(
                          () {
                            if (currentPageID != 0) {
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          currentPageID == 0 ? MyColor.white.withValues(alpha: .4) : MyColor.white.withValues(alpha: .6),
                          MyColor.white.withValues(alpha: .12),
                          false,
                          MyStrings.back,
                        ),
                        Row(
                          children: List.generate(
                            MyImages.onboardImages.length,
                            (i) => Container(
                              margin: const EdgeInsets.only(right: Dimensions.space5),
                              width: currentPageID == i ? 15 : 10,
                              height: currentPageID == i ? 15 : 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentPageID == i ? MyColor.white : MyColor.white.withValues(alpha: .3),
                              ),
                            ),
                          ),
                        ),
                        buildBottomButtons(
                          () {
                            if (currentPageID == 2) {
                              Get.toNamed(RouteHelper.loginScreen);
                            } else {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          MyColor.white.withValues(alpha: .6),
                          MyColor.white.withValues(alpha: .12),
                          true,
                          currentPageID == 2 ? MyStrings.signIn : MyStrings.next,
                        ),
                      ],
                    ),
                    spaceDown(Dimensions.space20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildBottomButtons(
  VoidCallback onTap,
  Color textColor,
  Color buttonColor,
  bool isNext,
  String buttonText,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space8, horizontal: Dimensions.space16),
      decoration: BoxDecoration(
        border: BoxBorder.all(color: MyColor.white.withValues(alpha: .12)),
        borderRadius: BorderRadius.circular(Dimensions.space10.h),
        color: buttonColor,
      ),
      child: Row(
        children: [
          if (!isNext) ...[
            MyAssetImageWidget(
              assetPath: MyImages.arrowBack,
              width: Dimensions.space15,
              height: Dimensions.space10,
              isSvg: true,
              boxFit: BoxFit.contain,
              color: textColor,
            ),
            spaceSide(Dimensions.space10)
          ],
          Text(
            buttonText.tr,
            style: regularMediumLarge.copyWith(
              color: textColor,
              fontSize: 14,
            ),
          ),
          if (isNext) ...[
            spaceSide(Dimensions.space8),
            MyAssetImageWidget(
              assetPath: MyImages.arrowForward,
              width: Dimensions.space20,
              height: Dimensions.space20,
              isSvg: true,
              boxFit: BoxFit.contain,
              color: textColor,
            ),
          ],
        ],
      ),
    ),
  );
}
