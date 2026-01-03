import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/core/utils/my_color.dart';
import 'package:ovolutter/core/utils/my_images.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/style.dart';

import '../../core/utils/dimensions.dart';
import 'image/custom_svg_picture.dart';

class NoNotificationScreen extends StatefulWidget {
  final String message;
  final double paddingTop;
  final double imageHeight;
  final String message2;
  final String image;

  const NoNotificationScreen({
    super.key,
    this.message = MyStrings.noNotification,
    this.paddingTop = 6,
    this.imageHeight = .5,
    this.message2 = MyStrings.noNotificationToShow,
    this.image = MyImages.noNotificationFound,
  });

  @override
  State<NoNotificationScreen> createState() => _NoNotificationScreenState();
}

class _NoNotificationScreenState extends State<NoNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const SizedBox(
              height: 30,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * widget.imageHeight - 100,
                  width: MediaQuery.of(context).size.width * .4,
                  child: CustomSvgPicture(
                    image: MyImages.noNotification,
                    height: 100,
                    width: 100,
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 6, left: 30, right: 30),
                  child: Column(
                    children: [
                      Text(
                        widget.message.tr,
                        textAlign: TextAlign.center,
                        style: boldOverLarge.copyWith(color: MyColor.headingTextColor, fontSize: Dimensions.space22),
                      ),
                      const SizedBox(height: 5),
                      Text(widget.message2, style: theme.textTheme.labelMedium?.copyWith(color: MyColor.getBodyTextColor(), fontSize: Dimensions.fontLarge), textAlign: TextAlign.center)
                    ],
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
