import 'package:flutter/material.dart';

import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/text-field/label_text_field.dart';
import 'package:ovolutter/app/screens/deposits/new_deposit/deposit_bottomsheet.dart';
import 'package:get/get.dart';
import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';
import '../../../../data/controller/deposit/add_new_deposit_controller.dart';
import '../../../../data/repo/deposit/deposit_repo.dart';
import '../../../components/app-bar/custom_appbar.dart';
import '../../../components/custom_loader/custom_loader.dart';
import 'info_widget.dart';

class NewDepositScreen extends StatefulWidget {
  const NewDepositScreen({super.key});

  @override
  State<NewDepositScreen> createState() => _NewDepositScreenState();
}

class _NewDepositScreenState extends State<NewDepositScreen> {
  @override
  void initState() {
    Get.put(DepositRepo());
    final controller = Get.put(AddNewDepositController(
      depositRepo: Get.find(),
    ));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.amountController.text = Get.arguments[0];
      controller.adId = Get.arguments[1];
      controller.isBoost = Get.arguments[2];
      controller.getDepositMethod();
    });
  }

  @override
  void dispose() {
    Get.find<AddNewDepositController>().clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<AddNewDepositController>(
      builder: (controller) => Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: const CustomAppBar(title: MyStrings.deposit),
        body: controller.isLoading
            ? const CustomLoader()
            : SingleChildScrollView(
                padding: Dimensions.screenPadding,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space20),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.defaultRadius),
                  ),
                  child: Form(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelTextField(
                          onTap: () {
                            DepositBottomsheet.deposittBottomSheet(context, controller);
                          },
                          readOnly: true,
                          needOutline: true,
                          radius: Dimensions.defaultRadius,
                          labelText: MyStrings.selectPaymentMethod,
                          hintText: MyStrings.selectaMethod,
                          textInputType: TextInputType.text,
                          inputAction: TextInputAction.next,
                          controller: controller.selectedPaymentMethodController,
                          onChanged: (value) {
                            return;
                          },
                          suffixIcon: UnconstrainedBox(
                            child: Container(
                              padding: const EdgeInsets.all(Dimensions.space2),
                              decoration: BoxDecoration(
                                color: MyColor.getBodyTextColor().withValues(alpha: 0.22),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Icon(Icons.keyboard_arrow_down_sharp, color: MyColor.black),
                            ),
                          ),
                        ),
                        const SizedBox(height: Dimensions.space15),
                        LabelTextField(
                          onTap: () {},
                          readOnly: true,
                          labelText: MyStrings.amount,
                          hintText: MyStrings.enterAmount.tr,
                          inputAction: TextInputAction.done,
                          controller: controller.amountController,
                          textInputType: TextInputType.number,
                          suffixIcon: UnconstrainedBox(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.space10, vertical: Dimensions.space8),
                              margin: const EdgeInsets.only(right: Dimensions.space8),
                              decoration: BoxDecoration(color: MyColor.getBodyTextColor().withValues(alpha: 0.22), borderRadius: BorderRadius.circular(Dimensions.space2)),
                              alignment: Alignment.center,
                              child: Text(
                                controller.currency,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getPrimaryColor(), fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.toString().isEmpty) {
                              controller.changeInfoWidgetValue(0);
                            } else {
                              double amount = double.tryParse(value.toString()) ?? 0;
                              controller.changeInfoWidgetValue(amount);
                            }
                            return;
                          },
                        ),
                        if (controller.paymentMethod?.id != -1) ...[const InfoWidget()],
                        const SizedBox(height: 35),
                        CustomElevatedBtn(
                          isLoading: controller.submitLoading,
                          text: MyStrings.submit,
                          onTap: () {
                            controller.submitDeposit();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
