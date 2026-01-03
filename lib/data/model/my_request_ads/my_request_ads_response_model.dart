import 'dart:convert';

import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

MyRequestAdsResponseModel myRequestAdsResponseModelFromJson(String str) => MyRequestAdsResponseModel.fromJson(json.decode(str));

String myRequestAdsResponseModelToJson(MyRequestAdsResponseModel data) => json.encode(data.toJson());

class MyRequestAdsResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  MyRequestAdsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory MyRequestAdsResponseModel.fromJson(Map<String, dynamic> json) => MyRequestAdsResponseModel(
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
  MyRequestedAdList? myRequestedAdList;

  Data({
    this.myRequestedAdList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        myRequestedAdList: json["my_requested_ad_list"] == null ? null : MyRequestedAdList.fromJson(json["my_requested_ad_list"]),
      );

  Map<String, dynamic> toJson() => {
        "my_requested_ad_list": myRequestedAdList?.toJson(),
      };
}

class MyRequestedAdList {
  final String? currentPage;
  List<AdsData>? data;
  final String? firstPageUrl;
  final String? from;
  final String? lastPage;
  final String? lastPageUrl;
  final String? nextPageUrl;
  final String? path;
  final String? perPage;
  final String? prevPageUrl;
  final String? to;
  final String? total;

  MyRequestedAdList({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory MyRequestedAdList.fromJson(Map<String, dynamic> json) => MyRequestedAdList(
        currentPage: json["current_page"]?.toString(),
        data: json["data"] == null ? [] : List<AdsData>.from(json["data"]!.map((x) => AdsData.fromJson(x))),
        firstPageUrl: json["first_page_url"]?.toString(),
        from: json["from"]?.toString(),
        lastPage: json["last_page"]?.toString(),
        lastPageUrl: json["last_page_url"]?.toString(),
        nextPageUrl: json["next_page_url"]?.toString(),
        path: json["path"]?.toString(),
        perPage: json["per_page"]?.toString(),
        prevPageUrl: json["prev_page_url"]?.toString(),
        to: json["to"]?.toString(),
        total: json["total"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}
