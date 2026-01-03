// To parse this JSON data, do
//
//     final adBoostingResponseModel = adBoostingResponseModelFromJson(jsonString);

import 'dart:convert';

AdBoostingResponseModel adBoostingResponseModelFromJson(String str) => AdBoostingResponseModel.fromJson(json.decode(str));

String adBoostingResponseModelToJson(AdBoostingResponseModel data) => json.encode(data.toJson());

class AdBoostingResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  AdBoostingResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory AdBoostingResponseModel.fromJson(Map<String, dynamic> json) => AdBoostingResponseModel(
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
  final Ad? ad;

  Data({
    this.ad,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ad: json["ad"] == null ? null : Ad.fromJson(json["ad"]),
      );

  Map<String, dynamic> toJson() => {
        "ad": ad?.toJson(),
      };
}

class Ad {
  final String? userId;
  final String? adId;
  final String? boostingType;
  final String? boostingStart;
  final String? boostingEnd;
  final String? duration;
  final String? paymentStatus;
  final String? amount;
  final String? updatedAt;
  final String? createdAt;
  final String? id;

  Ad({
    this.userId,
    this.adId,
    this.boostingType,
    this.boostingStart,
    this.boostingEnd,
    this.duration,
    this.paymentStatus,
    this.amount,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        userId: json["user_id"]?.toString(),
        adId: json["ad_id"]?.toString(),
        boostingType: json["boosting_type"]?.toString(),
        boostingStart: json["boosting_start"]?.toString(),
        boostingEnd: json["boosting_end"]?.toString(),
        duration: json["duration"]?.toString(),
        paymentStatus: json["payment_status"]?.toString(),
        amount: json["amount"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        id: json["id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "ad_id": adId,
        "boosting_type": boostingType,
        "boosting_start": boostingStart,
        "boosting_end": boostingEnd,
        "duration": duration,
        "payment_status": paymentStatus,
        "amount": amount,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
