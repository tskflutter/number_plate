import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:ovolutter/app/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/no_notification_screen.dart';
import 'package:ovolutter/app/components/text/bottom_sheet_header_text.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/repo/notification_repo/notification_repo.dart';

import '../../../data/controller/notifications/notification_controller.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Get.find<NotificationsController>().initData();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      if (Get.find<NotificationsController>().hasNext()) {
        fetchData();
      }
    }
  }

  @override
  void initState() {
    Get.put(NotificationRepo());
    final controller = Get.put(NotificationsController(repo: Get.find()));

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.page = 0;
      controller.initData();
      controller.clearActiveNotificationInfo();
      _controller.addListener(_scrollListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyCustomScaffold(
      pageTitle: MyStrings.notifications,
      centerTitle: true,
      body: GetBuilder<NotificationsController>(
        builder: (controller) => RefreshIndicator(
            color: MyColor.getPrimaryColor(),
            backgroundColor: MyColor.getBackgroundColor(),
            onRefresh: () async {
              controller.page = 0;
              await controller.initData();
            },
            child: controller.isLoading
                ? CustomLoader()
                : controller.notificationList.isEmpty
                    ? NoNotificationScreen()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.notificationList.length} Notifications",
                            style: boldMediumLarge.copyWith(color: MyColor.headingTextColor),
                          ),
                          spaceDown(Dimensions.space12),
                          Expanded(
                            child: ListView.builder(
                                padding: EdgeInsets.zero,
                                controller: _controller,
                                itemCount: controller.notificationList.length + 1,
                                itemBuilder: (context, index) {
                                  if (controller.notificationList.length == index) {
                                    return controller.hasNext()
                                        ? Center(
                                            child: CircularProgressIndicator(
                                            color: MyColor.getPrimaryColor(),
                                          ))
                                        : const SizedBox();
                                  }
                                  bool isNotRead = controller.notificationList[index].userRead == '0';
                                  // String remarks=controller.notificationList[index].remark??'';
                                  return GestureDetector(
                                    onTap: () {
                                      controller.markAsReadAndGotoThePage(index);
                                      CustomBottomSheet(
                                          isNeedMargin: false,
                                          isNeedpadding: false,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space12.h),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [BottomSheetHeaderText(text: MyStrings.notification.tr), BottomSheetCloseButton()],
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space5.h),
                                                decoration: BoxDecoration(color: MyColor.lightBackground),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    spaceDown(Dimensions.space16),
                                                    Text(
                                                      controller.notificationList[index].sentFrom ?? " ",
                                                      style: boldMediumLarge.copyWith(fontFamily: 'poppins'),
                                                    ),
                                                    spaceDown(Dimensions.space8),
                                                    Text(
                                                      controller.notificationList[index].subject ?? "",
                                                      style: regularDefault.copyWith(color: MyColor.headingTextColor),
                                                    ),
                                                    spaceDown(Dimensions.space8),
                                                    Text(
                                                      controller.notificationList[index].message ?? "",
                                                      style: regularDefault.copyWith(color: MyColor.headingTextColor),
                                                    ),
                                                    spaceDown(Dimensions.space8),
                                                    spaceDown(Dimensions.space50),
                                                    CardButton(
                                                      text: MyStrings.gotIt,
                                                      press: () {
                                                        Get.back();
                                                      },
                                                      borderColor: MyColor.blackColorShadow,
                                                      icon: "",
                                                    ),
                                                    spaceDown(Dimensions.space12),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )).customBottomSheet(context);
                                    },
                                    child: CustomAppCard(
                                        borderColor: MyColor.lightTextFieldBorder,
                                        margin: EdgeInsets.only(bottom: Dimensions.space12),
                                        padding: EdgeInsets.all(Dimensions.space16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.notificationList[index].sentFrom ?? "",
                                              // "controller.notificationList[index].message ?? " "",
                                              style: boldMediumLarge.copyWith(fontFamily: 'poppins'),
                                            ),
                                            spaceDown(Dimensions.space8),
                                            Text(
                                              controller.notificationList[index].subject ?? "",
                                              style: regularDefault.copyWith(color: MyColor.headingTextColor),
                                            ),
                                            spaceDown(Dimensions.space8),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  DateConverter().formatRelativeDateFromJson(controller.notificationList[index].createdAt ?? ""),
                                                  style: regularSmall.copyWith(color: MyColor.hintTextColor),
                                                ),
                                                Text(
                                                  "•",
                                                  style: regularDefault.copyWith(color: MyColor.darkError),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                          ),
                        ],
                      )),
      ),
    );
  }
}
