import 'dart:convert';

import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';
import 'package:ovolutter/data/model/quick_sales/quick_sales_response_model.dart';
import 'package:ovolutter/data/repo/plate_details/plate_details_repo.dart';
import 'package:ovolutter/data/repo/quick_sales/quick_sales_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class PlateDetailsController extends GetxController {
  MyAdsPlateDetailsRepo repo;

  PlateDetailsController({required this.repo});
  bool isAdvanceSearch = false;
  bool isLoading = false;
  String defaultCurrency = "";
  String imagePath = "";
  String id = "";
  GlobalUser user = GlobalUser();

  AdsData? adsData;
  SimilarAd? similarAd;

  List<QuickSalesData> quickSales = [];
  void changeAdvanceSearchStatus() {
    isAdvanceSearch = !isAdvanceSearch;
    update();
  }

  void plateDetailsData() async {
    isLoading = true;
    update();

    try {
      ResponseModel responseModel = await repo.plateDetailsRepo(id);

      if (responseModel.statusCode == 200) {
        AdsDetailsResponseModel model = adsDetailsResponseModelFromJson(jsonEncode(responseModel.responseJson));

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          adsData = model.data?.ad ?? AdsData();
          similarAd = model.data?.similarAd ?? SimilarAd();
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();
          // imagePath = model.data?.quicksales?.path ?? "";
          user = SharedPreferenceService.getUserData();
          update();
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.requestFail]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      isLoading = false;
      update();
    } finally {
      isLoading = false;
      update();
    }
  }
}
