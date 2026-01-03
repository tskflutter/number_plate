import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

class ShowMoreText extends StatelessWidget {
  final String text;
  final Callback onTap;

  const ShowMoreText({super.key, required this.onTap, this.text = MyStrings.showMore});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text.tr,
        style: theme.textTheme.titleSmall?.copyWith(color: MyColor.getPrimaryColor(), decoration: TextDecoration.underline),
      ),
    );
  }
}
