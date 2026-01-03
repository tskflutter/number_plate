import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final int maxLines;
  final Color? textColor;
  final double fontSize;

  const DefaultText({super.key, required this.text, this.textAlign, this.textStyle, this.maxLines = 3, this.textColor, this.fontSize = Dimensions.fontDefault});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: textStyle?.copyWith(color: textColor, fontSize: fontSize),
      maxLines: maxLines,
    );
  }
}
