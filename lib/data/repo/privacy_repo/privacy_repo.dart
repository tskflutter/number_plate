import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/services/api_service.dart';

class PrivacyRepo{


  Future<dynamic>loadAboutData()async{

    String url='${UrlContainer.baseUrl}${UrlContainer.privacyPolicyEndPoint}';
    final response=await ApiService.getRequest(url);
    return response;

  }

}