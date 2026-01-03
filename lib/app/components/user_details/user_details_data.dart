import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/image/my_network_image_widget.dart';

import 'package:ovolutter/core/utils/style.dart';
import 'package:ovolutter/core/utils/util_exporter.dart';

class UserDetailsData extends StatelessWidget {
  final String userImage;
  final String name;
  final String subtitle;
  const UserDetailsData({super.key, required this.userImage, required this.name, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusDirectional.all(Radius.circular(Dimensions.space100)),
          child: MyNetworkImageWidget(
            imageUrl: userImage,
            height: Dimensions.space45.h,
            width: Dimensions.space45.h,
            isProfile: true,
          ),
        ),
        spaceSide(Dimensions.space12),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: semiBoldDefault.copyWith(color: MyColor.headingTextColor, fontFamily: 'poppins', fontWeight: FontWeight.w600),
              ),
              spaceDown(Dimensions.space4),
              Text(
                subtitle,
                style: regularSmall.copyWith(
                  color: MyColor.hintTextColor,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
