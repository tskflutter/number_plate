// To parse this JSON data, do
//
//     final homescreenResponseModel = homescreenResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

WatchListResponseModel watchlistResponseModelFromJson(String str) => WatchListResponseModel.fromJson(json.decode(str));

String watchlistResponseModelToJson(WatchListResponseModel data) => json.encode(data.toJson());

class WatchListResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  WatchListResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory WatchListResponseModel.fromJson(Map<String, dynamic> json) => WatchListResponseModel(
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
  final Watchlists? watchlists;

  Data({
    this.watchlists,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        watchlists: json["watchlists"] == null ? null : Watchlists.fromJson(json["watchlists"]),
      );

  Map<String, dynamic> toJson() => {
        "watchlists": watchlists?.toJson(),
      };
}

class Watchlists {
  final String? currentPage;
  final List<WatchlistData>? data;
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

  Watchlists({
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

  factory Watchlists.fromJson(Map<String, dynamic> json) => Watchlists(
        currentPage: json["current_page"]?.toString(),
        data: json["data"] == null ? [] : List<WatchlistData>.from(json["data"]!.map((x) => WatchlistData.fromJson(x))),
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

class WatchlistData {
  final String? id;
  final String? userId;
  final String? adId;
  final String? createdAt;
  final String? updatedAt;
  final AdsData? ad;

  WatchlistData({
    this.id,
    this.userId,
    this.adId,
    this.createdAt,
    this.updatedAt,
    this.ad,
  });

  factory WatchlistData.fromJson(Map<String, dynamic> json) => WatchlistData(
        id: json["id"]?.toString(),
        userId: json["user_id"]?.toString(),
        adId: json["ad_id"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
        ad: json["ad"] == null ? null : AdsData.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ad_id": adId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "ad": ad?.toJson(),
      };
}
