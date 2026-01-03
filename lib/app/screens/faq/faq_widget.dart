import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/animated_widget/expanded_widget.dart';

import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class FaqListItem extends StatelessWidget {
  final String question;
  final String answer;
  final int index;
  final int selectedIndex;
  final VoidCallback press;

  const FaqListItem({super.key, required this.answer, required this.question, required this.index, required this.press, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: press,
      child: CustomAppCard(
        radius: Dimensions.space16,
        padding: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.space10, horizontal: Dimensions.space12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(question.tr, style: regularLarge.copyWith(color: MyColor.headingTextColor, fontFamily: 'poppins')),
                  ),
                  SizedBox(height: 30, width: 30, child: Icon(index == selectedIndex ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: MyColor.getAccent1Color(), size: 20))
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(color: MyColor.getBackgroundColor(), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(Dimensions.space16), bottomRight: Radius.circular(Dimensions.space16))),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space12),
              child: ExpandedSection(
                expand: index == selectedIndex,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.space10),
                    Text(
                      answer.tr,
                      style: regularLarge.copyWith(
                        color: MyColor.hintTextColor,
                      ),
                    ),
                    spaceDown(Dimensions.space10)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
