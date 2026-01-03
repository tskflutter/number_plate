import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class HomeRepo {
  Future<ResponseModel> getData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.dashBoardUrl}";
    ResponseModel responseModel = await ApiService.getRequest(
      url,
    );
    return responseModel;
  }

  Future<dynamic> refreshGeneralSetting() async {
    /* String url = '${UrlContainer.baseUrl}${UrlContainer.generalSettingEndPoint}';
    ResponseModel response = await apiClient.request(url, Method.getMethod, null, passHeader: false);

    if (response.statusCode == 200) {
      GeneralSettingResponseModel model = GeneralSettingResponseModel.fromJson(response.responseJson);
      if (model.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
        apiClient.storeGeneralSetting(model);
      }
    }*/
  }

  Future<ResponseModel> getUserInfoData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}";
    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }

  Future<ResponseModel> homeRepo(String tabName, String page, String token) async {
    // Build URL with proper query parameters
    String url = '${UrlContainer.baseUrl}${token != "" ? UrlContainer.userDashboardEndPoint : UrlContainer.dashboardEndPoint}';

    // Add query parameters
    List<String> params = [];

    if (tabName.isNotEmpty) {
      params.add('boosting_type=$tabName');
    }

    params.add('page=$page');

    // Combine with ? for first param and & for rest
    url = '$url?${params.join('&')}';

    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }
}
