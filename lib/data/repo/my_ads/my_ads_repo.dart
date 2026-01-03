import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class MyAdsRepo {
  Future<ResponseModel> getMyAdsRepo({
    String digitCount = "",
    String cityId = "",
    String contains = "",
    String startWith = "",
    String endWith = "",
    String minPrice = "",
    String maxPrice = "",
    String status = "", // For filtering by ad status (active, pending, etc.)
  }) async {
    final queryParams = {
      'digit_count': digitCount,
      'city_id': cityId,
      'contains': contains,
      'start_with': startWith,
      'end_with': endWith,
      'min_price': minPrice,
      'max_price': maxPrice,
      'status': status,
    };

    queryParams.removeWhere((key, value) => value.isEmpty);

    final uri = Uri.parse(
      '${UrlContainer.baseUrl}${UrlContainer.myAdsEndPoint}',
    ).replace(queryParameters: queryParams);

    ResponseModel responseModel = await ApiService.getRequest(
      uri.toString(),
    );

    return responseModel;
  }

  Future<ResponseModel> plateDetailsRepo(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.plateDetailsEndPoint}$id';
    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }

  Future<ResponseModel> plateDeleteRepo(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.plateDeleteEndPoint}$id';
    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }

  Future<ResponseModel> plateWatchRepo(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.plateWatchEndPoint}$id';
    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }

  Future<ResponseModel> plateSoldRepo(String id) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.plateSoldEndPoint}$id';
    ResponseModel responseModel = await ApiService.getRequest(url);
    return responseModel;
  }
}
