import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/data/model/kyc/kyc_response_model.dart' as kyc;
import 'package:ovolutter/app/components/custom_drop_down_button_with_text_field.dart';
import 'package:ovolutter/app/components/text/label_text_with_instructions.dart';
import 'package:get/get.dart';

class KycSelectSection extends StatelessWidget {
  kyc.KycFormModel model;
  Function onChanged;
  KycSelectSection({
    super.key,
    required this.model,
    required this.onChanged,
  });

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTextInstruction(
          text: (model.name ?? '').tr.capitalize!,
          isRequired: model.isRequired == 'optional' ? false : true,
          instructions: model.instruction,
        ),
        const SizedBox(height: Dimensions.textToTextSpace),
        CustomDropDownWithTextField(
          borderWidth: .5,
          list: model.options ?? [],
          onChanged: (value) => onChanged(value),
          selectedValue: model.selectedValue,
        ),
        const SizedBox(height: Dimensions.space10)
      ],
    );
  }
}
