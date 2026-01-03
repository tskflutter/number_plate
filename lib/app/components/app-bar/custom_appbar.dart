import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_color.dart';

import 'package:ovolutter/app/components/dialog/exit_dialog.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool isShowBackBtn;
  final Color? bgColor;
  final bool isShowActionBtn;
  final bool isTitleCenter;
  final bool fromAuth;
  final bool isProfileCompleted;
  final List<Widget>? action;
  final VoidCallback? backButtonOnPress;

  const CustomAppBar({
    super.key,
    this.isProfileCompleted = false,
    this.fromAuth = false,
    this.isTitleCenter = false,
    this.bgColor,
    this.isShowBackBtn = true,
    required this.title,
    this.isShowActionBtn = false,
    this.action,
    this.backButtonOnPress,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size(double.maxFinite, 60);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool hasNotification = false;
  @override
  void initState() {
    //TODO
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return widget.isShowBackBtn
        ? AppBar(
            elevation: 3,
            shadowColor: MyColor.black.withValues(alpha: 0.1),
            titleSpacing: 0,
            surfaceTintColor: MyColor.getTransparentColor(),
            leading: widget.isShowBackBtn
                ? IconButton(
                    onPressed: () {
                      if (widget.backButtonOnPress == null) {
                        if (widget.fromAuth) {
                          Get.offAllNamed(RouteHelper.loginScreen);
                        } else if (widget.isProfileCompleted) {
                          showExitDialog(Get.context!, onConfirmTap: () {});
                        } else {
                          String previousRoute = Get.previousRoute;
                          if (previousRoute == '/splash-screen') {
                            Get.offAndToNamed(RouteHelper.bottomNavBar);
                          } else {
                            Get.back();
                          }
                        }
                      } else {
                        widget.backButtonOnPress!();
                      }
                    },
                    icon: Icon(Icons.arrow_back_ios_new, color: theme.appBarTheme.iconTheme?.color, size: 20))
                : const SizedBox.shrink(),
            backgroundColor: widget.bgColor ?? theme.appBarTheme.backgroundColor,
            title: Text(widget.title.tr),
            centerTitle: widget.isTitleCenter,
            actions: widget.action,
          )
        : AppBar(
            titleSpacing: 0,
            elevation: 0,
            surfaceTintColor: MyColor.getTransparentColor(),
            backgroundColor: widget.bgColor ?? MyColor.getBackgroundColor(),
            title: Text(widget.title.tr, style: theme.textTheme.labelLarge?.copyWith(color: MyColor.getBodyTextColor())),
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: MyColor.getPrimaryColor(),
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarColor: MyColor.getPrimaryColor(),
              systemNavigationBarIconBrightness: theme.brightness,
            ),
            actions: widget.action,
            automaticallyImplyLeading: false,
          );
  }
}
