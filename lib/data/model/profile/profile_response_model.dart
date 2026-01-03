import 'package:ovolutter/core/helper/string_format_helper.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';

class ProfileResponseModel {
  ProfileResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  ProfileResponseModel.fromJson(dynamic json) {
    remark = json['remark'];
    status = json['status'];
    message = json['message'] != null ? (json['message'] as List<dynamic>).toStringList() : [];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? remark;
  String? status;
  List<String>? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = remark;
    map['status'] = status;
    if (message != null) {
      map['message'] = message;
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.user,
  });

  Data.fromJson(dynamic json) {
    user = json['user'] != null ? GlobalUser.fromJson(json['user']) : null;
  }
  GlobalUser? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
