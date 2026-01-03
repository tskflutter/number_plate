import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class MainItemShimmer extends StatelessWidget {
  const MainItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
          child: Container(
            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
            height: 100,
            width: 100,
          ),
        ),
      ],
    );
  }
}
