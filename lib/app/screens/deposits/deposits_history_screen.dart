import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/will_pop_widget.dart';
import 'package:ovolutter/core/helper/string_format_helper.dart';

import 'package:ovolutter/app/components/custom_no_data_found_class.dart';
import 'package:ovolutter/app/screens/deposits/widget/custom_deposits_card.dart';
import 'package:ovolutter/app/screens/deposits/widget/deposit_bottom_sheet.dart';
import 'package:ovolutter/app/screens/deposits/widget/deposit_history_top.dart';
import 'package:get/get.dart';

import '../../../core/helper/date_converter.dart';
import '../../../core/route/route.dart';
import '../../../core/utils/dimensions.dart';
import '../../../core/utils/my_color.dart';
import '../../../core/utils/my_strings.dart';
import '../../../data/controller/deposit/deposit_history_controller.dart';
import '../../../data/repo/deposit/deposit_repo.dart';

class DepositsHistoryScreen extends StatefulWidget {
  const DepositsHistoryScreen({super.key});

  @override
  State<DepositsHistoryScreen> createState() => _DepositsHistoryScreenState();
}

class _DepositsHistoryScreenState extends State<DepositsHistoryScreen> {
  final ScrollController scrollController = ScrollController();

  fetchData() {
    Get.find<DepositController>().fetchNewList();
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<DepositController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    
    Get.put(DepositRepo());
    final controller = Get.put(DepositController(depositRepo: Get.find()));
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.beforeInitLoadData();
      scrollController.addListener(_scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<DepositController>(
      builder: (controller) => WillPopWidget(
        child: Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          appBar: CustomAppBar(
            title: MyStrings.depositHistory.tr,
            action: [
              GestureDetector(
                onTap: () {
                  controller.changeIsPress();
                },
                child: Container(padding: const EdgeInsets.all(Dimensions.space7), decoration: BoxDecoration(color: MyColor.white, shape: BoxShape.circle), child: Icon(controller.isSearch ? Icons.clear : Icons.search, color: MyColor.getPrimaryColor(), size: 15)),
              ),
              const SizedBox(width: Dimensions.space7),
              GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.newDepositScreenScreen);
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 7, right: 10, bottom: 7, top: 7),
                  padding: const EdgeInsets.all(Dimensions.space7),
                  decoration: BoxDecoration(color: MyColor.white, shape: BoxShape.circle),
                  child: Icon(Icons.add, color: MyColor.getPrimaryColor(), size: 15),
                ),
              ),
              
            ],
          ),
          body: controller.isLoading
              ? const CustomLoader()
              : Padding(
                  padding: const EdgeInsets.only(top: Dimensions.space20, left: Dimensions.space15, right: Dimensions.space15),
                  child: Column(
                    children: [
                      Visibility(
                        visible: controller.isSearch,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DepositHistoryTop(),
                            SizedBox(height: Dimensions.space15),
                          ],
                        ),
                      ),
                      Expanded(
                        child: controller.depositList.isEmpty && controller.searchLoading == false
                            ? const NoDataOrInternetScreen(/*title:MyStrings.noDepositFound,height:controller.isSearch?0.75:0.8*/)
                            : controller.searchLoading
                                ? const Center(
                                    child: CustomLoader(),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: ListView.separated(
                                      shrinkWrap: true,
                                      controller: scrollController,
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemCount: controller.depositList.length + 1,
                                      separatorBuilder: (context, index) => const SizedBox(height: Dimensions.space10),
                                      itemBuilder: (context, index) {
                                        if (controller.depositList.length == index) {
                                          return controller.hasNext()
                                              ? SizedBox(
                                                  height: 40,
                                                  width: MediaQuery.of(context).size.width,
                                                  child: const Center(
                                                    child: CustomLoader(),
                                                  ),
                                                )
                                              : const SizedBox();
                                        }
                                        return CustomDepositsCard(
                                          onPressed: () {
                                            DepositBottomSheet.depositBottomSheet(context, index);
                                          },
                                          trxValue: controller.depositList[index].trx ?? "",
                                          date: DateConverter.isoToLocalDateAndTime(controller.depositList[index].createdAt ?? ""),
                                          status: controller.getStatus(index),
                                          statusBgColor: controller.getStatusColor(index),
                                          amount: "${AppConverter.formatNumber(controller.depositList[index].amount ?? " ")} ${controller.currency}",
                                        );
                                      },
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
