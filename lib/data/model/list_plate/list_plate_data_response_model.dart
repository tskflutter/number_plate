// To parse this JSON data, do
//
//     final listPlateDataResponseModel = listPlateDataResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

ListPlateDataResponseModel listPlateDataResponseModelFromJson(String str) => ListPlateDataResponseModel.fromJson(json.decode(str));

String listPlateDataResponseModelToJson(ListPlateDataResponseModel data) => json.encode(data.toJson());

class ListPlateDataResponseModel {
  final String? remark;
  final String? status;
  final Data? data;
  final List<String>? message;

  ListPlateDataResponseModel({
    this.remark,
    this.status,
    this.data,
    this.message,
  });

  factory ListPlateDataResponseModel.fromJson(Map<String, dynamic> json) => ListPlateDataResponseModel(
        remark: json["remark"],
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? [] : List<String>.from(json["message"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "remark": remark,
        "status": status,
        "data": data?.toJson(),
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x)),
      };
}

class Data {
  final String? pageTitle;
  final List<City>? cities;
  final List<AdType>? adTypes;
  final String? imagePath;
  final GlobalUser? user;
  final String? userImagePath;

  Data({
    this.pageTitle,
    this.cities,
    this.adTypes,
    this.imagePath,
    this.userImagePath,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        pageTitle: json["page_title"]?.toString(),
        cities: json["cities"] == null ? [] : List<City>.from(json["cities"]!.map((x) => City.fromJson(x))),
        adTypes: json["ad_types"] == null ? [] : List<AdType>.from(json["ad_types"]!.map((x) => AdType.fromJson(x))),
        imagePath: json["image_path"]?.toString(),
        userImagePath: json["user_image_path"]?.toString(),
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "page_title": pageTitle,
        "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
        "ad_types": adTypes == null ? [] : List<dynamic>.from(adTypes!.map((x) => x.toJson())),
        "image_path": imagePath,
        "user": user?.toJson(),
        "user_image_path": userImagePath,
      };
}
