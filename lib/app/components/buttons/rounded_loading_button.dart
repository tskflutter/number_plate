import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class RoundedLoadingBtn extends StatelessWidget {
  final Color? textColor;
  final Color? color;
  final double width;
  final double horizontalPadding;
  final double verticalPadding;
  final double cornerRadius;

  const RoundedLoadingBtn({
    super.key,
    this.width = 1,
    this.cornerRadius = 6,
    this.horizontalPadding = 35,
    this.verticalPadding = 18,
    this.textColor = MyColor.white,
    this.color = MyColor.black,
  });

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shadowColor: MyColor.getTransparentColor(),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding - 3),
          textStyle: TextStyle(color: textColor, fontSize: 14, fontWeight: FontWeight.w500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(cornerRadius),
          ),
        ),
        child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: textColor, strokeWidth: 2)),
      ),
    );
  }
}
