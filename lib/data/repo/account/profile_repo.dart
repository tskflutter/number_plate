import 'dart:io';

import 'package:ovolutter/core/utils/url_container.dart';
import 'package:ovolutter/data/model/global/response_model/response_model.dart';
import 'package:ovolutter/data/services/api_service.dart';

import '../../model/profile/profile_post_model.dart';
import '../../model/profile_complete/profile_complete_post_model.dart';

class ProfileRepo {
  Future<ResponseModel> updateProfile(ProfilePostModel model) async {
    String url = UrlContainer.updateProfileEndPoint;

    Map<String, String> finalMap = {
      'firstname': model.firstname,
      'lastname': model.lastName,
      'address': model.address ?? '',
      'zip': model.zip ?? '',
      'state': model.state ?? "",
      'city': model.city ?? '',
    };
    Map<String, File> attachmentFiles = {};
    if (model.image != null) {
      attachmentFiles = {"image": model.image!};
    }

    ResponseModel responseModel = await ApiService.postMultiPartRequest(url, finalMap, attachmentFiles);
    return responseModel;
  }
  // Future<bool> updateProfile(ProfilePostModel model, bool isProfile) async {
  //   try {
  //     String url = '${UrlContainer.baseUrl}${isProfile ? UrlContainer.updateProfileEndPoint : UrlContainer.profileCompleteEndPoint}';

  //     var request = http.MultipartRequest('POST', Uri.parse(url));
  //     Map<String, String> finalMap = {
  //       'firstname': model.firstname,
  //       'lastname': model.lastName,
  //       'address': model.address ?? '',
  //       'zip': model.zip ?? '',
  //       'state': model.state ?? "",
  //       'city': model.city ?? '',
  //     };

  //     request.headers.addAll(<String, String>{'Authorization': 'Bearer ${SharedPreferenceService.getAccessToken()}'});
  //     /*if(model.image!=null){
  //       request.files.add( http.MultipartFile('image', model.image!.readAsBytes().asStream(), model.image!.lengthSync(), filename: model.image!.path.split('/').last));
  //     }*/
  //     request.fields.addAll(finalMap);

  //     http.StreamedResponse response = await request.send();

  //     String jsonResponse = await response.stream.bytesToString();
  //     AuthorizationResponseModel authorizationResponseModel = AuthorizationResponseModel.fromJson(jsonDecode(jsonResponse));

  //     if (authorizationResponseModel.status?.toLowerCase() == MyStrings.success.toLowerCase()) {
  //       CustomSnackBar.success(successList: authorizationResponseModel.message ?? [MyStrings.success]);
  //       return true;
  //     } else {
  //       CustomSnackBar.error(errorList: authorizationResponseModel.message ?? [MyStrings.requestFail.tr]);
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  Future<ResponseModel> completeProfile(ProfileCompletePostModel model) async {
    dynamic params = model.toMap();
    String url = '${UrlContainer.baseUrl}${UrlContainer.profileCompleteEndPoint}';
    ResponseModel responseModel = await ApiService.postRequest(url, params);
    return responseModel;
  }

  Future<ResponseModel> loadProfileInfo() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.getProfileEndPoint}';
    ResponseModel responseModel = await ApiService.getRequest(
      url,
    );
    return responseModel;
  }

  Future<void> updateDeviceToken() async {
    //TODO
    // await PushNotificationService().sendUserToken();
  }

  Future<dynamic> getCountryList() async {
    String url = '${UrlContainer.baseUrl}${UrlContainer.countryEndPoint}';
    ResponseModel model = await ApiService.getRequest(
      url,
    );
    return model;
  }
}
