import 'package:flutter/material.dart';

import '../../../../../core/utils/dimensions.dart';

class MenuCardWidget extends StatelessWidget {
  final Widget child;
  final double marginBottom;

  const MenuCardWidget(
      {super.key, required this.child, this.marginBottom = 10});

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: marginBottom),
        padding: const EdgeInsets.symmetric(
            vertical: Dimensions.space15, horizontal: Dimensions.space15),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child);
  }
}
