import 'package:get/get.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/repo/pay_now/pay_now_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class PayNowController extends GetxController {
  PayNowRepo repo;

  PayNowController({required this.repo});

  String firstListingFee = "";
  String listingFee = "";
  String nextListingFee = "";
  String defaultCurrency = "";
  String discountPercentage = "0";
  AdsData? myAdsData;

  void getData() {
    final model = SharedPreferenceService.getGeneralSettingData();

    firstListingFee = model.data?.generalSetting?.firstListingFee ?? "";
    nextListingFee = model.data?.generalSetting?.multipleListingFee ?? "";
    defaultCurrency = model.data?.generalSetting?.curText ?? "";

    calculateDiscountPercentage();

    update();
  }

  void calculateDiscountPercentage() {
    try {
      double firstFee = double.parse(firstListingFee);
      double nextFee = double.parse(nextListingFee);

      if (firstFee > 0 && nextFee < firstFee) {
        double discount = ((firstFee - nextFee) / firstFee) * 100;
        discountPercentage = discount.toStringAsFixed(0);
      } else {
        discountPercentage = "0";
      }
    } catch (e) {
      discountPercentage = "0";
    }
  }
}
