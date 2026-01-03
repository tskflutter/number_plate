import 'package:ovolutter/environment.dart';

class UrlContainer {
  static const String domainUrl = Environment.MAIN_API_URL;
  static const String baseUrl = '$domainUrl/api/';

  static const String socialLoginEndPoint = 'social-login';
  static const String dashBoardEndPoint = 'dashboard';
  static const String depositHistoryUrl = 'deposit/history';
  static const String depositMethodUrl = 'deposit/methods';
  static const String depositInsertUrl = 'deposit/insert';

  static const String accountDisable = "delete-account";

  static const String notificationEndPoint = 'push-notifications';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String logoutUrl = 'logout';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint = 'password/reset';
  static const String verify2FAUrl = 'verify-g2fa';

  static const String deviceTokenUrl = 'add-device-token';

  static const String otpVerify = 'otp-verify';
  static const String otpResend = 'otp-resend';

  static const String verifyEmailEndPoint = 'verify-email';
  static const String verifySmsEndPoint = 'verify-mobile';
  static const String resendVerifyCodeEndPoint = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';

  static const String dashBoardUrl = 'dashboard';
  static const String transactionEndpoint = 'transactions';

  static const String addWithdrawRequestUrl = 'withdraw-request';
  static const String withdrawMethodUrl = 'withdraw-method';
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl = 'withdraw/history';
  static const String withdrawStoreUrl = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';

  static const String kycFormUrl = 'kyc-form';
  static const String kycSubmitUrl = 'kyc-submit';

  static const String generalSettingEndPoint = 'general-setting';
  //static const String moduleSettingEndPoint        = 'module-setting';

  static const String privacyPolicyEndPoint = 'policies';
  static const String getProfileEndPoint = 'user-info';
  static const String updateProfileEndPoint = 'profile-setting';
  static const String profileCompleteEndPoint = 'user-data-submit';

  static const String changePasswordEndPoint = 'change-password';
  static const String countryEndPoint = 'get-countries';

  static const String deviceTokenEndPoint = 'add-device-token';
  static const String languageUrl = 'language/';

  static const String twoFactor = "twofactor";
  static const String twoFactorEnable = "twofactor/enable";
  static const String twoFactorDisable = "twofactor/disable";

  static const String communityGroupsEndPoint = 'community-groups';

  static const String supportMethodsEndPoint = 'support/method';
  static const String supportListEndPoint = 'ticket';
  static const String storeSupportEndPoint = 'ticket/create';
  static const String supportViewEndPoint = 'ticket/view';
  static const String supportReplyEndPoint = 'ticket/reply';
  static const String supportCloseEndPoint = 'ticket/close';
  static const String supportDownloadEndPoint = 'ticket/download';
  static const String countryFlagImageLink = 'https://flagpedia.net/data/flags/h24/{countryCode}.webp';
  static const String faqEndPoint = 'faq';

  //my ads
  static const String myAdsEndPoint = 'ad/my-list';
  //my request
  static const String myRequestAdsEndPoint = 'ad/my-request-list';
  //quick sales
  static const String quickSalesEndPoint = 'ad/quicksale';
  //plate details
  static const String plateDetailsEndPoint = 'ad/details/';
  static const String plateDeleteEndPoint = 'ad/delete/';
  static const String plateSoldEndPoint = 'ad/sold/';
  static const String plateWatchEndPoint = 'watchlist/';
  //dashboard
  static const String dashboardEndPoint = 'dashboard';
  static const String userDashboardEndPoint = 'user-dashboard';
  //watchlist
  static const String watchListEndPoint = 'watchlist';
  //car plates
  static const String carPlatesEndPoint = 'ad/list';
  //car plates
  static const String listAdEndPoint = 'ad/create-data';
  static const String listAdRequestEndPoint = 'ad/request';

  static const String addPlateEndPoint = 'ad/create';

  //deposit
  static const String depositEndPoint = 'ad/payment';
  //boosting
  static const String boostingAdEndPoint = 'ad-boost/boosting/';
  static const String paymentAdEndPoint = 'ad-boost/payment';

  static const String supportImagePath = '$domainUrl/assets/support/';
  static const String withDrawImagePath = '$domainUrl/assets/images/withdraw_method/';
}
