import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  int currentIndex = 0;
  PageController? controller = PageController();

  void setCurrentIndex(int index) {
    currentIndex = index;
    // controller?.animateTo((controller!.page!.toInt() + 1), duration: Duration(seconds: 1), curve: Curves.linear);
    update();
  }

  LinearGradient generateGradientVariation(Color baseColor, GradientIntensity intensity) {
    Color generateVariation() {
      final int variation = intensity.index * 50; // Adjust the factor based on intensity levels
      final int red = min(255, baseColor.red + variation);
      final int green = min(255, baseColor.green + variation);
      final int blue = min(255, baseColor.blue + variation);

      return Color.fromRGBO(red, green, blue, 1.0);
    }

    final Color color1 = baseColor;
    final Color color2 = generateVariation();

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        color2,
        color1,
      ],
    );
  }
}

enum GradientIntensity { accent, soft, medium, hard }
// gradient: LinearGradient(
//   colors: [
//     Color(0xffcf92fb),
//     Color(0xffbf73f1),
//   ],
// ),
