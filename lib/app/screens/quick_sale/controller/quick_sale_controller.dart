import 'dart:convert';

import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/quick_sales/quick_sales_response_model.dart';
import 'package:ovolutter/data/repo/quick_sales/quick_sales_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class QuickSaleController extends GetxController {
  QuickSalesRepo repo;

  QuickSaleController({required this.repo});

  bool isAdvanceSearch = false;
  bool isLoading = false;
  String defaultCurrency = "";
  String imagePath = "";

  // Pagination
  int page = 0;
  String? nextPageUrl;
  GlobalUser user = GlobalUser();
  List<QuickSalesData> quickSales = [];

  void changeAdvanceSearchStatus() {
    isAdvanceSearch = !isAdvanceSearch;
    update();
  }

  // Load data - clears list and resets pagination
  loadData() async {
    quickSales.clear();
    page = 0;
    isLoading = true;
    update();
    await quickSalesData();
    isLoading = false;
    update();
  }

  // Check if there's a next page
  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty;
  }

  // Fetch quick sales data with pagination
  Future<void> quickSalesData() async {
    page = page + 1;

    if (page == 1) {
      quickSales.clear();
      update();
    }

    isLoading = true;
    update();

    try {
      ResponseModel responseModel = await repo.quickSalesRepo(page.toString());

      if (responseModel.statusCode == 200) {
        QuickSalesResponseModel model = quickSalesResponseModelFromJson(jsonEncode(responseModel.responseJson));

        if (model.status.toString() == MyStrings.success.toString().toLowerCase()) {
          defaultCurrency = SharedPreferenceService.getCurrencySymbol();
          imagePath = model.data?.quicksales?.path ?? "";
          user = SharedPreferenceService.getUserData();
          // Update next page URL for pagination
          nextPageUrl = model.data?.quicksales?.nextPageUrl;

          // Get the data from current page
          List<QuickSalesData>? tempList = model.data?.quicksales?.data;

          if (tempList != null && tempList.isNotEmpty) {
            quickSales.addAll(tempList);
          }

          update();
        } else {
          CustomSnackBar.error(errorList: model.message ?? [MyStrings.requestFail]);
        }
      } else {
        CustomSnackBar.error(errorList: [responseModel.message]);
      }
    } catch (e) {
      print('Error fetching quick sales: $e');
      CustomSnackBar.error(errorList: [MyStrings.requestFail]);
    } finally {
      isLoading = false;
      update();
    }
  }
}
