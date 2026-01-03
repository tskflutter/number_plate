import 'package:flutter/material.dart';
import 'package:ovolutter/app/components/image/my_asset_widget.dart';

class OnboardingPage extends StatelessWidget {
  final String? imagePath;
  final String title;
  final String description;
  final int index;

  const OnboardingPage({
    super.key,
    this.imagePath,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      key: ValueKey(index),
      curve: Curves.fastOutSlowIn,
      tween: Tween<double>(begin: 1.0, end: 0.0),
      duration: const Duration(milliseconds: 700),
      builder: (context, value, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: imagePath != null
                    ? Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.01)
                          ..rotateX(value * -0.06),
                        child: MyAssetImageWidget(
                          assetPath: imagePath ?? '',
                          width: double.infinity,
                          height: double.infinity,
                          boxFit: BoxFit.cover,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ],
        );
      },
    );
  }
}
