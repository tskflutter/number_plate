import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/buttons/category_button.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/data/controller/privacy/privacy_controller.dart';
import 'package:ovolutter/data/repo/privacy_repo/privacy_repo.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  void initState() {
    Get.put(PrivacyRepo());
    final controller = Get.put(PrivacyController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        appBar: const CustomAppBar(
          title: MyStrings.privacyPolicy,
          isShowActionBtn: false,
        ),
        body: GetBuilder<PrivacyController>(
          builder: (controller) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading
                ? const CustomLoader()
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space10),
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: Dimensions.space10, top: Dimensions.space15),
                          child: SizedBox(
                            height: 30,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: List.generate(
                                  controller.list.length,
                                  (index) => Row(
                                    children: [
                                      CategoryButton(
                                          color: controller.selectedIndex == index ? MyColor.getPrimaryColor() : MyColor.getBorderColor().withValues(alpha: .2),
                                          horizontalPadding: 8,
                                          verticalPadding: 7,
                                          textColor: controller.selectedIndex == index ? MyColor.white : MyColor.black,
                                          text: controller.list[index].dataValues?.title ?? '',
                                          onTap: () {
                                            controller.changeIndex(index);
                                          }),
                                      const SizedBox(width: Dimensions.space10)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        Expanded(
                            child: Center(
                          child: SingleChildScrollView(child: Container(padding: const EdgeInsets.all(20), width: double.infinity, color: Colors.transparent, child: HtmlWidget(controller.selectedHtml, textStyle: theme.textTheme.labelMedium?.copyWith(color: Theme.of(context).textTheme.titleLarge?.color), onLoadingBuilder: (context, element, loadingProgress) => const Center(child: CustomLoader())))),
                        ))
                      ],
                    ),
                  ),
          ),
        ));
  }
}
