import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/app/components/image/custom_svg_picture.dart';
import 'package:get/get.dart';

class DrawerItem extends StatelessWidget {
  String svgIcon, name;
  Color? iconColor;
  TextStyle? titleStyle;
  VoidCallback onTap;
  DrawerItem({super.key, required this.svgIcon, required this.name, required this.onTap, this.iconColor, this.titleStyle});

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              svgIcon.contains('.svg')
                  ? CustomSvgPicture(
                      image: svgIcon,
                      color: iconColor ?? theme.primaryColor,
                      height: 20,
                    )
                  : Image.asset(
                      svgIcon,
                      color: iconColor ??  theme.primaryColor,
                      height: 20,
                    ),
              const SizedBox(
                width: Dimensions.space8,
              ),
              Text(
                name.tr,
                style: titleStyle ??  theme.textTheme.titleSmall,
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}
