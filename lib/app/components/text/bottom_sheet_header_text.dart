import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetHeaderText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;

  const BottomSheetHeaderText({super.key, required this.text, this.textAlign});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Text(
      text.tr,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
