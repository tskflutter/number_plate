import 'dart:convert';
import 'package:ovolutter/data/model/country_model/country_model.dart';
import 'package:ovolutter/data/model/general_setting/general_setting_response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  // Define keys as constants
  static const String accessTokenKey = 'access_token';
  static const String accessTokenType = 'access_type';
  static const String resetPassTokenKey = 'reset_pass_token';
  static const String userEmailKey = 'user_email';
  static const String userNameKey = 'user_name';
  static const String userPhoneNumberKey = 'user_phone_number';
  static const String rememberMeKey = 'remember me';
  static const String generalSettingKey = 'general-setting-key';
  static const String adsDataKey = 'ads-data-key';
  static const String userDataKey = 'user-data-key';
  static const String moduleSettingKey = 'module-setting-key';
  static const String fcmDeviceKey = 'device-key';
  static const String needTwoFactorVerification = 'need-tfa';
  static const String userIdKey = 'user_id';
  static const String hasNewNotificationKey = 'new-notification-key';
  static const String theme = 'theme';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageImagePath = 'language_image_path';
  static const String languageCode = 'language_code';
  static const String languageKey = 'language-key';
  static const String languageListKey = 'language-list-key';
  static const String countryJsonData = 'country_json_data';
  static const String onboardImagePath = 'onboard-image-path';
  static SharedPreferences? _prefs;

  /// Initialize SharedPreferences instance
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Returns true if the persistent storage contains the given [key].
  static bool containsKey(String key, {bool defaultValue = false}) {
    return _prefs?.containsKey(key) ?? defaultValue;
  }

  /// Save a string value to SharedPreferences
  static Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  /// Get a string value from SharedPreferences
  static String getString(String key, {String defaultValue = ''}) {
    return _prefs?.getString(key) ?? defaultValue;
  }

  /// Save a boolean value to SharedPreferences
  static Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  /// Get a boolean value from SharedPreferences
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }

  /// Save an integer value to SharedPreferences
  static Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  /// Get an integer value from SharedPreferences
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }

  /// Remove a key from SharedPreferences
  static Future<void> remove(String key) async {
    await _prefs?.remove(key);
  }

  /// Store a JSON object (e.g., General Setting) to SharedPreferences
  static Future<void> setJsonObject(String key, Map<String, dynamic> jsonObject) async {
    String jsonString = jsonEncode(jsonObject);
    await _prefs?.setString(key, jsonString);
  }

  /// Retrieve a JSON object from SharedPreferences
  static Map<String, dynamic> getJsonObject(String key) {
    String? jsonString = _prefs?.getString(key);
    return jsonString != null ? jsonDecode(jsonString) : {};
  }

  /// set theme current type as light theme
  static Future<void> setThemeIsLight(bool lightTheme) => setBool(theme, lightTheme);

  /// get if the current theme type is light
  static bool getThemeIsLight() => getBool(theme, defaultValue: true); // todo set the default theme (true for light, false for dark)

  /// save current locale
  static Future<void> setCurrentLanguage(String value) => setString(languageCode, value);

  /// get current locale
  // static Locale getCurrentLocal() {
  //   String? langCode = _sharedPreferences.getString(_currentLocalKey);
  //   // default language is english
  //   if (langCode == null) {
  //     return LocalizationService.defaultLanguage;
  //   }
  //   return LocalizationService.supportedLanguages[langCode]!;
  // }

  /// Example methods to store and retrieve specific data using predefined keys
  static Future<void> setAccessToken(String token) async {
    await setString(accessTokenKey, token);
  }

  static String getAccessToken() {
    return getString(accessTokenKey);
  }

  static Future<void> setUserEmail(String email) async {
    await setString(userEmailKey, email);
  }

  static String getUserEmail() {
    return getString(userEmailKey);
  }

  static Future<void> setUserName(String name) async {
    await setString(userNameKey, name);
  }

  static String getUserName() {
    return getString(userNameKey);
  }

  static Future<void> setRememberMe(bool rememberMe) async {
    await setBool(rememberMeKey, rememberMe);
  }

  static bool getRememberMe() {
    return getBool(rememberMeKey);
  }

  static Future<void> setGeneralSettingData(GeneralSettingResponseModel model) async {
    await setJsonObject(generalSettingKey, model.toJson());
  }

  static GeneralSettingResponseModel getGeneralSettingData() {
    var getGsData = getJsonObject(generalSettingKey);
    return GeneralSettingResponseModel.fromJson(getGsData);
  }

  static Future<void> setMyAdsData(AdsData model) async {
    await setJsonObject(adsDataKey, model.toJson());
  }

  static AdsData getAdsData() {
    var myAds = getJsonObject(adsDataKey);
    return AdsData.fromJson(myAds);
  }

  static Future<void> setUserData(GlobalUser model) async {
    await setJsonObject(userDataKey, model.toJson());
  }

  static GlobalUser getUserData() {
    var getUserData = getJsonObject(userDataKey);
    // Add debug print to see what's being retrieved
    print("Retrieved user data: $getUserData");

    if (getUserData.isEmpty) {
      return GlobalUser();
    }
    return GlobalUser.fromJson(getUserData);
  }

  static String getCurrencySymbol() {
    return getGeneralSettingData().data?.generalSetting?.curSym ?? "";
  }

  static Future<void> setCountryJsonDataData(CountryModel model) async {
    await setJsonObject(countryJsonData, model.toJson());
  }

  static CountryModel getCountryJsonDataData() {
    var getData = getJsonObject(countryJsonData);
    return CountryModel.fromJson(getData);
  }
  // You can add similar methods for other keys as needed.
}
