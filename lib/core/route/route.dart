import 'package:ovolutter/app/components/bottom-nav-bar/bottom_nav_1.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/ads/view/ads_plate_details_screen.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/ads/view/my_ads_screen.dart';
import 'package:ovolutter/app/screens/bottom_nav_section/watchlist/view/watchlist_screen.dart';
import 'package:ovolutter/app/screens/car_plates/view/car_plates_screen.dart';
import 'package:ovolutter/app/screens/component_screen.dart';
import 'package:ovolutter/app/screens/list_plate/view/list_plate_screen.dart';
import 'package:ovolutter/app/screens/onbaorad/onboard_intro_screen.dart';
import 'package:ovolutter/app/screens/pay_now/view/pay_now_screen.dart';
import 'package:ovolutter/app/screens/pay_now/view/payment_confirmation_screen.dart';
import 'package:ovolutter/app/screens/plate_details/views/plate_details_screen.dart';
import 'package:ovolutter/app/screens/profile/profile_screen.dart';
import 'package:ovolutter/app/screens/promote_plan/view/promote_plan_screen.dart';
import 'package:ovolutter/app/screens/promote_plan/view/promotion_confirmation_screen.dart';
import 'package:ovolutter/app/screens/quick_sale/view/quick_sale_screen.dart';
import 'package:ovolutter/app/screens/request_plates/view/request_plate_details_screen.dart';
import 'package:ovolutter/app/screens/request_plates/view/request_plates_screen.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';
import 'package:ovolutter/app/components/preview_image.dart';
import 'package:ovolutter/app/screens/account/change-password/change_password_screen.dart';
import 'package:ovolutter/app/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:ovolutter/app/screens/auth/forget_password/forget_password/forget_password.dart';
import 'package:ovolutter/app/screens/auth/forget_password/reset_password/reset_password_screen.dart';
import 'package:ovolutter/app/screens/auth/forget_password/verify_forget_password/verify_forget_password_screen.dart';
import 'package:ovolutter/app/screens/auth/kyc/kyc.dart';
import 'package:ovolutter/app/screens/auth/login/login_screen.dart';
import 'package:ovolutter/app/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:ovolutter/app/screens/auth/registration/registration_screen.dart';
import 'package:ovolutter/app/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:ovolutter/app/screens/edit_profile/edit_profile_screen.dart';
import 'package:ovolutter/app/screens/faq/faq_screen.dart';
import 'package:ovolutter/app/screens/language/language_screen.dart';
import 'package:ovolutter/app/screens/notification/notification_screen.dart';

import 'package:ovolutter/app/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:ovolutter/app/screens/splash/splash_screen.dart';
import 'package:ovolutter/app/screens/ticket/new_ticket_screen/new_ticket_screen.dart';
import 'package:ovolutter/app/screens/ticket/all_ticket_screen/all_ticket_screen.dart';
import 'package:ovolutter/app/screens/transaction/transactions_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/screens/auth/two_factor/two_factor_setup_screen/two_factor_setup_screen.dart';
import '../../app/screens/auth/two_factor/two_factor_verification_screen/two_factor_verification_screen.dart';
import '../../app/screens/deposits/deposit_webview/my_webview_screen.dart';
import '../../app/screens/deposits/deposits_history_screen.dart';
import '../../app/screens/deposits/new_deposit/new_deposit_screen.dart';
import '../../app/screens/ticket/ticket_details_screen/ticket_details_screen.dart';
import '../../app/screens/withdraw/add_withdraw_screen/add_withdraw_method_screen.dart';
import '../../app/screens/withdraw/confirm_withdraw_screen/withdraw_confirm_screen.dart';
import '../../app/screens/withdraw/withdraw_history/withdraw_screen.dart';

class RouteHelper {
  //use screen in screen name and route name
  static const String splashScreen = "/splash_screen";
  static const String onboardScreen = "/onboard_screen";
  static const String loginScreen = "/login_screen";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String changePasswordScreen = "/change_password_screen";
  static const String registrationScreen = "/registration_screen";
  static const String bottomNavBar = "/bottom_nav_bar";
  static const String myWalletScreen = "/my_wallet_screen";
  static const String addMoneyHistoryScreen = "/add_money_history_screen";
  static const String profileCompleteScreen = "/profile_complete_screen";
  static const String emailVerificationScreen = "/verify_email_screen";
  static const String smsVerificationScreen = "/verify_sms_screen";
  static const String verifyPassCodeScreen = "/verify_pass_code_screen";
  static const String twoFactorScreen = "/two-factor-screen";
  static const String resetPasswordScreen = "/reset_pass_screen";
  static const String transactionHistoryScreen = "/transaction_history_screen";
  static const String notificationScreen = "/notification_screen";
  static const String profileScreen = "/profile_screen";
  static const String editProfileScreen = "/edit_profile_screen";
  static const String kycScreen = "/kyc_screen";
  static const String privacyScreen = "/privacy-screen";

  static const String withdrawScreen = "/withdraw-screen";
  static const String addWithdrawMethodScreen = "/withdraw-method";
  static const String withdrawConfirmScreenScreen = "/withdraw-preview-screen";
  static const String supportTicketMethodsList = '/all_ticket_methods';
  static const String allTicketScreen = '/all_ticket_screen';

  static const String ticketDetailsScreen = '/ticket_details_screen';

  static const String newTicketScreen = '/new_ticket_screen';

  static const String depositsHistoryScreen = "/deposits";
  static const String newDepositScreenScreen = "/deposits_money";
  static const String depositWebViewScreen = '/deposit_webView';
  static const String languageScreen = "/languages_screen";
  static const String twoFactorSetupScreen = "/two-factor-setup-screen";
  static const String previewImageScreen = "/preview-image-screen";
  static const String faqScreen = "/faq-screen";
  static const String notification = "/notifications-screen";
  static const String componentScreen = "/component-screen";
  static const String plateDetailsScreen = "/plate-details-screen";
  static const String carPlatesScreen = "/car-plates-screen";
  static const String requestPlatesScreen = "/request-plates-screen";
  static const String requestPlateDetailsScreen = "/request-plates-details-screen";
  static const String quickSalesScreen = "/quick-sales-screen";
  static const String myAdsScreen = "/my-ads-screen";
  static const String myAdsPlateDetailsScreen = "/my-ads-plate-details-screen";
  static const String listPlateScreen = "/list-plate-screen";
  static const String payNowScreen = "/pay-now-screen";
  static const String paymentConfirmationScreen = "/payment-confirmation-screen";
  static const String promotePlanScreen = "/promote-plan-screen";
  static const String promotionConfirmationScreen = "/promotion-confirmation-screen";
  static const String watchlistScreen = "/watchlist-screen";

  List<GetPage> routes = [
    GetPage(name: onboardScreen, page: () => const OnBoardIntroScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: splashScreen, page: () => const SplashScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: loginScreen, page: () => const LoginScreen(), transition: Transition.downToUp, fullscreenDialog: true, popGesture: false, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: forgotPasswordScreen, page: () => const ForgetPasswordScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: changePasswordScreen, page: () => const ChangePasswordScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: registrationScreen, page: () => const RegistrationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: profileCompleteScreen, page: () => const ProfileCompleteScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: bottomNavBar, page: () => BottomNavBar(key: bottomNavKey), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: withdrawScreen, page: () => const WithdrawScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: addWithdrawMethodScreen, page: () => const AddWithdrawMethod(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: withdrawConfirmScreenScreen, page: () => const WithdrawConfirmScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: profileScreen, page: () => const ProfileScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: editProfileScreen, page: () => const EditProfileScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: transactionHistoryScreen, page: () => const TransactionsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: kycScreen, page: () => const KycScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: depositWebViewScreen, page: () => MyWebViewScreen(redirectUrl: Get.arguments[0], isBoost: Get.arguments[1])),
    GetPage(name: depositsHistoryScreen, page: () => const DepositsHistoryScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: newDepositScreenScreen, page: () => const NewDepositScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: emailVerificationScreen, page: () => const EmailVerificationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: smsVerificationScreen, page: () => const SmsVerificationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: verifyPassCodeScreen, page: () => const VerifyForgetPassScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: resetPasswordScreen, page: () => const ResetPasswordScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: twoFactorScreen, page: () => const TwoFactorVerificationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: kycScreen, page: () => const KycScreen(), transition: Transition.fadeIn, fullscreenDialog: true, popGesture: false, transitionDuration: const Duration(milliseconds: 300)),
    GetPage(name: privacyScreen, page: () => const PrivacyPolicyScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: twoFactorSetupScreen, page: () => const TwoFactorSetupScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: languageScreen, page: () => const LanguageScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: allTicketScreen, page: () => const AllTicketScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: ticketDetailsScreen, page: () => const TicketDetailsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: newTicketScreen, page: () => const NewTicketScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: previewImageScreen, page: () => PreviewImage(url: Get.arguments)),
    GetPage(name: faqScreen, page: () => const FaqScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: notificationScreen, page: () => const NotificationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: componentScreen, page: () => const ComponentScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: plateDetailsScreen, page: () => const PlateDetailsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: carPlatesScreen, page: () => const CarPlatesScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: requestPlatesScreen, page: () => const RequestPlatesScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: requestPlateDetailsScreen, page: () => const RequestPlateDetailsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: myAdsScreen, page: () => const MyAdsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: myAdsPlateDetailsScreen, page: () => const MyAdsPlateDetailsScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: listPlateScreen, page: () => const ListPlateScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: payNowScreen, page: () => const PayNowScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: paymentConfirmationScreen, page: () => const PaymentConfirmationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: promotePlanScreen, page: () => const PromotePlanScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: promotionConfirmationScreen, page: () => const PromotionConfirmationScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: quickSalesScreen, page: () => const QuickSaleScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
    GetPage(name: watchlistScreen, page: () => const WatchlistScreen(), transitionDuration: const Duration(milliseconds: 400), transition: Transition.fadeIn),
  ];

  static Future<void> checkUserStatusAndGoToNextStep(GlobalUser? user, {bool isRemember = false, String accessToken = "", String tokenType = ""}) async {
    bool needEmailVerification = user?.ev == "1" ? false : true;
    bool needSmsVerification = user?.sv == '1' ? false : true;
    bool isTwoFactorEnable = user?.tv == '1' ? false : true;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (isRemember) {
      await sharedPreferences.setBool(SharedPreferenceService.rememberMeKey, true);
    } else {
      await sharedPreferences.setBool(SharedPreferenceService.rememberMeKey, false);
    }

    await sharedPreferences.setString(SharedPreferenceService.userIdKey, user?.id.toString() ?? '-1');
    await sharedPreferences.setString(SharedPreferenceService.userEmailKey, user?.email ?? '');
    await sharedPreferences.setString(SharedPreferenceService.userPhoneNumberKey, user?.mobile ?? '');
    await sharedPreferences.setString(SharedPreferenceService.userNameKey, user?.username ?? '');

    if (accessToken.isNotEmpty) {
      await sharedPreferences.setString(SharedPreferenceService.accessTokenKey, accessToken);
      await sharedPreferences.setString(SharedPreferenceService.accessTokenType, tokenType);
    }

    bool isProfileCompleteEnable = user?.profileComplete == '0' ? true : false;
    await SharedPreferenceService.setUserData(user ?? GlobalUser());
    print("${user?.imagePath}");
    print("..............................................");
    if (isProfileCompleteEnable) {
      Get.offAndToNamed(RouteHelper.profileCompleteScreen);
    } else if (needEmailVerification) {
      Get.offAndToNamed(RouteHelper.emailVerificationScreen);
    } else if (needSmsVerification) {
      Get.offAndToNamed(RouteHelper.smsVerificationScreen);
    }
    //  else if (isTwoFactorEnable) {
    //   Get.offAndToNamed(RouteHelper.twoFactorScreen);
    // }
    else {
      Get.offAndToNamed(RouteHelper.bottomNavBar, arguments: [true]);
    }
  }
}
