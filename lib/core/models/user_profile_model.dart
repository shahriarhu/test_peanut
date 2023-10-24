// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  ExtensionData? extensionData;
  String? address;
  double? balance;
  String? city;
  String? country;
  double? currency;
  double? currentTradesCount;
  double? currentTradesVolume;
  double? equity;
  double? freeMargin;
  bool? isAnyOpenTrades;
  bool? isSwapFree;
  double? leverage;
  String? name;
  String? phone;
  double? totalTradesCount;
  double? totalTradesVolume;
  int? type;
  int? verificationLevel;
  String? zipCode;

  UserProfileModel({
    this.extensionData,
    this.address,
    this.balance,
    this.city,
    this.country,
    this.currency,
    this.currentTradesCount,
    this.currentTradesVolume,
    this.equity,
    this.freeMargin,
    this.isAnyOpenTrades,
    this.isSwapFree,
    this.leverage,
    this.name,
    this.phone,
    this.totalTradesCount,
    this.totalTradesVolume,
    this.type,
    this.verificationLevel,
    this.zipCode,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        extensionData: json["extensionData"] == null
            ? null
            : ExtensionData.fromJson(json["extensionData"]),
        address: json["address"],
        balance: json["balance"]?.toDouble(),
        city: json["city"],
        country: json["country"],
        currency: json["currency"]?.toDouble(),
        currentTradesCount: json["currentTradesCount"]?.toDouble(),
        currentTradesVolume: json["currentTradesVolume"]?.toDouble(),
        equity: json["equity"]?.toDouble(),
        freeMargin: json["freeMargin"]?.toDouble(),
        isAnyOpenTrades: json["isAnyOpenTrades"],
        isSwapFree: json["isSwapFree"],
        leverage: json["leverage"]?.toDouble(),
        name: json["name"],
        phone: json["phone"],
        totalTradesCount: json["totalTradesCount"]?.toDouble(),
        totalTradesVolume: json["totalTradesVolume"]?.toDouble(),
        type: json["type"],
        verificationLevel: json["verificationLevel"],
        zipCode: json["zipCode"],
      );

  Map<String, dynamic> toJson() => {
        "extensionData": extensionData?.toJson(),
        "address": address,
        "balance": balance,
        "city": city,
        "country": country,
        "currency": currency,
        "currentTradesCount": currentTradesCount,
        "currentTradesVolume": currentTradesVolume,
        "equity": equity,
        "freeMargin": freeMargin,
        "isAnyOpenTrades": isAnyOpenTrades,
        "isSwapFree": isSwapFree,
        "leverage": leverage,
        "name": name,
        "phone": phone,
        "totalTradesCount": totalTradesCount,
        "totalTradesVolume": totalTradesVolume,
        "type": type,
        "verificationLevel": verificationLevel,
        "zipCode": zipCode,
      };
}

class ExtensionData {
  ExtensionData();

  factory ExtensionData.fromJson(Map<String, dynamic> json) => ExtensionData();

  Map<String, dynamic> toJson() => {};
}
