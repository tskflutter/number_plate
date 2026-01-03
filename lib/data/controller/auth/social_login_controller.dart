import 'package:flutter/cupertino.dart';
import 'package:ovolutter/core/route/route.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/core/utils/util.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';

import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

import '../../model/auth/login/login_response_model.dart';
import '../../model/global/response_model/response_model.dart';
import '../../repo/auth/social_login_repo.dart';

class SocialLoginController extends GetxController {
  SocialLoginRepo repo;
  SocialLoginController({required this.repo});

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  bool isGoogleSignInLoading = false;

  Future<void> signInWithGoogle() async {
    try {
      isGoogleSignInLoading = true;
      update();
      const List<String> scopes = <String>['email', 'profile'];
      googleSignIn.signOut();
      await googleSignIn.initialize();
      var googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      if (googleAuth.idToken == null) {
        isGoogleSignInLoading = false;
        update();
        return;
      }
      final GoogleSignInClientAuthorization? authorization = await googleUser.authorizationClient.authorizationForScopes(scopes);
      printX(authorization?.accessToken);

      await socialLoginUser(
        provider: 'google',
        accessToken: authorization?.accessToken ?? '',
      );
    } catch (e) {
      printX(e.toString());
      // CustomSnackBar.error(errorList: [e.toString()]);
    }

    isGoogleSignInLoading = false;
    update();
  }

  //SIGN IN With LinkeDin
  bool isLinkedinLoading = false;
  Future<void> signInWithLinkedin(BuildContext context) async {
    // try {
    isLinkedinLoading = false;
    update();
    //TODO
    //   SocialiteCredentials linkedinCredential = repo.apiClient.getSocialCredentialsConfigData();
    //   String linkedinCredentialRedirectUrl = "${repo.apiClient.getSocialCredentialsRedirectUrl()}/linkedin";
    //   printX(linkedinCredentialRedirectUrl);
    //   printX(linkedinCredential.linkedin?.toJson());
    //   SignInWithLinkedIn.signIn(
    //     context,
    //     config: LinkedInConfig(clientId: linkedinCredential.linkedin?.clientId ?? '', clientSecret: linkedinCredential.linkedin?.clientSecret ?? '', scope: ['openid', 'profile', 'email'], redirectUrl: "$linkedinCredentialRedirectUrl"),
    //     onGetAuthToken: (data) {
    //       printX('Auth token data: ${data.toJson()}');
    //     },
    //     onGetUserProfile: (token, user) async {
    //       printX('${token.idToken}-');
    //       printX('LinkedIn User: ${user.toJson()}');
    //       await socialLoginUser(provider: 'linkedin', accessToken: token.accessToken ?? '');
    //     },
    //     onSignInError: (error) {
    //       printX('Error on sign in: $error');
    //       CustomSnackBar.error(errorList: [error.description!] ?? [MyStrings.loginFailedTryAgain.tr]);
    //       isLinkedinLoading = false;
    //       update();
    //     },
    //   );
    // } catch (e) {
    //   debugPrint(e.toString());

    //   CustomSnackBar.error(errorList: [e.toString()]);
  }

  Future socialLoginUser({
    String accessToken = '',
    String? provider,
  }) async {
    try {
      ResponseModel responseModel = await repo.socialLoginUser(
        accessToken: accessToken,
        provider: provider,
      );
      if (responseModel.statusCode == 200) {
        LoginResponseModel loginModel = LoginResponseModel.fromJson(responseModel.responseJson);
        if (loginModel.status.toString().toLowerCase() == MyStrings.success.toLowerCase()) {
          String accessToken = loginModel.data?.accessToken ?? "";
          String tokenType = loginModel.data?.tokenType ?? "";
          GlobalUser? user = loginModel.data?.user;
          await RouteHelper.checkUserStatusAndGoToNextStep(user, accessToken: accessToken, tokenType: tokenType, isRemember: true);
        } else {
          CustomSnackBar.error(errorList: loginModel.message ?? [MyStrings.loginFailedTryAgain.tr]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      //printx(e.toString());
    }
  }

  bool checkSocialAuthActiveOrNot({String provider = 'all'}) {
    var socialCredential = SharedPreferenceService.getGeneralSettingData().data?.generalSetting?.socialiteCredentials;
    if (provider == 'google') {
      return socialCredential?.google?.status == '1';
    } else if (provider == 'facebook') {
      return socialCredential?.facebook?.status == '1';
    } else if (provider == 'linkedin') {
      return socialCredential?.linkedin?.status == '1';
    } else {
      return (socialCredential?.google?.status == '1') || (socialCredential?.facebook?.status == '1') || (socialCredential?.linkedin?.status == '1');
    }
  }
}
