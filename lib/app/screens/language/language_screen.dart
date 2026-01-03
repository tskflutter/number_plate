import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

import 'package:ovolutter/data/controller/my_language_controller/my_language_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/no_data.dart';
import 'package:ovolutter/app/screens/language/widget/language_card.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String comeFrom = '';

  @override
  void initState() {
    Get.put(GeneralSettingRepo());
    final controller = Get.put(MyLanguageController(repo: Get.find()));

    comeFrom = Get.arguments ?? '';

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<MyLanguageController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.language,
        body: controller.isLoading
            ? const CustomLoader()
            : controller.langList.isEmpty
                ? NoDataWidget()
                : ListView.separated(
                    separatorBuilder: (context, index) => spaceDown(Dimensions.space30),
                    itemCount: controller.langList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.changeSelectedIndex(index);
                        },
                        child: LanguageCard(
                          index: index,
                          selectedIndex: controller.selectedIndex,
                          langeName: controller.langList[index].languageName,
                          isShowTopRight: true,
                          imagePath: "${controller.languageImagePath}/${controller.langList[index].imageUrl}",
                        ),
                      );
                    }),
        bottomNav: Padding(
          padding: const EdgeInsetsDirectional.symmetric(vertical: Dimensions.space15, horizontal: Dimensions.space15),
          child: CustomElevatedBtn(
            text: MyStrings.confirm.tr,
            isLoading: controller.isChangeLangLoading,
            onTap: () {
              controller.changeLanguage(controller.selectedIndex);
            },
          ),
        ),
      ),
    );
  }
}
