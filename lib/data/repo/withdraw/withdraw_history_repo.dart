import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class WithdrawHistoryRepo {
  Future<ResponseModel> getWithdrawHistoryData(int page, {String searchText = ""}) async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.withdrawHistoryUrl}?page=$page&search=$searchText";
    ResponseModel responseModel = await ApiService.getRequest(
      url,
    );
    return responseModel;
  }
}
