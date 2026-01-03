import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class QuickSalesRepo {
  Future<ResponseModel> quickSalesRepo(String page) async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.quickSalesEndPoint}?page=$page';
    ResponseModel responseModel = await ApiService.getRequest(
      url,
    );

    return responseModel;
  }
}
