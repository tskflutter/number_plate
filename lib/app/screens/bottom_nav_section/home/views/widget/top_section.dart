import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../../../core/route/route.dart';
import '../../../../../../core/utils/dimensions.dart';
import '../../../../../../core/utils/my_color.dart';
import '../../../../../../core/utils/my_strings.dart';

import '../../../../../../data/controller/home/home_controller.dart';
import '../../../../edit_profile/widget/profile_image.dart';

PreferredSize homeScreenAppBar(BuildContext context, HomeController controller, GlobalKey<ScaffoldState> bottomNavScaffoldKey) {
  ThemeData theme = Theme.of(context);
  return PreferredSize(
    preferredSize: Size(MediaQuery.of(context).size.width, 80),
    child: Container(
      padding: const EdgeInsetsDirectional.only(top: 10, bottom: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).textTheme.titleLarge!.color!.withValues(alpha: 0.1),
            offset: const Offset(0, 2.0),
            blurRadius: 4.0,
          )
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        // systemOverlayStyle: MyUtils.systemUiOverlayStyle,
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        surfaceTintColor: MyColor.getTransparentColor(),
        title: IntrinsicWidth(
          child: Row(
            children: [
              if (controller.isLoading)
                Shimmer.fromColors(
                  baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                  highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                  child: Container(
                    decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(100)),
                    height: 40,
                    width: 40,
                  ),
                )
              else
                GestureDetector(
                  onTap: () => Get.toNamed(RouteHelper.profileScreen),
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: MyColor.getBorderColor(), width: 0.5), shape: BoxShape.circle),
                    height: 40,
                    width: 40,
                    child: ClipOval(
                      child: controller.imagePath == "null" || controller.imagePath == ""
                          ? ProfileWidget(imagePath: "", onClicked: () {})
                          : MyNetworkImageWidget(
                              imageUrl: controller.imagePath,
                              boxFit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
              const SizedBox(
                width: Dimensions.space10,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: Dimensions.space2 + 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.isLoading)
                        Shimmer.fromColors(
                          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                          child: Container(
                            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(100)),
                            width: Dimensions.space40 + 100,
                            height: Dimensions.fontLarge,
                          ),
                        )
                      else
                        Text(
                          controller.username,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: Dimensions.fontExtraLarge,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.titleLarge?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      const SizedBox(
                        height: Dimensions.space5,
                      ),
                      if (controller.isLoading)
                        Shimmer.fromColors(
                          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                          child: Container(
                            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(100)),
                            width: Dimensions.space40 + 50,
                            height: Dimensions.fontExtraLarge,
                          ),
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ///Button
                            Material(
                              type: MaterialType.canvas,
                              color: MyColor.getBorderColor().withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(50),
                              child: InkWell(
                                splashColor: MyColor.getPrimaryColor().withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(50),
                                onTap: () {
                                  controller.changeState();
                                },
                                child: Obx(
                                  () => Container(
                                    width: 170,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      // color: MyColor.transparent,
                                      color: MyColor.getPrimaryColor().withValues(alpha: 0.02),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedOpacity(
                                          opacity: controller.isBalanceShown.value ? 1 : 0,
                                          duration: const Duration(milliseconds: 500),
                                          child: FittedBox(
                                            child: Text(
                                              "65565",
                                              style: TextStyle(color: MyColor.getPrimaryColor(), fontSize: Dimensions.fontLarge),
                                            ),
                                          ),
                                        ),

                                        /// tapForBalance
                                        AnimatedPositioned(
                                          duration: const Duration(milliseconds: 300),
                                          left: controller.isAnimation.value == false ? 22 : 12,
                                          child: AnimatedOpacity(
                                            opacity: controller.isBalance.value ? 1 : 0,
                                            duration: const Duration(milliseconds: 300),
                                            child: FittedBox(
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional.only(start: 10),
                                                child: Text(
                                                  MyStrings.tapForBalance.tr,
                                                  style: TextStyle(color: MyColor.getPrimaryColor().withValues(alpha: 0.8), fontSize: Dimensions.fontLarge),
                                                  maxLines: 1,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        /// Circle
                                        AnimatedPositioned(
                                          duration: const Duration(milliseconds: 1100),
                                          left: controller.isAnimation.value == false ? 2 : 145,
                                          curve: Curves.fastOutSlowIn,
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(color: MyColor.getPrimaryColor().withValues(alpha: 0.8), borderRadius: BorderRadius.circular(50)),
                                            child: FittedBox(
                                              child: Text(
                                                controller.defaultCurrencySymbol,
                                                style: TextStyle(color: MyColor.getBodyTextColor(), fontSize: Dimensions.fontLarge),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                bottomNavScaffoldKey.currentState!.openDrawer();
              },
              icon: Icon(
                Icons.menu,
                color: MyColor.getAccent1Color(),
              ))
        ],
      ),
    ),
  );
}
