import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/style.dart';

import 'package:ovolutter/core/utils/util.dart';
import 'package:ovolutter/app/components/text/small_text.dart';

class LanguageCard extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final bool isShowTopRight;
  final String langeName;
  final String imagePath;

  const LanguageCard({super.key, required this.index, required this.selectedIndex, this.isShowTopRight = false, required this.langeName, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyNetworkImageWidget(
              imageUrl: imagePath,
              boxFit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
            const SizedBox(width: Dimensions.space10),
            Expanded(
              child: SmallText(
                text: langeName.tr,
                textStyle: regularLarge.copyWith(color: MyColor.getBodyTextColor()),
              ),
            ),
            MyAssetImageWidget(
              assetPath: index == selectedIndex ? MyImages.active : MyImages.inactive,
              isSvg: true,
              height: Dimensions.space20,
              width: Dimensions.space20,
            )
          ],
        ),
      ],
    );
  }
}
