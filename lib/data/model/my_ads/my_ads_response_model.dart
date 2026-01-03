// To parse this JSON data, do
//
//     final myAdsResponseModel = myAdsResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:ovolutter/data/model/ads_details/ads_details_response_model.dart';
import 'package:ovolutter/data/model/global/user/user_response_model.dart';

MyAdsResponseModel myAdsResponseModelFromJson(String str) => MyAdsResponseModel.fromJson(json.decode(str));

String myAdsResponseModelToJson(MyAdsResponseModel data) => json.encode(data.toJson());

class MyAdsResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  MyAdsResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory MyAdsResponseModel.fromJson(Map<String, dynamic> json) => MyAdsResponseModel(
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

class AdsData {
  final String? id;
  final String? userId;
  final AdType? adType;
  final String? priceType;
  final String? price;
  final String? plateNumber;
  final String? plateLetter;
  final String? cityId;
  final String? vehicleId;
  final String? dialCode;
  final String? whatsappNumber;
  final String? phoneNumber;
  final String? listingFee;
  final String? status;
  final String? adminFeedback;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final AdBoost? adBoost;
  final GlobalUser? user;
  final City? city;
  final Vehicle? vehicle;

  AdsData({
    this.id,
    this.userId,
    this.adType,
    this.priceType,
    this.price,
    this.plateNumber,
    this.plateLetter,
    this.cityId,
    this.vehicleId,
    this.dialCode,
    this.whatsappNumber,
    this.phoneNumber,
    this.listingFee,
    this.status,
    this.adminFeedback,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.adBoost,
    this.user,
    this.city,
    this.vehicle,
  });

  factory AdsData.fromJson(Map<String, dynamic> json) => AdsData(
        id: json["id"]?.toString(),
        userId: json["user_id"]?.toString(),
        adType: json["ad_type"] == null ? null : AdType.fromJson(json["ad_type"]),
        priceType: json["price_type"]?.toString(),
        price: json["price"]?.toString(),
        plateNumber: json["plate_number"]?.toString(),
        plateLetter: json["plate_letter"]?.toString(),
        cityId: json["city_id"]?.toString(),
        vehicleId: json["vehicle_id"]?.toString(),
        dialCode: json["dial_code"]?.toString(),
        whatsappNumber: json["whatsapp_number"]?.toString(),
        phoneNumber: json["phone_number"]?.toString(),
        listingFee: json["listing_fee"]?.toString(),
        status: json["status"]?.toString(),
        adminFeedback: json["admin_feedback"]?.toString(),
        deletedAt: json["deleted_at"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
        adBoost: json["ad_boost"] == null ? null : AdBoost.fromJson(json["ad_boost"]),
        user: json["user"] == null ? null : GlobalUser.fromJson(json["user"]),
        city: json["city"] == null ? null : City.fromJson(json["city"]),
        vehicle: json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ad_type": adType?.toJson(),
        "price_type": priceType,
        "price": price,
        "plate_number": plateNumber,
        "plate_letter": plateLetter,
        "city_id": cityId,
        "vehicle_id": vehicleId,
        "dial_code": dialCode,
        "whatsapp_number": whatsappNumber,
        "phone_number": phoneNumber,
        "listing_fee": listingFee,
        "status": status,
        "admin_feedback": adminFeedback,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "ad_boost": adBoost?.toJson(),
        "user": user?.toJson(),
        "city": city?.toJson(),
        "vehicle": vehicle?.toJson(),
      };
}

class AdType {
  final String? id;
  final String? type;
  final String? colorCode;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  AdType({
    this.id,
    this.type,
    this.colorCode,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AdType.fromJson(Map<String, dynamic> json) => AdType(
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

class AdBoost {
  final String? id;
  final String? userId;
  final String? adId;
  final String? boostingType;
  final String? boostingStart;
  final String? boostingEnd;
  final String? duration;
  final String? amount;
  final String? createdAt;
  final String? updatedAt;

  AdBoost({
    this.id,
    this.userId,
    this.adId,
    this.boostingType,
    this.boostingStart,
    this.boostingEnd,
    this.duration,
    this.amount,
    this.createdAt,
    this.updatedAt,
  });

  factory AdBoost.fromJson(Map<String, dynamic> json) => AdBoost(
        id: json["id"]?.toString(),
        userId: json["user_id"]?.toString(),
        adId: json["ad_id"]?.toString(),
        boostingType: json["boosting_type"]?.toString(),
        boostingStart: json["boosting_start"]?.toString(),
        boostingEnd: json["boosting_end"]?.toString(),
        duration: json["duration"]?.toString(),
        amount: json["amount"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "ad_id": adId,
        "boosting_type": boostingType,
        "boosting_start": boostingStart,
        "boosting_end": boostingEnd,
        "duration": duration,
        "amount": amount,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
