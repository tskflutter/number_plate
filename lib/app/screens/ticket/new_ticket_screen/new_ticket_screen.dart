import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/my_strings.dart';

import 'package:ovolutter/data/controller/support/new_ticket_controller.dart';
import 'package:ovolutter/data/repo/support/support_repo.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/text-field/custom_text_field.dart';
import 'package:ovolutter/app/components/text-field/label_text_field.dart';
import 'package:ovolutter/app/components/text/label_text.dart';
import 'package:ovolutter/app/screens/ticket/new_ticket_screen/section/attachment_section.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class NewTicketScreen extends StatefulWidget {
  const NewTicketScreen({super.key});

  @override
  State<NewTicketScreen> createState() => _NewTicketScreenState();
}

class _NewTicketScreenState extends State<NewTicketScreen> {
  @override
  void initState() {
    Get.put(SupportRepo());
    Get.put(NewTicketController(repo: Get.find()));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<NewTicketController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.addNewTicket,
        body: controller.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Dimensions.textToTextSpace),
                    CustomAppCard(
                        showBorder: false,
                        child: Column(
                          children: [
                            CustomTextField(
                              labelText: MyStrings.subject.tr,
                              hintText: MyStrings.enterYourSubject.tr,
                              controller: controller.subjectController,
                              isPassword: false,
                              isShowSuffixIcon: false,
                              needOutlineBorder: true,
                              nextFocus: controller.messageFocusNode,
                              onSuffixTap: () {},
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            LabelText(
                              text: MyStrings.priority.tr,
                              isRequired: true,
                            ),
                            const SizedBox(height: Dimensions.space5),
                            DropDownTextFieldContainer(
                              color: MyColor.getTransparentColor(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 10),
                                child: DropdownButton<String>(
                                  dropdownColor: MyColor.getCardBackgroundColor(),
                                  value: controller.selectedPriority,
                                  elevation: 8,
                                  icon: SvgPicture.asset(MyImages.arrowDown),
                                  iconDisabledColor: MyColor.getBorderColor(),
                                  iconEnabledColor: MyColor.getPrimaryColor(),
                                  isExpanded: true,
                                  underline: Container(height: 0, color: MyColor.getInformationColor()),
                                  onChanged: (String? newValue) {
                                    controller.setPriority(newValue);
                                  },
                                  items: controller.priorityList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: theme.textTheme.labelMedium?.copyWith(fontSize: Dimensions.fontDefault),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            CustomTextField(
                              labelText: MyStrings.message.tr,
                              needOutlineBorder: true,
                              hintText: MyStrings.enterYourMessage.tr,
                              isPassword: false,
                              controller: controller.messageController,
                              maxLines: 5,
                              focusNode: controller.messageFocusNode,
                              isShowSuffixIcon: false,
                              onSuffixTap: () {},
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            const SizedBox(height: Dimensions.textToTextSpace),
                            InkWell(
                              onTap: () {
                                controller.pickFile();
                              },
                              child: LabelTextField(
                                readOnly: true,
                                contentPadding: const EdgeInsets.all(Dimensions.space10),
                                isAttachment: true,
                                labelText: MyStrings.attachment.tr,
                                hintText: MyStrings.chooseAFile.tr,
                                inputAction: TextInputAction.done,
                                onChanged: (value) {
                                  return;
                                },
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    controller.pickFile();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space10),
                                    margin: const EdgeInsets.all(Dimensions.space5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: MyColor.getPrimaryColor(),
                                    ),
                                    child: Text(
                                      MyStrings.upload,
                                      style: theme.textTheme.labelMedium?.copyWith(color: MyColor.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: Dimensions.space2),
                            Text("${MyStrings.supportedFileType.tr.toTitleCase()} ${MyStrings.ext.tr}", style: theme.textTheme.bodySmall?.copyWith(color: MyColor.getBodyTextColor())),
                            const SizedBox(height: Dimensions.space10),
                            const AttachmentSection(),
                          ],
                        )),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomElevatedBtn(
                        isLoading: controller.submitLoading,
                        // isOutlined: true,
                        // isColorChange: true,
                        // verticalPadding: Dimensions.space15,
                        radius: Dimensions.space8,
                        bgColor: MyColor.getPrimaryColor(),
                        text: MyStrings.submit.tr,
                        onTap: () {
                          controller.submit();
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class DropDownTextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const DropDownTextFieldContainer({super.key, required this.child, this.color = MyColor.black});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
        border: Border.all(color: MyColor.getBorderColor(), width: .5),
      ),
      child: child,
    );
  }
}
