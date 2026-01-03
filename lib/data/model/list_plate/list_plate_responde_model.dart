import 'dart:convert';

import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

ListPlateAddResponseModel listPlateAddResponseModelFromJson(String str) => ListPlateAddResponseModel.fromJson(json.decode(str));

String listPlateAddResponseModelToJson(ListPlateAddResponseModel data) => json.encode(data.toJson());

class ListPlateAddResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  ListPlateAddResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory ListPlateAddResponseModel.fromJson(Map<String, dynamic> json) => ListPlateAddResponseModel(
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
  final AdsData? ad;

  Data({
    this.ad,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ad: json["ad"] == null ? null : AdsData.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "ad": ad?.toJson(),
      };
}
