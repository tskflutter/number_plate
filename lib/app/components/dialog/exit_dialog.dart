import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:ovolutter/app/components/buttons/custom_elevated_button.dart';
import 'package:ovolutter/app/components/text/header_text.dart';
import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

Future showExitDialog(
  BuildContext context, {
  String? title,
  String? subTitle,
  String buttonTitle = MyStrings.yes,
  required VoidCallback onConfirmTap,
  bool isConfirmLoading = false,
  VoidCallback? onCancelTap,
}) {
  return showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: true,
    traversalEdgeBehavior: TraversalEdgeBehavior.leaveFlutterView,
    builder: (_) {
      return Dialog(
        surfaceTintColor: MyColor.getTransparentColor(),
        insetPadding: EdgeInsets.all(Dimensions.space16.w),
        backgroundColor: MyColor.getTransparentColor(),
        insetAnimationCurve: Curves.fastOutSlowIn,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Container(
              padding: EdgeInsetsDirectional.symmetric(
                vertical: Dimensions.space30.w,
                horizontal: Dimensions.space16.w,
              ),
              decoration: BoxDecoration(
                color: MyColor.white,
                borderRadius: BorderRadius.all(Radius.circular(20.w)),
                border: Border.all(
                  color: MyColor.getTransparentColor(),
                  width: 0.6,
                ),
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        width: Dimensions.space60.w,
                        height: Dimensions.space60.w,
                        child: Lottie.asset(
                          MyIcons.warningLottieIcon,
                          repeat: false,
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          width: Dimensions.space60.w,
                          height: Dimensions.space60.w,
                        ),
                      ),
                      spaceDown(Dimensions.space10),
                      HeaderText(
                        text: title?.tr ?? MyStrings.pleaseConfirm.tr,
                        textStyle: boldLarge,
                      ),
                      spaceDown(Dimensions.space4),
                      HeaderText(
                        text: subTitle?.tr ?? MyStrings.sureToDoThis.tr,
                        textAlign: TextAlign.center,
                        textStyle: semiBoldDefault,
                      ),
                      spaceDown(Dimensions.space30),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedBtn(
                              radius: Dimensions.largeRadius.r,
                              bgColor: MyColor.white,
                              borderColor: MyColor.getBodyTextColor(),
                              textColor: MyColor.getBodyTextColor(),
                              text: MyStrings.cancel.tr,
                              onTap: () {
                                if (onCancelTap == null) {
                                  Navigator.of(context).maybePop();
                                } else {
                                  onCancelTap();
                                }
                              },
                            ),
                          ),
                          spaceSide(Dimensions.space10),
                          Expanded(
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return CustomElevatedBtn(
                                  isLoading: isConfirmLoading,
                                  radius: Dimensions.largeRadius.r,
                                  bgColor: MyColor.getPrimaryColor(),
                                  text: buttonTitle.tr,
                                  onTap: () {
                                    setState(() {
                                      isConfirmLoading = true;
                                      onConfirmTap();
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
