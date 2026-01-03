import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class ActionButton extends StatefulWidget {
  final String image;
  final VoidCallback? ontap;

  final double? radius;
  const ActionButton({super.key, required this.image, this.radius = Dimensions.cardRadius, this.ontap});

  @override
  State<ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
        onPressed: widget.ontap,
        showShadow: false,
        radius: widget.radius ?? 0,
        borderColor: MyColor.plateBgColor,
        backgroundColor: MyColor.plateBgColor,
        padding: EdgeInsets.all(Dimensions.space8),
        child: MyAssetImageWidget(
          assetPath: widget.image,
          isSvg: true,
          height: Dimensions.space24.h,
          width: Dimensions.space24.h,
          boxFit: BoxFit.contain,
        ));
  }
}
