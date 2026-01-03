import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';

class InfoItem extends StatelessWidget {
  final String firstText, lastText;
  final String icon;
  final bool isShowDivider;

  const InfoItem({super.key, required this.firstText, required this.lastText, required this.icon, this.isShowDivider = true});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.space10, top: Dimensions.space10),
          child: Row(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(Dimensions.space5),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: MyColor.getBackgroundColor(), shape: BoxShape.circle),
                child: SvgPicture.asset(icon, color: MyColor.getPrimaryColor(), height: 20, width: 20),
              ),
              const SizedBox(width: Dimensions.space10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor())),
                  Text(lastText.tr, style: theme.textTheme.bodySmall?.copyWith(color: MyColor.getBodyTextColor())),
                ],
              )
            ],
          ),
        ),
        Visibility(visible: isShowDivider, child: Divider(color: MyColor.getBorderColor(), height: 0.5, thickness: 1))
      ],
    );
  }
}
