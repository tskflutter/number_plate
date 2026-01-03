import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:ovolutter/app/components/bottom-sheet/bottom_sheet_close_button.dart';
import 'package:ovolutter/app/components/bottom-sheet/custom_bottom_sheet.dart';
import 'package:ovolutter/app/components/bottom-sheet/custom_bottom_sheet_plus.dart';
import 'package:ovolutter/app/components/buttons/card_button.dart';
import 'package:ovolutter/app/components/card/custom_app_card.dart';
import 'package:ovolutter/app/components/card/my_custom_scaffold.dart';
import 'package:ovolutter/app/components/custom_loader/custom_loader.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/app/components/text/bottom_sheet_header_text.dart';
import 'package:ovolutter/app/components/user_details/user_details_data.dart';
import 'package:ovolutter/app/screens/quick_sale/controller/quick_sale_controller.dart';
import 'package:ovolutter/core/helper/date_converter.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';
import 'package:ovolutter/data/repo/quick_sales/quick_sales_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class QuickSaleScreen extends StatefulWidget {
  const QuickSaleScreen({super.key});

  @override
  State<QuickSaleScreen> createState() => _QuickSaleScreenState();
}

class _QuickSaleScreenState extends State<QuickSaleScreen> {
  ScrollController scrollController = ScrollController();

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      if (Get.find<QuickSaleController>().hasNext()) {
        Get.find<QuickSaleController>().quickSalesData();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Get.put(QuickSalesRepo());
    final controller = Get.put(QuickSaleController(repo: Get.find()));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadData();
      scrollController.addListener(scrollListener);
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuickSaleController>(
      builder: (controller) => MyCustomScaffold(
        pageTitle: MyStrings.quickSales,
        centerTitle: true,
        actionButton: [
          GestureDetector(
            onTap: () {
              CustomBottomSheet(
                  isNeedMargin: false,
                  isNeedpadding: false,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [BottomSheetHeaderText(text: MyStrings.needToSellQuickly.tr), BottomSheetCloseButton()],
                        ),
                      ),
                      Container(
                        padding: EdgeInsetsDirectional.symmetric(horizontal: Dimensions.space16.w, vertical: Dimensions.space5.h),
                        decoration: BoxDecoration(color: MyColor.lightBackground),
                        child: Column(
                          children: [
                            spaceDown(Dimensions.space16),
                            Text(
                              MyStrings.thisSectionShows.tr,
                              style: regularDefault.copyWith(color: MyColor.headingTextColor),
                            ),
                            spaceDown(Dimensions.space12),
                            Text(
                              MyStrings.ifYouNeedToSellQuickly.tr,
                              style: regularDefault.copyWith(color: MyColor.headingTextColor),
                            ),
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
            child: MyAssetImageWidget(
              assetPath: MyImages.info,
              isSvg: true,
              height: Dimensions.space24.h,
              width: Dimensions.space24.h,
            ),
          ),
          spaceSide(Dimensions.space16)
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            controller.loadData();
          },
          color: MyColor.black,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    controller: scrollController,
                    physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                    separatorBuilder: (context, index) => spaceDown(Dimensions.space10),
                    itemCount: controller.quickSales.length + 1,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      if (controller.quickSales.length == index) {
                        return controller.hasNext() ? const CustomLoader(isPagination: true) : const SizedBox();
                      }

                      var quickSaleData = controller.quickSales[index];
                      return CustomAppCard(
                          padding: EdgeInsets.all(Dimensions.space16),
                          showShadow: false,
                          borderColor: MyColor.lightTextFieldBorder,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserDetailsData(
                                name: quickSaleData.name ?? "",
                                subtitle: "${MyStrings.memberSince} ${DateConverter.formatYearDate(quickSaleData.createdAt ?? "")}",
                                userImage: "${UrlContainer.domainUrl}/${controller.user.imagePath}/${controller.user.image}",
                              ),
                              spaceDown(Dimensions.space12),
                              Text(
                                MyStrings.interestedIn.tr,
                                style: regularSmall.copyWith(color: MyColor.headingTextColor),
                              ),
                              spaceDown(Dimensions.space12),
                              Wrap(
                                spacing: Dimensions.space10,
                                runSpacing: Dimensions.space10,
                                children: List.generate(controller.quickSales[index].intrest?.length ?? 0, (interestIndex) {
                                  var interestData = controller.quickSales[index].intrest;
                                  return CustomAppCard(
                                    showShadow: false,
                                    margin: EdgeInsets.zero,
                                    gradient: LinearGradient(
                                      colors: MyColor.colors,
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                    useGradient: true,
                                    radius: Dimensions.cardRadius + 3,
                                    padding: EdgeInsetsDirectional.symmetric(
                                      vertical: Dimensions.space4.h,
                                      horizontal: Dimensions.space16.w,
                                    ),
                                    child: Text(
                                      interestData?[interestIndex].toString() ?? "",
                                      style: regularSmall.copyWith(
                                        color: MyColor.headingTextColor,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                              spaceDown(Dimensions.space12),
                              Row(
                                children: [
                                  Expanded(
                                    child: CardButton(
                                      text: MyStrings.call,
                                      press: () async {
                                        var url = Uri.parse("tel:+${quickSaleData.dialCode}${quickSaleData.phoneNumber}");
                                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                                          throw Exception('Could not launch $url');
                                        }
                                      },
                                      borderColor: MyColor.blackColorShadow,
                                      icon: MyImages.call,
                                    ),
                                  ),
                                  spaceSide(Dimensions.space8),
                                  Expanded(
                                    child: CardButton(
                                      bgColor: MyColor.greenColor,
                                      text: MyStrings.whatsApp,
                                      press: () async {
                                        final url = Uri.parse("https://wa.me/${quickSaleData.dialCode}${quickSaleData.phoneNumber}?text=${Uri.encodeComponent(MyStrings.hello.tr)}");
                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url, mode: LaunchMode.externalApplication);
                                        } else {
                                          print("Could not launch $url");
                                        }
                                      },
                                      borderColor: MyColor.greenColorShadow,
                                      icon: MyImages.chat,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
