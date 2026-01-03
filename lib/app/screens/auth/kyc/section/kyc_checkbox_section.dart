import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/data/model/kyc/kyc_response_model.dart' as kyc;
import 'package:ovolutter/app/components/checkbox/custom_check_box.dart';
import 'package:ovolutter/app/components/text/label_text_with_instructions.dart';
import 'package:get/get.dart';

class KycCheckBoxSection extends StatelessWidget {
  kyc.KycFormModel model;
  Function onChanged;
  List<String>? selectedValue;
  KycCheckBoxSection({
    super.key,
    required this.model,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextInstruction(text: (model.name ?? '').tr.capitalize!, isRequired: model.isRequired == 'optional' ? false : true, instructions: model.instruction),
        CustomCheckBox(
          selectedValue: selectedValue,
          list: model.options ?? [],
          onChanged: (value) => onChanged(value),
        ),
        const SizedBox(height: Dimensions.space10),
      ],
    );
  }
}
