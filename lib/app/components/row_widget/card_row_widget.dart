import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class CardRow extends StatelessWidget {
  final String header;
  final String body;
  final bool alignmentEnd;

  const CardRow({super.key, this.alignmentEnd = false, required this.header, required this.body});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          header.tr,
          style: theme.textTheme.bodySmall?.copyWith(color: MyColor.getBodyTextColor().withValues(alpha: 0.6)),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: Dimensions.space5),
        Text(body.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor(), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
      ],
    );
  }
}
