import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/app/components/user_details/user_details_data.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/menu/widget/delete_account_bottom_sheet_body.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/menu/widget/menu_card_widget.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/menu/widget/menu_item.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/controller/menu/my_menu_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/data/repo/menu_repo/menu_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

import '../../../components/bottom-sheet/custom_bottom_sheet.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    Get.put(GeneralSettingRepo());
    Get.put(MenuRepo());
    final controller = Get.put(MyMenuController(menuRepo: Get.find(), repo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.token = SharedPreferenceService.getAccessToken();

      if (controller.token != "") {
        controller.loadData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyMenuController>(
        builder: (menuController) => WillPopWidget(
            nextRoute: RouteHelper.bottomNavBar,
            child: MyCustomScaffold(
              showAppBar: false,
              body: GetBuilder<MyMenuController>(
                builder: (controller) => SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    spaceDown(Dimensions.space20),
                    Text(
                      MyStrings.myAccount.tr,
                      style: boldOverLarge.copyWith(color: MyColor.headingTextColor, fontSize: Dimensions.space22, fontFamily: 'poppins'),
                    ),
                    spaceDown(Dimensions.space20),
                    controller.token == ""
                        ? Row(
                            children: [
                              CustomAppCard(
                                showShadow: false,
                                padding: EdgeInsets.all(Dimensions.space12),
                                radius: Dimensions.space100,
                                backgroundColor: MyColor.hintTextColor,
                                child: MyAssetImageWidget(
                                  assetPath: MyImages.guestImage,
                                  isSvg: true,
                                  boxFit: BoxFit.contain,
                                  height: Dimensions.space24.h,
                                  width: Dimensions.space24.h,
                                ),
                              ),
                              spaceSide(Dimensions.space8),
                              Text(
                                MyStrings.guestMode.tr,
                                style: semiBoldMediumLarge.copyWith(color: MyColor.primaryTextColor, fontWeight: FontWeight.w700, fontFamily: 'poppins'),
                              ),
                              Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Get.offAllNamed(RouteHelper.loginScreen);
                                },
                                child: MyAssetImageWidget(
                                  assetPath: MyImages.logout,
                                  isSvg: true,
                                  color: MyColor.primaryTextColor,
                                  height: Dimensions.space20.h,
                                  width: Dimensions.space20.h,
                                ),
                              )
                            ],
                          )
                        : UserDetailsData(
                            name: controller.user.username ?? "",
                            subtitle: "+${controller.user.dialCode}${controller.user.mobile}",
                            userImage: "${UrlContainer.domainUrl}/${controller.user.imagePath}/${controller.user.image}",
                          ),
                    spaceDown(Dimensions.space20),
                    controller.token != ""
                        ? Text(
                            MyStrings.account.tr,
                            style: regularLarge.copyWith(color: MyColor.hintTextColor, fontFamily: 'poppins'),
                          )
                        : SizedBox(),
                    spaceDown(Dimensions.space8),
                    controller.token != ""
                        ? MenuCardWidget(
                            child: Column(
                              children: [
                                MenuItems(imageSrc: MyImages.profileImg, label: MyStrings.profile.tr, onPressed: () => Get.toNamed(RouteHelper.profileScreen)),
                                CustomDivider(
                                  space: Dimensions.space10,
                                ),
                                MenuItems(imageSrc: MyImages.changePassImage, label: MyStrings.changePassword, onPressed: () => Get.toNamed(RouteHelper.changePasswordScreen)),
                                CustomDivider(
                                  space: Dimensions.space10,
                                ),
                                MenuItems(imageSrc: MyImages.notification, label: MyStrings.notifications, onPressed: () => Get.toNamed(RouteHelper.notificationScreen)),
                              ],
                            ),
                          )
                        : SizedBox(),
                    spaceDown(Dimensions.space10),
                    Text(
                      MyStrings.general.tr,
                      style: regularLarge.copyWith(color: MyColor.hintTextColor, fontFamily: 'poppins'),
                    ),
                    spaceDown(Dimensions.space8),
                    MenuCardWidget(
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MenuItems(imageSrc: MyImages.language, label: MyStrings.language.tr, onPressed: () => Get.toNamed(RouteHelper.languageScreen)),
                              CustomDivider(
                                space: Dimensions.space10,
                              ),
                            ],
                          ),
                          MenuItems(imageSrc: MyImages.supportImage, label: MyStrings.contactSupport.tr, onPressed: () => Get.toNamed(RouteHelper.allTicketScreen)),
                        ],
                      ),
                    ),
                    spaceDown(Dimensions.space10),
                    Text(
                      MyStrings.more.tr,
                      style: regularLarge.copyWith(color: MyColor.hintTextColor, fontFamily: 'poppins'),
                    ),
                    spaceDown(Dimensions.space8),
                    MenuCardWidget(
                      child: Column(
                        children: [
                          MenuItems(imageSrc: MyImages.policyImage, label: MyStrings.policies.tr, onPressed: () => Get.toNamed(RouteHelper.privacyScreen)),
                          CustomDivider(
                            space: Dimensions.space10,
                          ),
                          MenuItems(imageSrc: MyImages.faqImage, label: MyStrings.faq.tr, onPressed: () => Get.toNamed(RouteHelper.faqScreen)),
                          CustomDivider(
                            space: Dimensions.space10,
                          ),
                          MenuItems(
                            imageSrc: MyImages.rateUs,
                            label: MyStrings.rateUs.tr,
                            onPressed: () async {
                              if (await controller.inAppReview.isAvailable()) {
                                controller.inAppReview.requestReview();
                              } else {
                                CustomSnackBar.error(
                                  errorList: [
                                    MyStrings.pleaseUploadYourAppOnPlayStore,
                                  ],
                                );
                              }
                            },
                          ),
                          controller.token != ""
                              ? CustomDivider(
                                  space: Dimensions.space10,
                                )
                              : SizedBox(),
                          controller.token != ""
                              ? MenuItems(
                                  imageSrc: MyImages.deleteAcc,
                                  label: MyStrings.deleteAccount.tr,
                                  onPressed: () => CustomBottomSheet(
                                        isNeedMargin: true,
                                        child: const DeleteAccountBottomsheetBody(),
                                      ).customBottomSheet(context))
                              : SizedBox(),
                        ],
                      ),
                    ),
                    spaceDown(Dimensions.space24),
                    controller.token != ""
                        ? CustomAppCard(
                            onPressed: () {
                              controller.logout();
                            },
                            showShadow: false,
                            backgroundColor: MyColor.darkError.withValues(alpha: .1),
                            borderColor: MyColor.darkError,
                            child: Column(
                              children: [
                                controller.logoutLoading
                                    ? CustomLoader()
                                    : Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          MyAssetImageWidget(assetPath: MyImages.signOut, isSvg: true, height: Dimensions.space20, width: Dimensions.space20),
                                          spaceSide(Dimensions.space8),
                                          Flexible(
                                            child: Text(
                                              MyStrings.signOut,
                                              style: regularLarge.copyWith(
                                                color: MyColor.darkError,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ],
                            ))
                        : SizedBox(),
                    const SizedBox(
                      height: Dimensions.space100,
                    )
                  ]),
                ),
              ),
            )));
  }
}
