import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/controller/account/change_password_controller.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';

class ChangePasswordForm extends StatefulWidget {
  const ChangePasswordForm({super.key});

  @override
  State<ChangePasswordForm> createState() => _ChangePasswordFormState();
}

class _ChangePasswordFormState extends State<ChangePasswordForm> {
  final formKey = GlobalKey<FormState>();

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<ChangePasswordController>(
        builder: (controller) => Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.currentPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return MyStrings.enterCurrentPass.tr;
                      } else {
                        return null;
                      }
                    },
                    controller: controller.currentPassController,
                    isShowSuffixIcon: true,
                    isPassword: true,
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.newPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return MyStrings.enterNewPass.tr;
                      } else {
                        return null;
                      }
                    },
                    controller: controller.passController,
                    isShowSuffixIcon: true,
                    isPassword: true,
                  ),
                  const SizedBox(height: Dimensions.space20),
                  CustomTextField(
                    animatedLabel: true,
                    needOutlineBorder: true,
                    labelText: MyStrings.confirmPassword.tr,
                    onChanged: (value) {
                      return;
                    },
                    validator: (value) {
                      if (controller.confirmPassController.text != controller.passController.text) {
                        return MyStrings.kMatchPassError.tr;
                      } else {
                        return null;
                      }
                    },
                    controller: controller.confirmPassController,
                    isShowSuffixIcon: true,
                    isPassword: true,
                  ),
                  const SizedBox(height: Dimensions.space25),
                  CustomElevatedBtn(
                      text: MyStrings.submit,
                      isLoading: controller.submitLoading,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.changePassword();
                        }
                      })
                ],
              ),
            ));
  }
}
