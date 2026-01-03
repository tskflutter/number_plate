import 'package:get/get.dart';
import 'package:ovolutter/app/components/snack_bar/show_custom_snackbar.dart';
import 'package:ovolutter/core/utils/my_strings.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/watchlist/watchlist_response_model.dart';
import 'package:ovolutter/data/repo/watchlist/watchlist_repo.dart';
import 'package:ovolutter/data/services/shared_pref_service.dart';

class WatchlistScreenController extends GetxController {
  WatchlistRepo repo;

  WatchlistScreenController({required this.repo});
  bool isAdvanceSearch = false;
  bool isLoading = false;
  bool isLoadMore = false;

  int page = 0;
  String? nextPageUrl;
  bool latestAdsLoading = false;
  bool vipAdsLoading = false;
  bool featuredAdsLoading = false;
  String defaultCurrency = "";
  List<WatchlistData> watchlistData = [];
  String id = "";

  Future<void> loadData() async {
    watchlistData.clear();
    page = 0;
    isLoading = true;
    update();
    await getWatchlistData();
    isLoading = false;
    update();
  }

  Future<void> getWatchlistData({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasNext() || isLoadMore) return;
      isLoadMore = true;
    } else {
      isLoading = true;
      page = 0;
      watchlistData.clear();
    }

    update();

    page++;

    ResponseModel responseModel = await repo.watchlistRepo(page: page.toString());

    if (responseModel.statusCode == 200) {
      WatchListResponseModel model = WatchListResponseModel.fromJson(responseModel.responseJson);

      if (model.status == MyStrings.success) {
        defaultCurrency = SharedPreferenceService.getCurrencySymbol();
        nextPageUrl = model.data?.watchlists?.nextPageUrl;

        final tempList = model.data?.watchlists?.data;
        if (tempList != null && tempList.isNotEmpty) {
          watchlistData.addAll(tempList);
        }
      } else {
        CustomSnackBar.error(errorList: model.message ?? [MyStrings.somethingWentWrong]);
      }
    } else {
      CustomSnackBar.error(errorList: [responseModel.message]);
    }

    isLoading = false;
    isLoadMore = false;
    update();
  }

  bool hasNext() {
    return nextPageUrl != null && nextPageUrl!.isNotEmpty;
  }
}
