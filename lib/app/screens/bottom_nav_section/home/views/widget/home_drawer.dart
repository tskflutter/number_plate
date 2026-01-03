import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/theme/my_theme.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/app/components/advance_switch/custom_switch.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/drawer/drawer_item.dart';
import 'package:ovolutter/app/components/drawer/user_drawer_card.dart';

// ignore: unused_import
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import '../../../../../../data/controller/home/home_controller.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Drawer(
      width: context.width / 1.3,
      backgroundColor: theme.cardColor,
      child: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: Dimensions.space30,
                  ),
                  GetBuilder<HomeController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.profileScreen);
                      },
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: Dimensions.space15,
                        ),
                        child: DrawerUserCard(
                          fullName: controller.username,
                          username: controller.username,
                          subtitle: controller.email,
                          imgWidget: Container(
                            decoration: BoxDecoration(border: Border.all(color: MyColor.getBorderColor(), width: 0.5), shape: BoxShape.circle),
                            height: 60,
                            width: 60,
                            child: const ClipOval(
                              child: MyNetworkImageWidget(
                                imageUrl: '',
                                boxFit: BoxFit.cover,
                                isProfile: true,
                              ),
                            ),
                          ),
                          imgHeight: 40,
                          imgWidth: 40,
                        ),
                      ),
                    );
                  }),
                  const CustomDivider(
                    space: Dimensions.space20,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(start: Dimensions.space15, top: Dimensions.space10, end: Dimensions.space15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerItem(
                          svgIcon: MyImages.usesPofile,
                          name: MyStrings.profile.tr,
                          onTap: () {
                            Get.toNamed(RouteHelper.profileScreen);
                          },
                        ),
                        const SizedBox(
                          height: Dimensions.space10,
                        ),
                        DrawerItem(
                          svgIcon: MyImages.policy,
                          name: MyStrings.privacyPolicy.tr,
                          onTap: () {
                            Get.toNamed(RouteHelper.privacyScreen);
                          },
                        ),
                        CustomDivider(
                          space: Dimensions.space20,
                        ),
                        1 == 1
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  DrawerItem(
                                    svgIcon: MyImages.language,
                                    name: MyStrings.language.tr,
                                    onTap: () {
                                      // Get.toNamed(RouteHelper.appPreferenceSettingScreen);
                                    },
                                  ),
                                  const SizedBox(
                                    height: Dimensions.space20,
                                  ),
                                ],
                              )
                            : const SizedBox.shrink(),
                        DrawerItem(
                          svgIcon: MyImages.addMoney,
                          name: MyStrings.deposit.tr,
                          onTap: () {
                            Get.toNamed(RouteHelper.newDepositScreenScreen);
                          },
                        ),
                        const SizedBox(height: Dimensions.space20),
                        CustomDivider(
                          space: Dimensions.space10,
                          color: MyColor.getBorderColor(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(SharedPreferenceService.getThemeIsLight() ? "Light Theme" : "Dark Theme", style: theme.textTheme.bodyLarge),
                            Builder(builder: (context) {
                              bool themeIsLight = SharedPreferenceService.getThemeIsLight();
                              return CustomSwitch(
                                value: !themeIsLight ? true : false,
                                onChanged: (v) {
                                  MyTheme.changeTheme();
                                },
                                child: themeIsLight
                                    ? const Icon(
                                        Icons.sunny,
                                        size: 14,
                                        color: Colors.amber,
                                      )
                                    : const Icon(
                                        Icons.dark_mode,
                                        size: 14,
                                      ),
                              );
                            }),
                          ],
                        ),
                        const SizedBox(
                          height: Dimensions.space30,
                        ),
                        DrawerItem(
                          svgIcon: MyImages.deleteAccount,
                          name: MyStrings.accountDelete.tr,
                          iconColor: MyColor.getErrorColor(),
                          titleStyle: theme.textTheme.labelMedium?.copyWith(
                            fontSize: Dimensions.fontLarge,
                            color: MyColor.getErrorColor(),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: Dimensions.space30,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  // onTap: () => widget.onDrawerItemTap(),
                  icon: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.close_rounded,
                      size: Dimensions.space25,
                      color: MyColor.getBodyTextColor(),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
