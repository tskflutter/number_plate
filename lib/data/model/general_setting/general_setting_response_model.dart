// To parse this JSON data, do
//
//     final generalSettingResponseModel = generalSettingResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';

GeneralSettingResponseModel generalSettingResponseModelFromJson(String str) => GeneralSettingResponseModel.fromJson(json.decode(str));

String generalSettingResponseModelToJson(GeneralSettingResponseModel data) => json.encode(data.toJson());

class GeneralSettingResponseModel {
  String? remark;
  String? status;
  List<String>? message;
  Data? data;

  GeneralSettingResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory GeneralSettingResponseModel.fromJson(Map<String, dynamic> json) => GeneralSettingResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: (json["message"] as List<dynamic>).toStringList(),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  GeneralSetting? generalSetting;
  String? socialLoginRedirect;
  final String? splashScreenFilePath;
  final String? onboardingScreenFilePath;
  final String? carPlateScreenFilePath;
  final List<City>? cities;

  Data({
    this.generalSetting,
    this.socialLoginRedirect,
    this.splashScreenFilePath,
    this.onboardingScreenFilePath,
    this.carPlateScreenFilePath,
    this.cities,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        generalSetting: json["general_setting"] == null ? null : GeneralSetting.fromJson(json["general_setting"]),
        socialLoginRedirect: json["social_login_redirect"],
        splashScreenFilePath: json["splash_screen_file_path"]?.toString(),
        onboardingScreenFilePath: json["onboarding_screen_file_path"]?.toString(),
        carPlateScreenFilePath: json["car_plate_screen_file_path"]?.toString(),
        cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "general_setting": generalSetting?.toJson(),
        "social_login_redirect": socialLoginRedirect,
        "splash_screen_file_path": splashScreenFilePath,
        "onboarding_screen_file_path": onboardingScreenFilePath,
        "car_plate_screen_file_path": carPlateScreenFilePath,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
      };
}

class GeneralSetting {
  int? id;
  String? siteName;
  String? curText;
  String? curSym;
  String? emailFrom;
  String? emailFromName;
  String? smsTemplate;
  String? smsFrom;
  String? pushTitle;
  String? pushTemplate;
  String? baseColor;
  String? secondaryColor;
  FirebaseConfig? firebaseConfig;
  GlobalShortcodes? globalShortcodes;
  String? kv;
  String? ev;
  String? en;
  String? sv;
  String? sn;
  String? pn;
  String? forceSsl;
  String? inAppPayment;
  String? maintenanceMode;
  String? securePassword;
  String? agree;
  String? multiLanguage;
  String? registration;
  String? activeTemplate;
  SocialiteCredentials? socialiteCredentials;
  String? lastCron;
  String? availableVersion;
  String? systemCustomized;
  String? paginateNumber;
  String? currencyFormat;
  dynamic createdAt;
  String? updatedAt;
  String? splashScreen;
  String? carPlateScreen;
  List<OnboardingScreen>? onboardingScreen;
  List<OtherScreen>? otherScreens;
  String? firstListingFee;
  String? multipleListingFee;
  String? vipListingFee;
  String? featureListingFee;

  GeneralSetting({
    this.id,
    this.splashScreen,
    this.siteName,
    this.carPlateScreen,
    this.otherScreens,
    this.onboardingScreen,
    this.curText,
    this.curSym,
    this.emailFrom,
    this.emailFromName,
    this.smsTemplate,
    this.smsFrom,
    this.pushTitle,
    this.pushTemplate,
    this.baseColor,
    this.secondaryColor,
    this.firebaseConfig,
    this.globalShortcodes,
    this.kv,
    this.ev,
    this.en,
    this.sv,
    this.sn,
    this.pn,
    this.forceSsl,
    this.inAppPayment,
    this.maintenanceMode,
    this.securePassword,
    this.agree,
    this.multiLanguage,
    this.registration,
    this.activeTemplate,
    this.socialiteCredentials,
    this.lastCron,
    this.availableVersion,
    this.systemCustomized,
    this.paginateNumber,
    this.currencyFormat,
    this.createdAt,
    this.updatedAt,
    this.firstListingFee,
    this.multipleListingFee,
    this.featureListingFee,
    this.vipListingFee,
  });

  factory GeneralSetting.fromJson(Map<String, dynamic> json) => GeneralSetting(
        id: json["id"],
        siteName: json["site_name"].toString(),
        curText: json["cur_text"].toString(),
        otherScreens: json["other_screens"] == null ? [] : List<OtherScreen>.from(json["other_screens"]!.map((x) => OtherScreen.fromJson(x))),
        curSym: json["cur_sym"].toString(),
        carPlateScreen: json["car_plate_screen"].toString(),
        emailFrom: json["email_from"].toString(),
        emailFromName: json["email_from_name"].toString(),
        smsTemplate: json["sms_template"],
        smsFrom: json["sms_from"].toString(),
        pushTitle: json["push_title"].toString(),
        pushTemplate: json["push_template"].toString(),
        baseColor: json["base_color"].toString(),
        secondaryColor: json["secondary_color"].toString(),
        firebaseConfig: json["firebase_config"] == null ? null : FirebaseConfig.fromJson(json["firebase_config"]),
        globalShortcodes: json["global_shortcodes"] == null ? null : GlobalShortcodes.fromJson(json["global_shortcodes"]),
        kv: json["kv"].toString(),
        ev: json["ev"].toString(),
        en: json["en"].toString(),
        sv: json["sv"].toString(),
        sn: json["sn"].toString(),
        pn: json["pn"].toString(),
        forceSsl: json["force_ssl"].toString(),
        inAppPayment: json["in_app_payment"].toString(),
        maintenanceMode: json["maintenance_mode"].toString(),
        securePassword: json["secure_password"].toString(),
        agree: json["agree"].toString(),
        multiLanguage: json["multi_language"].toString(),
        registration: json["registration"].toString(),
        activeTemplate: json["active_template"].toString(),
        socialiteCredentials: json["socialite_credentials"] == null ? null : SocialiteCredentials.fromJson(json["socialite_credentials"]),
        lastCron: json["last_cron"].toString(),
        availableVersion: json["available_version"].toString(),
        systemCustomized: json["system_customized"].toString(),
        paginateNumber: json["paginate_number"].toString(),
        currencyFormat: json["currency_format"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        firstListingFee: json["first_listing_fee"]?.toString(),
        multipleListingFee: json["multiple_listing_fee"]?.toString(),
        vipListingFee: json["vip_promotion_fee"]?.toString(),
        featureListingFee: json["featured_promotion_fee"]?.toString(),
        splashScreen: json["splash_screen"],
        onboardingScreen: json["onboarding_screen"] == null ? [] : List<OnboardingScreen>.from(json["onboarding_screen"]!.map((x) => OnboardingScreen.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "site_name": siteName,
        "cur_text": curText,
        "cur_sym": curSym,
        "car_plate_screen": carPlateScreen,
        "other_screens": otherScreens == null ? [] : List<dynamic>.from(otherScreens!.map((x) => x.toJson())),
        "email_from": emailFrom,
        "email_from_name": emailFromName,
        "sms_template": smsTemplate,
        "sms_from": smsFrom,
        "push_title": pushTitle,
        "push_template": pushTemplate,
        "base_color": baseColor,
        "secondary_color": secondaryColor,
        "firebase_config": firebaseConfig?.toJson(),
        "global_shortcodes": globalShortcodes?.toJson(),
        "kv": kv,
        "ev": ev,
        "en": en,
        "sv": sv,
        "sn": sn,
        "pn": pn,
        "force_ssl": forceSsl,
        "in_app_payment": inAppPayment,
        "maintenance_mode": maintenanceMode,
        "secure_password": securePassword,
        "agree": agree,
        "multi_language": multiLanguage,
        "first_listing_fee": firstListingFee,
        "multiple_listing_fee": multipleListingFee,
        "registration": registration,
        "active_template": activeTemplate,
        "socialite_credentials": socialiteCredentials?.toJson(),
        "last_cron": lastCron,
        "available_version": availableVersion,
        "system_customized": systemCustomized,
        "paginate_number": paginateNumber,
        "currency_format": currencyFormat,
        "created_at": createdAt,
        "featured_promotion_fee": featureListingFee,
        "vip_promotion_fee": vipListingFee,
        "updated_at": updatedAt,
        "splash_screen": splashScreen,
        "onboarding_screen": onboardingScreen == null ? [] : List<dynamic>.from(onboardingScreen!.map((x) => x.toJson())),
      };
}

class OtherScreen {
  final String? title;
  final String? slug;
  final String? image;

  OtherScreen({
    this.title,
    this.slug,
    this.image,
  });

  factory OtherScreen.fromJson(Map<String, dynamic> json) => OtherScreen(
        title: json["title"]?.toString(),
        slug: json["slug"]?.toString(),
        image: json["image"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "image": image,
      };
}

class OnboardingScreen {
  final String? onboardingImage;
  final String? onboardingTitle;
  final String? onboardingSubtitle;
  final String? onboardingDescription;

  OnboardingScreen({
    this.onboardingImage,
    this.onboardingTitle,
    this.onboardingSubtitle,
    this.onboardingDescription,
  });

  factory OnboardingScreen.fromJson(Map<String, dynamic> json) => OnboardingScreen(
        onboardingImage: json["onboarding_image"]?.toString(),
        onboardingTitle: json["onboarding_title"]?.toString(),
        onboardingSubtitle: json["onboarding_subtitle"]?.toString(),
        onboardingDescription: json["onboarding_description"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "onboarding_image": onboardingImage,
        "onboarding_title": onboardingTitle,
        "onboarding_subtitle": onboardingSubtitle,
        "onboarding_description": onboardingDescription,
      };
}

class FirebaseConfig {
  String? apiKey;
  String? authDomain;
  String? projectId;
  String? storageBucket;
  String? messagingSenderId;
  String? appId;
  String? measurementId;
  String? serverKey;

  FirebaseConfig({
    this.apiKey,
    this.authDomain,
    this.projectId,
    this.storageBucket,
    this.messagingSenderId,
    this.appId,
    this.measurementId,
    this.serverKey,
  });

  factory FirebaseConfig.fromJson(Map<String, dynamic> json) => FirebaseConfig(
        apiKey: json["apiKey"].toString(),
        authDomain: json["authDomain"].toString(),
        projectId: json["projectId"].toString(),
        storageBucket: json["storageBucket"].toString(),
        messagingSenderId: json["messagingSenderId"].toString(),
        appId: json["appId"].toString(),
        measurementId: json["measurementId"].toString(),
        serverKey: json["serverKey"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "apiKey": apiKey,
        "authDomain": authDomain,
        "projectId": projectId,
        "storageBucket": storageBucket,
        "messagingSenderId": messagingSenderId,
        "appId": appId,
        "measurementId": measurementId,
        "serverKey": serverKey,
      };
}

class GlobalShortcodes {
  String? siteName;
  String? siteCurrency;
  String? currencySymbol;

  GlobalShortcodes({
    this.siteName,
    this.siteCurrency,
    this.currencySymbol,
  });

  factory GlobalShortcodes.fromJson(Map<String, dynamic> json) => GlobalShortcodes(
        siteName: json["site_name"],
        siteCurrency: json["site_currency"],
        currencySymbol: json["currency_symbol"],
      );

  Map<String, dynamic> toJson() => {
        "site_name": siteName,
        "site_currency": siteCurrency,
        "currency_symbol": currencySymbol,
      };
}

class SocialiteCredentials {
  SocialiteCredentialsValue? google;
  SocialiteCredentialsValue? facebook;
  SocialiteCredentialsValue? linkedin;

  SocialiteCredentials({
    this.google,
    this.facebook,
    this.linkedin,
  });

  factory SocialiteCredentials.fromJson(Map<String, dynamic> json) => SocialiteCredentials(
        google: json["google"] == null ? null : SocialiteCredentialsValue.fromJson(json["google"]),
        facebook: json["facebook"] == null ? null : SocialiteCredentialsValue.fromJson(json["facebook"]),
        linkedin: json["linkedin"] == null ? null : SocialiteCredentialsValue.fromJson(json["linkedin"]),
      );

  Map<String, dynamic> toJson() => {
        "google": google?.toJson(),
        "facebook": facebook?.toJson(),
        "linkedin": linkedin?.toJson(),
      };
}

class SocialiteCredentialsValue {
  String? clientId;
  String? clientSecret;
  String? status;

  SocialiteCredentialsValue({
    this.clientId,
    this.clientSecret,
    this.status,
  });

  factory SocialiteCredentialsValue.fromJson(Map<String, dynamic> json) => SocialiteCredentialsValue(
        clientId: json["client_id"].toString(),
        clientSecret: json["client_secret"].toString(),
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "client_secret": clientSecret,
        "status": status,
      };
}
