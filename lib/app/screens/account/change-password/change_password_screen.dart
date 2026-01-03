import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

import 'package:ovolutter/data/controller/account/change_password_controller.dart';
import 'package:ovolutter/data/repo/account/change_password_repo.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/screens/account/change-password/widget/change_password_form.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    Get.put(ChangePasswordRepo());
    Get.put(ChangePasswordController(changePasswordRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ChangePasswordController>().clearData();
    });
  }

  @override
  void dispose() {
    Get.find<ChangePasswordController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.changePassword,
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MyStrings.createNewPassword.tr,
                style: boldOverLarge.copyWith(fontSize: Dimensions.space22, color: MyColor.headingTextColor),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Text(
                  MyStrings.createPasswordSubText.tr,
                  style: regularLarge.copyWith(color: MyColor.hintTextColor),
                ),
              ),
              const SizedBox(height: 24),
              CustomAppCard(radius: Dimensions.space16, child: const ChangePasswordForm())
            ],
          ),
        ),
      ),
    );
  }
}
