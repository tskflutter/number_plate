import 'dart:convert';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';
import 'package:ovolutter/data/model/my_ads/my_ads_response_model.dart';

HomescreenResponseModel homescreenResponseModelFromJson(String str) => HomescreenResponseModel.fromJson(json.decode(str));

String homescreenResponseModelToJson(HomescreenResponseModel data) => json.encode(data.toJson());

class HomescreenResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  HomescreenResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory HomescreenResponseModel.fromJson(Map<String, dynamic> json) => HomescreenResponseModel(
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
  final TrendingAds? trendingAds;
  final String? imagePath;
  final String? userImagePath;
  final List<Offer>? offers;
  final String? offerImagePath;
  final String? requestedAds;
  final String? unreadNotifications;
  final String? carPlates;

  Data({
    this.user,
    this.trendingAds,
    this.imagePath,
    this.userImagePath,
    this.offers,
    this.offerImagePath,
    this.requestedAds,
    this.carPlates,
    this.unreadNotifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
        trendingAds: json["trending_ads"] == null ? null : TrendingAds.fromJson(json["trending_ads"]),
        imagePath: json["image_path"]?.toString(),
        userImagePath: json["user_image_path"]?.toString(),
        offers: json["offers"] == null ? [] : List<Offer>.from(json["offers"]!.map((x) => Offer.fromJson(x))),
        offerImagePath: json["offer_image_path"]?.toString(),
        requestedAds: json["requested_ads"]?.toString(),
        carPlates: json["total_ads_count"]?.toString(),
        unreadNotifications: json["unread_notifications"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "trending_ads": trendingAds?.toJson(),
        "image_path": imagePath,
        "user_image_path": userImagePath,
        "offers": offers == null ? [] : List<dynamic>.from(offers!.map((x) => x.toJson())),
        "offer_image_path": offerImagePath,
        "requested_ads": requestedAds,
        "total_ads_count": carPlates,
        "unread_notifications": unreadNotifications,
      };
}

class Offer {
  final String? id;
  final String? screen;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Offer({
    this.id,
    this.screen,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"]?.toString(),
        screen: json["screen"]?.toString(),
        image: json["image"]?.toString(),
        status: json["status"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "screen": screen,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class TrendingAds {
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

  TrendingAds({
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

  factory TrendingAds.fromJson(Map<String, dynamic> json) => TrendingAds(
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
