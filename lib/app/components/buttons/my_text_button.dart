import 'package:flutter/material.dart';

import '../../../core/utils/my_color.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final TextStyle? style;
  final double padding;

  const CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.style,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
        // splashFactory: InkRipple.splashFactory,
        surfaceTintColor: MyColor.getPrimaryColor(),
        shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.all(padding),
        enableFeedback: false,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      onPressed: onTap,
      child: Text(text, maxLines: 2, overflow: TextOverflow.ellipsis, style: style ?? theme.textTheme.labelLarge?.copyWith(color: MyColor.getPrimaryColor())),
    );
  }
}
