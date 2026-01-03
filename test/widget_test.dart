import 'package:flutter/material.dart';
import 'package:ovolutter/data/controller/auth/auth/registration_controller.dart';
import 'package:ovolutter/app/screens/auth/registration/registration_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  setUpAll(() async {
    Get.testMode = true;
    // final sharedPreferences = await SharedPreferences.getInstance();

    // Get.put(RegistrationRepo(apiClient: ApiClient(sharedPreferences: Get.put(SharedPreferences))));
    Get.put(
      RegistrationController(registrationRepo: Get.find(), generalSettingRepo: Get.find()),
    );
  });

  testWidgets("test register screen", (tester) async {
    tester.pump();
    await tester.pumpWidget(const MaterialApp(home: RegistrationScreen()));

    expect(find.byType(ListView), findsOne);
  });
}
