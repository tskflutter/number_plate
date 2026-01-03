import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:ovolutter/app/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/app/components/text/bottom_sheet_header_text.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/ads/view/my_ads_screen.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/home/views/home_screen.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/menu/menu_screen.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/watchlist/view/watchlist_screen.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

final GlobalKey<_BottomNavBarState> bottomNavKey = GlobalKey<_BottomNavBarState>();

class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;
  String token = SharedPreferenceService.getAccessToken();

  void changeTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      const WatchlistScreen(),
      const MyAdsScreen(),
      const MenuScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopWidget(
      child: Scaffold(
        body: _buildScreens()[currentIndex],
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // if (token != "") {
            CustomBottomSheet(isNeedMargin: false, isNeedpadding: false, child: bottomCard()).customBottomSheet(context);
            // } else {
            //   CustomSnackBar.error(errorList: [MyStrings.toAddPlateKindlyLoginFirst.tr]);
            // }
          },
          backgroundColor: MyColor.getPrimaryColor(),
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 28,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Stack(
          children: [
            BottomAppBar(
              padding: EdgeInsets.zero,
              height: 85,
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              notchMargin: 6,
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side items
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _NavBarItem(
                            imagePath: currentIndex == 0 ? MyImages.bottomHomeActive : MyImages.bottomHome,
                            label: MyStrings.home,
                            isSelected: currentIndex == 0,
                            onTap: () => _onItemTapped(0),
                          ),
                          _NavBarItem(
                            imagePath: currentIndex == 1 ? MyImages.watchlistActive : MyImages.watchlist,
                            label: MyStrings.watchList,
                            isSelected: currentIndex == 1,
                            onTap: () => _onItemTapped(1),
                          ),
                        ],
                      ),
                    ),
                    // Spacer for FAB
                    const SizedBox(width: 60),
                    // Right side items
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _NavBarItem(
                            imagePath: currentIndex == 2 ? MyImages.adsActive : MyImages.ads,
                            label: MyStrings.ads,
                            isSelected: currentIndex == 2,
                            onTap: () => _onItemTapped(2),
                          ),
                          _NavBarItem(
                            imagePath: currentIndex == 3 ? MyImages.bottomProfileActive : MyImages.bottomProfile,
                            label: MyStrings.profile,
                            isSelected: currentIndex == 3,
                            onTap: () => _onItemTapped(3),
                          ),
                        ],
                      ),
                    ),
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

Widget bottomCard() {
  return Column(
    children: [
      Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space12.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [BottomSheetHeaderText(text: MyStrings.add.tr), BottomSheetCloseButton()],
        ),
      ),
      Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space5.h),
        decoration: BoxDecoration(color: MyColor.lightBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: AlignmentGeometry.center,
                child: MyAssetImageWidget(
                  assetPath: MyImages.addPlate,
                  height: Dimensions.space160.h,
                  width: Dimensions.space240,
                )),
            spaceDown(Dimensions.space16),
            Text(
              MyStrings.addYourPlateForSell.tr,
              style: regularLarge.copyWith(fontFamily: 'poppins'),
            ),
            spaceDown(Dimensions.space20),
            CardButton(
              showShadow: false,
              bgColor: MyColor.white,
              text: MyStrings.requestPlate,
              textColor: MyColor.black,
              press: () {
                Get.toNamed(RouteHelper.listPlateScreen, arguments: [true]);
              },
              showBorder: false,
              borderColor: MyColor.transparent,
              icon: "",
            ),
            spaceDown(Dimensions.space16),
            CardButton(
              text: MyStrings.addPlate,
              press: () {
                Get.toNamed(RouteHelper.listPlateScreen, arguments: [false]);
              },
              borderColor: MyColor.blackColorShadow,
              icon: "",
            ),
            spaceDown(Dimensions.space12),
          ],
        ),
      ),
      spaceDown(Dimensions.space35)
    ],
  );
}

class _NavBarItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.imagePath,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? MyColor.getPrimaryColor() : Colors.grey;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3,
            width: 30,
            decoration: BoxDecoration(
              color: isSelected ? MyColor.getPrimaryColor() : Colors.transparent,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.space100), bottomRight: Radius.circular(Dimensions.space100)),
            ),
          ),

          spaceDown(Dimensions.space12),

          imagePath.contains('svg')
              ? SvgPicture.asset(
                  imagePath,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  width: 22,
                  height: 22,
                )
              : Image.asset(
                  imagePath,
                  color: color,
                  width: 22,
                  height: 22,
                ),

          const SizedBox(height: 4),

          /// Label
          Text(
            label.tr,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
