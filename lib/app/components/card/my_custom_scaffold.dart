import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/annotated_region/annotated_region_widget.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';

import '../../../core/utils/util_exporter.dart';

class MyCustomScaffold extends StatelessWidget {
  const MyCustomScaffold({super.key, this.pageTitle = "PageTitle", this.actionButton, this.showAppBar = true, this.body, this.appBarBgColor, this.screenBgColor = MyColor.lightBackground, this.padding, this.demo = false, this.onBackButtonTap, this.floatingActionButton, this.centerTitle = false, this.showBackButton = true, this.bottomNav});
  final String? pageTitle;
  final List<Widget>? actionButton;
  final Widget? body;
  final Widget? bottomNav;
  final Color? appBarBgColor;
  final Color? screenBgColor;
  final EdgeInsetsGeometry? padding;
  final bool demo;
  final bool? showBackButton;
  final bool centerTitle;
  final bool showAppBar;
  final VoidCallback? onBackButtonTap;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return AnnotatedRegionWidget(
      statusBarColor: appBarBgColor ?? MyColor.white,
      systemNavigationBarColor: appBarBgColor ?? MyColor.white,
      child: Scaffold(
        backgroundColor: screenBgColor ?? theme.scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0.h), // here the desired height(

          child: showAppBar
              ? AppBar(
                  elevation: 4,
                  toolbarHeight: 100,
                  surfaceTintColor: MyColor.transparent,
                  centerTitle: centerTitle,
                  backgroundColor: appBarBgColor ?? MyColor.white,
                  leading: showBackButton == true
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: IconButton(
                            onPressed: () {
                              if (onBackButtonTap != null) {
                                onBackButtonTap!();
                              } else {
                                Get.back();
                              }
                            },
                            icon: FittedBox(fit: BoxFit.fitHeight, child: Icon(Icons.arrow_back_rounded)),
                          ),
                        )
                      : SizedBox.shrink(),
                  titleSpacing: 5,
                  title: Text(
                    "$pageTitle",
                    style: theme.appBarTheme.titleTextStyle,
                  ),
                  actions: [
                    if (actionButton != null) ...[
                      ...actionButton!,
                    ],

                    //TODO Text Button
                    if (demo == true && actionButton == null)
                      TextButton(
                        style: TextButton.styleFrom(
                          overlayColor: MyColor.getPrimaryColor(), // Text color
                          textStyle: TextStyle(
                            fontSize: Dimensions.fontLarge,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: MyColor.getPrimaryColor(),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Demo Skip Button",
                          style: theme.textTheme.bodyMedium,
                        ),
                      )
                  ],
                )
              : SizedBox(),
        ),
        body: Padding(
          padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space16.w),
          child: body,
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNav,
      ),
    );
  }
}
