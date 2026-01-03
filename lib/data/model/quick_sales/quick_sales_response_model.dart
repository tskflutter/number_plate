// To parse this JSON data, do
//
//     final quickSalesResponseModel = quickSalesResponseModelFromJson(jsonString);

import 'dart:convert';

QuickSalesResponseModel quickSalesResponseModelFromJson(String str) => QuickSalesResponseModel.fromJson(json.decode(str));

String quickSalesResponseModelToJson(QuickSalesResponseModel data) => json.encode(data.toJson());

class QuickSalesResponseModel {
  final String? remark;
  final String? status;
  final List<String>? message;
  final Data? data;

  QuickSalesResponseModel({
    this.remark,
    this.status,
    this.message,
    this.data,
  });

  factory QuickSalesResponseModel.fromJson(Map<String, dynamic> json) => QuickSalesResponseModel(
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
  final Quicksales? quicksales;

  Data({
    this.quicksales,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        quicksales: json["quicksales"] == null ? null : Quicksales.fromJson(json["quicksales"]),
      );

  Map<String, dynamic> toJson() => {
        "quicksales": quicksales?.toJson(),
      };
}

class Quicksales {
  final String? currentPage;
  final List<QuickSalesData>? data;
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

  Quicksales({
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

  factory Quicksales.fromJson(Map<String, dynamic> json) => Quicksales(
        currentPage: json["current_page"]?.toString(),
        data: json["data"] == null ? [] : List<QuickSalesData>.from(json["data"]!.map((x) => QuickSalesData.fromJson(x))),
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

class QuickSalesData {
  final String? id;
  final String? name;
  final List<String>? intrest;
  final String? image;
  final String? dialCode;
  final String? phoneNumber;
  final String? whatsappNumber;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  QuickSalesData({
    this.id,
    this.name,
    this.intrest,
    this.image,
    this.dialCode,
    this.phoneNumber,
    this.whatsappNumber,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory QuickSalesData.fromJson(Map<String, dynamic> json) => QuickSalesData(
        id: json["id"]?.toString(),
        name: json["name"]?.toString(),
        intrest: json["interest"] == null ? [] : List<String>.from(json["interest"]!.map((x) => x)),
        image: json["image"]?.toString(),
        dialCode: json["dial_code"]?.toString(),
        phoneNumber: json["phone_number"]?.toString(),
        whatsappNumber: json["whatsapp_number"]?.toString(),
        status: json["status"]?.toString(),
        createdAt: json["created_at"]?.toString(),
        updatedAt: json["updated_at"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "interest": intrest == null ? [] : List<dynamic>.from(intrest!.map((x) => x)),
        "image": image,
        "dial_code": dialCode,
        "phone_number": phoneNumber,
        "whatsapp_number": whatsappNumber,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
