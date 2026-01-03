import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/model/list_plate/list_plate_data_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

class ListPlateRepo {
  Future<ResponseModel> listPlate(bool isrequest, ListPlateDataModel dataModel) async {
    print(isrequest);
    print(">>>>>>>>>>>><<<<<<<<<<<");
    Map<String, String> map = {
      'user_id': dataModel.userId,
      'price_type': dataModel.priceType,
      'price': dataModel.price,
      'plate_letter': dataModel.plateLetter,
      'plate_number': dataModel.plateNumber,
      'ad_type_id': dataModel.carId,
      'city_id': dataModel.cityId,
      'whatsapp_number': dataModel.whatsAppNumber,
      'phone_number': dataModel.phoneNumber,
    };
    String url = '${UrlContainer.baseUrl}${isrequest == true ? UrlContainer.listAdRequestEndPoint : UrlContainer.addPlateEndPoint}';
    final response = await ApiService.postRequest(url, map);
    return response;
  }

  Future<ResponseModel> getData() async {
    String url = "${UrlContainer.baseUrl}${UrlContainer.listAdEndPoint}";
    ResponseModel responseModel = await ApiService.getRequest(
      url,
    );
    return responseModel;
  }
}
