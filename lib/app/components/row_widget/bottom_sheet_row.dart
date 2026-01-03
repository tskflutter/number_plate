import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class BottomSheetRow extends StatelessWidget {
  final String header;
  final String body;
  final String? currencySymbol;
  final bool showSymbol;
  final Color curBgColor;

  const BottomSheetRow({super.key, required this.header, required this.body, this.showSymbol = false, this.curBgColor = MyColor.black, this.currencySymbol});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return showSymbol
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(color: curBgColor, shape: BoxShape.circle),
                    child: Text(currencySymbol!, textAlign: TextAlign.center, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.white)),
                  ),
                  const SizedBox(width: Dimensions.space10),
                  Text(
                    header.tr,
                    style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor().withValues(alpha: 0.6)),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Text(body.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor(), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis)
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  flex: 3,
                  child: Text(
                    header.tr,
                    style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor().withValues(alpha: 0.6)),
                    overflow: TextOverflow.ellipsis,
                  )),
              Expanded(flex: 4, child: Text(body.tr, maxLines: 2, textAlign: TextAlign.end, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor(), fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis))
            ],
          );
  }
}
