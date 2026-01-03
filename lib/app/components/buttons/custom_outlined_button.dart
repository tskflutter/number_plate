import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';

class CustomOutlinedBtn extends StatelessWidget {
  final String btnText;
  final void Function() onTap;
  final double radius;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double width;
  final double height;
  final double borderWidth;
  final Widget? icon;
  final TextStyle? textStyle;
  final bool isLoading;

  const CustomOutlinedBtn({
    super.key,
    required this.btnText,
    required this.onTap,
    this.radius = Dimensions.cardRadius,
    this.bgColor = MyColor.lightTextFieldBackground,
    this.borderColor = MyColor.lightTextFieldBorder,
    this.textColor = MyColor.headingTextColor,
    this.width = double.infinity,
    this.height = Dimensions.defaultButtonH,
    this.icon,
    this.textStyle,
    this.isLoading = false,
    this.borderWidth = .5,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return icon != null
        ? OutlinedButton.icon(
            onPressed: () {
              if (isLoading == false) {
                onTap();
              }
            },
            style: OutlinedButton.styleFrom(
              elevation: 0, //
              backgroundColor: bgColor,
              surfaceTintColor: MyColor.getPrimaryColor().withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
              maximumSize: Size.fromHeight(height),
              minimumSize: Size(width, height),
              side: BorderSide(color: borderColor, width: borderWidth),
              splashFactory: InkRipple.splashFactory,
            ),
            icon: isLoading ? const SizedBox.shrink() : icon ?? const SizedBox.shrink(),
            label: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                  )
                : Text(
                    btnText, //
                    style: textStyle ?? theme.textTheme.titleSmall?.copyWith(color: textColor),
                  ),
          )
        : OutlinedButton(
            onPressed: () {
              if (isLoading == false) {
                onTap();
              }
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: bgColor,
              elevation: 0, //
              surfaceTintColor: MyColor.getPrimaryColor().withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
              maximumSize: Size.fromHeight(height),
              minimumSize: Size(width, height),
              side: BorderSide(color: borderColor, width: borderWidth),
              splashFactory: InkRipple.splashFactory,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: MyColor.getPrimaryColor()),
                  )
                : Text(
                    btnText, //
                    style: textStyle ?? regularDefault.copyWith(color: textColor, fontWeight: FontWeight.w600),
                  ),
          );
  }
}
