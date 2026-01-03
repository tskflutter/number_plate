import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/auth/sign_up_model/sign_up_model.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';


class RegistrationRepo {


  Future<ResponseModel> registerUser(SignUpModel model) async {
    final map = model.toMap();
    String url ='${UrlContainer.baseUrl}${UrlContainer.registrationEndPoint}';
    ResponseModel responseModel = await  ApiService.postRequest(url,map);
    return responseModel;
  }

}