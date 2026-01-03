import 'package:flutter/material.dart';
import 'package:ovolutter/core/utils/dimensions.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/controller/support/ticket_details_controller.dart';
import 'package:ovolutter/data/repo/support/support_repo.dart';
import 'package:ovolutter/app/components/app-bar/custom_appbar.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/screens/ticket/ticket_details_screen/sections/message_list_section.dart';
import 'package:ovolutter/app/screens/ticket/ticket_details_screen/sections/reply_section.dart';
import 'package:ovolutter/app/screens/ticket/ticket_details_screen/widget/ticket_status_widget.dart';
import 'package:get/get.dart';

class TicketDetailsScreen extends StatefulWidget {
  const TicketDetailsScreen({super.key});

  @override
  State<TicketDetailsScreen> createState() => _TicketDetailsScreenState();
}

class _TicketDetailsScreenState extends State<TicketDetailsScreen> {
  String title = "";
  @override
  void initState() {
    String ticketId = Get.arguments[0];
    title = Get.arguments[1];

    Get.put(SupportRepo());
    var controller = Get.put(TicketDetailsController(repo: Get.find(), ticketId: ticketId));

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GetBuilder<TicketDetailsController>(
      builder: (controller) => Scaffold(
          appBar: CustomAppBar(
            title: MyStrings.replyTicket,
            action: [
              if (controller.model.data?.myTickets?.status != '3')
                Padding(
                  padding: const EdgeInsets.only(right: Dimensions.space20),
                  child: TextButton(
                      onPressed: () {
                        controller.closeTicket(controller.model.data?.myTickets?.id.toString() ?? '-1');
                      },
                      child: Text(MyStrings.close, style: theme.textTheme.titleMedium?.copyWith(color: MyColor.getErrorColor()))),
                )
            ],
          ),
          body: controller.isLoading
              ? const CustomLoader(isFullScreen: true)
              : SingleChildScrollView(
                  padding: Dimensions.screenPadding,
                  child: Container(
                    // padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        TicketStatusWidget(controller: controller),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: theme.cardColor,
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [ReplySection(), MessageListSection()],
                          ),
                        )
                      ],
                    ),
                  ),
                )),
    );
  }
}
