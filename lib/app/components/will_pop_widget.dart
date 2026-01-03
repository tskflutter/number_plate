import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ovolutter/app/components/dialog/exit_dialog.dart';

class WillPopWidget extends StatelessWidget {
  final Widget child;
  final String nextRoute;

  const WillPopWidget({super.key, required this.child, this.nextRoute = ''});

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult: (c, d) async {
          if (nextRoute.toString().trim().isEmpty) {
            showExitDialog(context, onConfirmTap: () {});
            return Future.value(false);
          } else {
            Get.offAndToNamed(nextRoute);
            return Future.value(false);
          }
        },
        child: child);
  }
}
