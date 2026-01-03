import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';

class FormSizedBox extends StatelessWidget {
  const FormSizedBox({super.key});

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return const SizedBox(height: Dimensions.space20);
  }
}
