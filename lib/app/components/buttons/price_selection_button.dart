import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class PriceSelectionButton extends StatefulWidget {
  final bool isActive;
  final String text;
  final Gradient? gradient;
  final Widget? prefixIcon;
  final VoidCallback onTap;
  const PriceSelectionButton({super.key, required this.isActive, required this.text, required this.onTap, this.gradient, this.prefixIcon});

  @override
  State<PriceSelectionButton> createState() => _PriceSelectionButtonState();
}

class _PriceSelectionButtonState extends State<PriceSelectionButton> {
  @override
  Widget build(BuildContext context) {
    return CustomAppCard(
      showShadow: false,
      onPressed: widget.onTap,
      borderColor: widget.isActive ? MyColor.headingTextColor : MyColor.cardInactiveBorderColor,
      gradient: widget.gradient ??
          LinearGradient(
            colors: MyColor.priceCard,
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
      useGradient: true,
      radius: Dimensions.cardRadius,
      padding: EdgeInsetsDirectional.symmetric(vertical: Dimensions.space12.h, horizontal: Dimensions.space16.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.prefixIcon ?? SizedBox.shrink(),
          spaceSide(Dimensions.space8),
          Expanded(
            child: Text(
              widget.text.tr,
              style: regularLarge.copyWith(
                color: MyColor.headingTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          spaceSide(Dimensions.space5),
          MyAssetImageWidget(
            assetPath: widget.isActive ? MyImages.active : MyImages.inActive,
            isSvg: true,
            height: Dimensions.space20.h,
            width: Dimensions.space20.h,
          )
        ],
      ),
    );
  }
}
