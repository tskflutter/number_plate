import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class TransactionLimitShimmer extends StatelessWidget {
  const TransactionLimitShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: MyColor.getBorderColor().withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(0)),
                  height: 5,
                  width: context.width / 6,
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
                      height: 5,
                      width: context.width / 6,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Shimmer.fromColors(
                    baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                    highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                    child: Container(
                      decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                      height: 5,
                      width: context.width / 6,
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
                  height: 5,
                  width: context.width / 6,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                baseColor: MyColor.getBorderColor().withValues(alpha: 0.2),
                highlightColor: MyColor.getPrimaryColor().withValues(alpha: 0.7),
                child: Container(
                  decoration: BoxDecoration(color: MyColor.getBorderColor().withValues(alpha: 0.2), borderRadius: BorderRadius.circular(1)),
                  height: 5,
                  width: context.width / 6,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
