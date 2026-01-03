import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class BottomSheetCloseButton extends StatelessWidget {
  const BottomSheetCloseButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: MyAssetImageWidget(
        assetPath: MyImages.close,
        isSvg: true,
        height: Dimensions.space24.h,
        width: Dimensions.space24.h,
      ),
    );
  }
}
