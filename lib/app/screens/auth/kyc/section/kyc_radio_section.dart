import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/data/model/kyc/kyc_response_model.dart' as kyc;
import 'package:ovolutter/app/components/custom_radio_button.dart';
import 'package:ovolutter/app/components/text/label_text_with_instructions.dart';
import 'package:get/get.dart';

class KycRadioSection extends StatelessWidget {
  kyc.KycFormModel model;
  Function onChanged;
  int selectedIndex;
  KycRadioSection({
    super.key,
    required this.model,
    required this.onChanged,
    required this.selectedIndex,
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
        CustomRadioButton(
          title: model.name,
          selectedIndex: selectedIndex,
          list: model.options ?? [],
          onChanged: (index) => onChanged(index),
        ),
        const SizedBox(height: Dimensions.space10),
      ],
    );
  }
}
