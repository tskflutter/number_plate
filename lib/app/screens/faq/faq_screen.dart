import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';

import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/controller/faq_controller/faq_controller.dart';
import '../../../data/repo/faq_repo/faq_repo.dart';
import 'faq_widget.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    Get.put(FaqRepo());
    final controller = Get.put(FaqController(faqRepo: Get.find()));
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return MyCustomScaffold(
        pageTitle: MyStrings.faq,
        body: GetBuilder<FaqController>(
          builder: (controller) => controller.isLoading
              ? const CustomLoader()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        MyStrings.frequentlyAskedQues.tr,
                        style: boldOverLarge.copyWith(fontSize: Dimensions.space22, color: MyColor.headingTextColor),
                      ),
                      spaceDown(Dimensions.space8),
                      Text(
                        MyStrings.findAnswerToCommon.tr,
                        style: regularLarge.copyWith(color: MyColor.hintTextColor),
                      ),
                      spaceDown(Dimensions.space24),
                      ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.faqList.length,
                        separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                        itemBuilder: (context, index) => FaqListItem(
                            answer: (controller.faqList[index].dataValues?.answer ?? '').tr,
                            question: (controller.faqList[index].dataValues?.question ?? '').tr,
                            index: index,
                            press: () {
                              controller.changeSelectedIndex(index);
                            },
                            selectedIndex: controller.selectedIndex),
                      ),
                    ],
                  )),
        ));
  }
}
