import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/components/text-field/label_text_field.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/screens/auth/registration/widget/validation_widget.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/app_style.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/data/controller/auth/auth/registration_controller.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<RegistrationController>(
      builder: (controller) {
        return Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller.fNameController,
                      onChanged: () {},
                      focusNode: controller.firstNameFocusNode,
                      labelText: MyStrings.firstName.toTitleCase().tr,
                      hintText: MyStrings.firstNameHint.tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return MyStrings.enterYourFirstName.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  spaceSide(Dimensions.space16),
                  Expanded(
                    child: CustomTextField(
                      controller: controller.lNameController,
                      onChanged: () {},
                      focusNode: controller.lastNameFocusNode,
                      labelText: MyStrings.lastName.toTitleCase().tr,
                      hintText: MyStrings.lastNameHint.tr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return MyStrings.enterYourLastName.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              spaceDown(Dimensions.space16),
              CustomTextField(
                controller: controller.emailController,
                onChanged: () {},
                labelText: MyStrings.enterYourEmail.toTitleCase().tr,
                hintText: MyStrings.emailHint.tr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return MyStrings.fieldErrorMsg.tr;
                  } else {
                    return null;
                  }
                },
              ),
              spaceDown(Dimensions.space16),
              Focus(
                onFocusChange: (hasFocus) {
                  controller.changePasswordFocus(hasFocus);
                },
                child: CustomTextField(
                  labelText: MyStrings.password.tr,
                  controller: controller.passwordController,
                  focusNode: controller.passwordFocusNode,
                  hintText: MyStrings.passwordHint,
                  isPassword: true,
                  isShowSuffixIcon: true,
                  onChanged: (value) {
                    if (controller.checkPasswordStrength) {
                      controller.updateValidationList(value);
                    }
                  },
                  validator: (value) {
                    return controller.validatePassword(value ?? '');
                  },
                ),
              ),
              const SizedBox(height: Dimensions.textToTextSpace),
              Visibility(
                visible: controller.hasPasswordFocus && controller.checkPasswordStrength,
                child: ValidationWidget(
                  list: controller.passwordValidationRules,
                ),
              ),
              const SizedBox(height: Dimensions.space10),
              CustomTextField(
                onChanged: () {},
                labelText: MyStrings.confirmPassword.tr,
                controller: controller.cPasswordController,
                focusNode: controller.confirmPasswordFocusNode,
                hintText: MyStrings.passwordHint,
                isPassword: true,
                isShowSuffixIcon: true,
                validator: (value) {
                  if (controller.passwordController.text.toLowerCase() != controller.cPasswordController.text.toLowerCase()) {
                    return MyStrings.kMatchPassError.tr;
                  } else {
                    return null;
                  }
                },
              ),
              spaceDown(Dimensions.space16),
              Visibility(
                  visible: controller.needAgree,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Checkbox(
                          shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.space8)),
                          overlayColor: WidgetStatePropertyAll(MyColor.getPrimaryColor()),
                          splashRadius: 4,
                          activeColor: MyColor.darkInformation,
                          checkColor: MyColor.white,
                          value: controller.agreeTC,
                          side: WidgetStateBorderSide.resolveWith(
                            (states) => BorderSide(width: 1.0, color: controller.agreeTC ? MyColor.getBorderColor() : MyColor.getBorderColor()),
                          ),
                          onChanged: (bool? value) {
                            controller.updateAgreeTC();
                          },
                        ),
                      ),
                      const SizedBox(width: Dimensions.space8),
                      Row(
                        children: [
                          Text(MyStrings.iAgreeWith.tr, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor())),
                          const SizedBox(width: Dimensions.space3),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(RouteHelper.privacyScreen);
                            },
                            child: Text(MyStrings.policies.tr.toLowerCase(), style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getPrimaryColor(), decoration: TextDecoration.underline, decorationColor: MyColor.getPrimaryColor())),
                          ),
                          const SizedBox(width: Dimensions.space3),
                        ],
                      ),
                    ],
                  )),
              spaceDown(Dimensions.space16),
              CustomElevatedBtn(
                isLoading: controller.submitLoading,
                text: MyStrings.register.tr,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    controller.signUpUser();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
