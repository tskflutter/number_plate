import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final double borderRadius;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;

  const CustomDropdown({
    super.key,
    required this.hint,
    this.value,
    required this.items,
    this.onChanged,
    this.borderRadius = 12,
    this.backgroundColor = MyColor.white,
    this.textColor = MyColor.black,
    this.iconColor = MyColor.black,
    this.borderColor = MyColor.dropDownFieldBorder,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.space50.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: MyColor.black.withValues(alpha: .16),
            blurRadius: 4,
            offset: const Offset(0, 1.5),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: regularDefault.copyWith(color: MyColor.headingTextColor),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: iconColor,
            size: 24,
          ),
          isExpanded: true,
          padding: padding,
          borderRadius: BorderRadius.circular(borderRadius),
          dropdownColor: backgroundColor,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
