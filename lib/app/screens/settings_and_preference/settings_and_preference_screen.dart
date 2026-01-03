import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/data/controller/my_language_controller/my_language_controller.dart';
import 'package:ovolutter/data/repo/auth/general_setting_repo.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/no_data.dart';
import 'package:ovolutter/app/screens/language/widget/language_card.dart';
import 'package:get/get.dart';

class SettingsAndPreferenceScreen extends StatefulWidget {
  const SettingsAndPreferenceScreen({super.key});

  @override
  State<SettingsAndPreferenceScreen> createState() => _SettingsAndPreferenceScreenState();
}

class _SettingsAndPreferenceScreenState extends State<SettingsAndPreferenceScreen> {
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
      builder: (controller) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: CustomAppBar(
          isShowBackBtn: true,
          title: MyStrings.language.tr,
        ),
        body: controller.isLoading
            ? const CustomLoader()
            : controller.langList.isEmpty
                ? NoDataWidget()
                : SingleChildScrollView(
                    padding: Dimensions.screenPadding,
                    child: GridView.builder(
                      shrinkWrap: true,
                      addAutomaticKeepAlives: true,
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: controller.langList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: MediaQuery.of(context).size.width > 200 ? 2 : 1, crossAxisSpacing: 12, mainAxisSpacing: 12, mainAxisExtent: 150),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          controller.changeSelectedIndex(index);
                        },
                        child: LanguageCard(
                          index: index,
                          selectedIndex: controller.selectedIndex,
                          langeName: controller.langList[index].languageName,
                          isShowTopRight: true,
                          imagePath: '',
                        ),
                      ),
                    ),
                  ),
        bottomNavigationBar: Padding(
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
