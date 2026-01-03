import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class LoaderBoardCardShimmer extends StatelessWidget {
  const LoaderBoardCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(4)),
                  height: Dimensions.space10,
                  width: context.width / 3,
                ),
              ),
              Shimmer.fromColors(
                baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                child: Container(
                  decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(5)),
                  height: Dimensions.space10,
                  width: context.width / 2,
                ),
              ),
            ],
          ),
        ),
        Shimmer.fromColors(
          baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
          highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(100)),
            height: Dimensions.space40,
            width: Dimensions.space40,
          ),
        ),
      ],
    );
  }
}
