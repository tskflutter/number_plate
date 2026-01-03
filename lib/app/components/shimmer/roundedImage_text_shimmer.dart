import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class RoundedWidgetTextShimmer extends StatelessWidget {
  const RoundedWidgetTextShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
            width: 65,
            height: 60,
          ),
        ),
        const SizedBox(height: Dimensions.space5),
        Shimmer.fromColors(
          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
            width: 60,
            height: 10,
          ),
        ),
      ],
    );
  }
}
