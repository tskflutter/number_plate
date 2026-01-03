import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';

class OTPFieldWidget extends StatelessWidget {
  const OTPFieldWidget({super.key, required this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor()),
      length: 6,
      textStyle: regularLarge.copyWith(color: MyColor.getBodyTextColor()),
      obscureText: false,
      obscuringCharacter: '*',
      blinkWhenObscuring: false,
      hintCharacter: '0',
      animationType: AnimationType.fade,
      pinTheme: PinTheme(shape: PinCodeFieldShape.box, borderWidth: 1, borderRadius: BorderRadius.circular(6), fieldHeight: 40, fieldWidth: 40, inactiveColor: MyColor.getBorderColor(), inactiveFillColor: MyColor.white, activeFillColor: MyColor.white, activeColor: MyColor.getPrimaryColor(), selectedFillColor: MyColor.getScaffoldBackgroundColor(), selectedColor: MyColor.getPrimaryColor()),
      cursorColor: MyColor.black,
      animationDuration: const Duration(milliseconds: 100),
      enableActiveFill: true,
      keyboardType: TextInputType.number,
      beforeTextPaste: (text) {
        return true;
      },
      separatorBuilder: (context, index) {
        if (index == 2) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.space8),
            child: Text(
              '-',
              style: boldDefault.copyWith(color: MyColor.hintTextColor, fontSize: 18),
            ),
          );
        }
        return const SizedBox(width: Dimensions.space4);
      },
      onChanged: (value) => onChanged!(value),
    );
  }
}
