import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/home/views/widget/latest_transaction__bottom_sheet.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/data/controller/home/home_controller.dart';
import 'package:ovolutter/app/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/home/views/widget/latest_transaction_card.dart';

class LatestTransactionSection extends StatelessWidget {
  const LatestTransactionSection({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<HomeController>(
      builder: (controller) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space15),
        decoration: BoxDecoration(color: theme.cardColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  MyStrings.latestTransactions.tr,
                  style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor(), fontWeight: FontWeight.w500),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.transactionHistoryScreen);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    color: MyColor.getTransparentColor(),
                    padding: const EdgeInsets.all(Dimensions.space5),
                    child: Text(
                      MyStrings.seeAll.tr,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(color: MyColor.getPrimaryColor()),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: Dimensions.space20),
            /* controller.trxList.isEmpty ? const Center(
              child: NoDataWidget(margin: 12),
            ) :*/
            ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: 10 /*controller.trxList.length*/,
                itemBuilder: (context, index) {
                  return LatestTransactionCard(index: index, isShowDivider: /*controller.trxList.length-1!=index*/ true, press: () => CustomBottomSheet(child: LatestTransactionBottomSheet(index: index)).customBottomSheet(context));
                }),
          ],
        ),
      ),
    );
  }
}
