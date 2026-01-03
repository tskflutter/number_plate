import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class RoundedButton extends StatelessWidget {
  final bool isColorChange;
  final String text;
  final VoidCallback onPress;
  final Color color;
  final Color? textColor;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;
  final bool isOutlined;
  final Widget? child;
  final bool isLoading;

  const RoundedButton({
    super.key,
    this.isColorChange = false,
    this.width = 1,
    this.child,
    this.cornerRadius = 6,
    required this.text,
    required this.onPress,
    this.isOutlined = false,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.color = MyColor.black,
    this.textColor = MyColor.white,
    this.isLoading = false,
  });

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return child != null
        ? InkWell(
            onTap: onPress,
            splashColor: MyColor.getScaffoldBackgroundColor(),
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                width: size.width * width,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: isColorChange ? color : MyColor.getSecondaryColor()),
                child: Center(child: isLoading ? CustomLoader(loaderColor: textColor ?? theme.cardColor) : Text(text.tr, style: TextStyle(color: isColorChange ? textColor : MyColor.getBodyTextColor(), fontSize: 14, fontWeight: FontWeight.w500)))),
          )
        : isOutlined
            ? Material(
                child: InkWell(
                  onTap: onPress,
                  splashColor: MyColor.getScaffoldBackgroundColor(),
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
                      width: size.width * width,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(cornerRadius), color: isColorChange ? color : MyColor.getPrimaryColor()),
                      child: Center(child: isLoading ? CustomLoader(loaderColor: textColor ?? theme.cardColor) : Text(text.tr, style: TextStyle(color: isColorChange ? textColor : MyColor.getBodyTextColor(), fontSize: 14, fontWeight: FontWeight.w500)))),
                ),
              )
            : SizedBox(
                width: size.width * width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(cornerRadius),
                  child: ElevatedButton(
                    onPressed: onPress,
                    style: ElevatedButton.styleFrom(backgroundColor: color, shadowColor: MyColor.getTransparentColor(), padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding), textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500)),
                    child: isLoading
                        ? CustomLoader(loaderColor: textColor ?? theme.cardColor)
                        : Text(
                            text.tr,
                            style: TextStyle(color: textColor),
                          ),
                  ),
                ),
              );
  }
}
