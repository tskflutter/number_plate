import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/my_color.dart';

class FormRow extends StatelessWidget {
  final String label;
  final bool isRequired;

  const FormRow({super.key, required this.label, required this.isRequired});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [Text(label.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.black)), Text(isRequired ? ' *' : '', style: theme.textTheme.titleSmall?.copyWith(color: MyColor.getErrorColor()))],
    );
  }
}
