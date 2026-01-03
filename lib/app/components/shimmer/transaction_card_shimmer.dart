import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class TransactionCardShimmer extends StatelessWidget {
  const TransactionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double width = context.width / 6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Shimmer.fromColors(
              baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
              highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(50)),
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                  highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                  child: Container(
                    decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                    height: 10,
                    width: width * 1.5,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Shimmer.fromColors(
                  baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                  highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                  child: Container(
                    decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                    height: 7,
                    width: width * 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Shimmer.fromColors(
              baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
              highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
              child: Container(
                decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                height: 7,
                width: width * 1.5,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Shimmer.fromColors(
              baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
              highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
              child: Container(
                decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                height: 7,
                width: width * 1.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
