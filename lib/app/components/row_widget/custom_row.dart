import 'package:flutter/material.dart';
import 'package:ovolutter/app/screens/withdraw/widget/status_widget.dart';

import 'package:get/get.dart';

import '../../../core/utils/my_color.dart';
import '../divider/custom_divider.dart';

class CustomRow extends StatelessWidget {
  final String firstText, lastText;
  final bool isStatus, isAbout, showDivider;
  final Color? statusTextColor;
  final bool hasChild;
  final Widget? child;

  const CustomRow({super.key, this.child, this.hasChild = false, this.statusTextColor, required this.firstText, required this.lastText, this.isStatus = false, this.isAbout = false, this.showDivider = true});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return hasChild
        ? Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                      child: Text(
                    firstText.tr,
                    style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )),
                  child ?? const SizedBox(),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              showDivider
                  ? Divider(
                      color: MyColor.getBorderColor(),
                    )
                  : const SizedBox(),
              showDivider
                  ? const SizedBox(
                      height: 5,
                    )
                  : const SizedBox(),
            ],
          )
        : isAbout
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(firstText.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getHeadingTextColor())),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    lastText.tr,
                    style: theme.textTheme.labelMedium?.copyWith(color: isStatus ? statusTextColor : MyColor.getBodyTextColor()),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              )
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        firstText.tr,
                        style: theme.textTheme.labelLarge?.copyWith(color: MyColor.getHeadingTextColor(), fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                      isStatus
                          ? StatusWidget(
                              status: lastText,
                              color: MyColor.getBodyTextColor(),
                            )
                          : Flexible(
                              child: Text(
                              lastText.tr,
                              maxLines: 2,
                              style: theme.textTheme.labelLarge?.copyWith(color: isStatus ? MyColor.getSuccessColor() : MyColor.getBodyTextColor(), fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ))
                    ],
                  ),
                  const SizedBox(height: 5),
                  showDivider ? const CustomDivider() : const SizedBox(),
                  showDivider
                      ? const SizedBox(
                          height: 5,
                        )
                      : const SizedBox(),
                ],
              );
  }
}
