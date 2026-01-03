// To parse this JSON data, do
//
//     final carPlateResponseModel = carPlateResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

CarPlateResponseModel carPlateResponseModelFromJson(String str) => CarPlateResponseModel.fromJson(json.decode(str));

String carPlateResponseModelToJson(CarPlateResponseModel data) => json.encode(data.toJson());

class CarPlateResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  CarPlateResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory CarPlateResponseModel.fromJson(Map<String, dynamic> json) => CarPlateResponseModel(
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
  final AdLists? adLists;

  Data({
    this.adLists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adLists: json["ad_lists"] == null ? null : AdLists.fromJson(json["ad_lists"]),
      );

  Map<String, dynamic> toJson() => {
        "ad_lists": adLists?.toJson(),
      };
}

class AdLists {
  final String? currentPage;
  final List<AdsData>? data;
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

  AdLists({
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

  factory AdLists.fromJson(Map<String, dynamic> json) => AdLists(
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
