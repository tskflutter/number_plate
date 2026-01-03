import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class CarPlatesRepo {
  Future<ResponseModel> carPlatesRepo({
    String page = "1",
    String digitCount = "",
    String cityId = "",
    String contains = "",
    String startWith = "",
    String endWith = "",
    String minPrice = "",
    String maxPrice = "",
  }) async {
    final queryParams = {
      'page': page,
      'digit_count': digitCount,
      'city_id': cityId,
      'contains': contains,
      'start_with': startWith,
      'end_with': endWith,
      'min_price': minPrice,
      'max_price': maxPrice,
    };

    queryParams.removeWhere((key, value) => value.isEmpty);

    final uri = Uri.parse(
      '${UrlContainer.baseUrl}${UrlContainer.carPlatesEndPoint}',
    ).replace(queryParameters: queryParams);

    ResponseModel responseModel = await ApiService.getRequest(
      uri.toString(),
    );

    return responseModel;
  }
}
