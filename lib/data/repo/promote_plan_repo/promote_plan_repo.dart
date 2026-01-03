import 'package:intl/intl.dart';
import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class PromotePlanRepo {
  Future<ResponseModel> boosting(String id, boostingType, startDate, endDate) async {
    String formattedStartDate = startDate != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate) : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    String formattedEndDate = endDate != null ? DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate) : DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    Map<String, String> map = {
      'boosting_type': boostingType,
      'boosting_start': formattedStartDate,
      'boosting_end': formattedEndDate,
    };
    String url = '${UrlContainer.baseUrl}${UrlContainer.boostingAdEndPoint}$id';

    ResponseModel responseModel = await ApiService.postRequest(
      url,
      map,
    );
    return responseModel;
  }
}
