// To parse this JSON data, do
//
//     final emailVerifyResponseModel = emailVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/data/model/global/user/user_response_model.dart';

EmailVerifyResponseModel emailVerifyResponseModelFromJson(String str) => EmailVerifyResponseModel.fromJson(json.decode(str));

String emailVerifyResponseModelToJson(EmailVerifyResponseModel data) => json.encode(data.toJson());

class EmailVerifyResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  EmailVerifyResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory EmailVerifyResponseModel.fromJson(Map<String, dynamic> json) => EmailVerifyResponseModel(
        remark: json["remark"],
        status: json["status"],
        message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
        "data": data?.toJson(),
      };
}

class Data {
  final GlobalUser? user;

  Data({
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
      };
}
