import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/model/kyc/kyc_response_model.dart' as kyc;
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:get/get.dart';

class KycDateTimeSection extends StatelessWidget {
  kyc.KycFormModel model;
  Function onChanged;
  Function onTap;
  TextEditingController? controller;
  KycDateTimeSection({
    super.key,
    required this.model,
    required this.onTap,
    required this.onChanged,
    this.controller,
  });

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      children: [
        CustomTextField(
          instructions: model.instruction,
          isRequired: model.isRequired == 'optional' ? false : true,
          hintText: (model.name ?? '').toString().capitalizeFirst,
          needOutlineBorder: true,
          labelText: (model.name ?? '').tr.capitalize,
          controller: controller,
          textInputType: TextInputType.datetime,
          readOnly: true,
          validator: (value) {
            printX(model.isRequired);
            if (model.isRequired != 'optional' && value.toString().isEmpty) {
              return '${model.name.toString().capitalizeFirst} ${MyStrings.isRequired}';
            } else {
              return null;
            }
          },
          onTap: () {
            onTap();
          },
          onChanged: (value) => onChanged(value),
        ),
        const SizedBox(height: Dimensions.space10),
      ],
    );
  }
}
