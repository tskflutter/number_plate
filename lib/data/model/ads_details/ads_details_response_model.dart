import 'dart:convert';

import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

AdsDetailsResponseModel adsDetailsResponseModelFromJson(String str) => AdsDetailsResponseModel.fromJson(json.decode(str));

String adsDetailsResponseModelToJson(AdsDetailsResponseModel data) => json.encode(data.toJson());

class AdsDetailsResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  AdsDetailsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AdsDetailsResponseModel.fromJson(Map<String, dynamic> json) => AdsDetailsResponseModel(
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
  final SimilarAd? similarAd;

  Data({
    this.ad,
    this.similarAd,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ad: json["ad"] == null ? null : AdsData.fromJson(json["ad"]),
        similarAd: json["similar_ad"] == null ? null : SimilarAd.fromJson(json["similar_ad"]),
      );

  Map<String, dynamic> toJson() => {
        "ad": ad?.toJson(),
        "similar_ad": similarAd?.toJson(),
      };
}

class City {
  final String? id;
  final String? name;
  final String? cityCode;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  City({
    this.id,
    this.name,
    this.cityCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        cityCode: json["city_code"]?.toString(),
        status: json["status"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city_code": cityCode,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Vehicle {
  final String? id;
  final String? type;
  final String? colorCode;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Vehicle({
    this.id,
    this.type,
    this.colorCode,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"]?.toString(),
        type: json["type"]?.toString(),
        colorCode: json["color_code"]?.toString(),
        image: json["image"]?.toString(),
        status: json["status"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "color_code": colorCode,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class SimilarAd {
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

  SimilarAd({
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

  factory SimilarAd.fromJson(Map<String, dynamic> json) => SimilarAd(
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
