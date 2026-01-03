import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class NavBarItem extends StatelessWidget {
  final String imagePath;
  final int index;
  final String label;
  final VoidCallback press;
  final bool isSelected;

  const NavBarItem({super.key, required this.imagePath, required this.index, required this.label, required this.isSelected, required this.press});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(Dimensions.space10),
            alignment: Alignment.center,
            decoration: BoxDecoration(color: isSelected ? MyColor.getScaffoldBackgroundColor() : MyColor.getBorderColor().withValues(alpha: 0.2), shape: BoxShape.circle),
            child: imagePath.contains('svg')
                ? SvgPicture.asset(
                    imagePath,
                    colorFilter: ColorFilter.mode(
                      isSelected ? MyColor.getPrimaryColor() : MyColor.getAccent1Color(),
                      BlendMode.srcIn,
                    ),
                    width: 16,
                    height: 16,
                  )
                : Image.asset(
                    imagePath,
                    color: isSelected ? MyColor.getPrimaryColor() : MyColor.getAccent1Color(),
                    width: 16,
                    height: 16,
                  ),
          ),
          const SizedBox(height: Dimensions.space10 / 2),
          Text(label.tr, textAlign: TextAlign.center, style: theme.textTheme.bodySmall?.copyWith(color: isSelected ? MyColor.getPrimaryColor() : MyColor.getBodyTextColor()))
        ],
      ),
    );
  }
}
