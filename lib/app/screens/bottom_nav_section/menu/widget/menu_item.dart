import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/image/custom_svg_picture.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class MenuItems extends StatelessWidget {
  final String imageSrc;
  final String label;
  final VoidCallback onPressed;
  final bool isSvgImage;

  const MenuItems({super.key, required this.imageSrc, required this.label, required this.onPressed, this.isSvgImage = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: Dimensions.space5, horizontal: Dimensions.space10),
        color: MyColor.getTransparentColor(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  isSvgImage ? CustomSvgPicture(image: imageSrc, color: MyColor.getPrimaryColor(), height: 17.5, width: 17.5) : Image.asset(imageSrc, height: 17.5, width: 17.5),
                  const SizedBox(width: Dimensions.space15),
                  Expanded(child: Text(label.tr, style: regularLarge.copyWith(color: MyColor.headingTextColor))),
                  MyAssetImageWidget(
                    assetPath: MyImages.menuArrow,
                    isSvg: true,
                    height: Dimensions.space14,
                    width: Dimensions.space14,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
