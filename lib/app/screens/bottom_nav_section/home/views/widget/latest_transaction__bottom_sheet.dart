import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/controller/home/home_controller.dart';
import 'package:ovolutter/app/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:ovolutter/app/components/column_widget/card_column.dart';
import 'package:ovolutter/app/components/divider/custom_divider.dart';
import 'package:ovolutter/app/components/text/bottom_sheet_header_text.dart';

class LatestTransactionBottomSheet extends StatelessWidget {
  final int index;
  const LatestTransactionBottomSheet({super.key, required this.index});

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<HomeController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [BottomSheetHeaderText(text: MyStrings.details), BottomSheetCloseButton()],
          ),
          const CustomDivider(space: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.transactionId,
                body: "",
              ),
              CardColumn(
                alignmentEnd: true,
                header: MyStrings.wallet,
                body: "",
              )
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.beforeCharge,
                body: "",
              ),
              CardColumn(alignmentEnd: true, header: MyStrings.charge, body: "")
            ],
          ),
          const SizedBox(height: Dimensions.space15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CardColumn(
                header: MyStrings.remainingBalance,
                body: "",
              ),
            ],
          )
        ],
      ),
    );
  }
}
