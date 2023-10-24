import 'dart:convert';

List<UserTradesModel> userTradesModelFromJson(String str) =>
    List<UserTradesModel>.from(
        json.decode(str).map((x) => UserTradesModel.fromJson(x)));

String userTradesModelToJson(List<UserTradesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserTradesModel {
  double? currentPrice;
  dynamic comment;
  int? digits;
  int? login;
  double? openPrice;
  DateTime? openTime;
  double? profit;
  double? sl;
  double? swaps;
  String? symbol;
  double? tp;
  int? ticket;
  int? type;
  double? volume;

  UserTradesModel({
    this.currentPrice,
    this.comment,
    this.digits,
    this.login,
    this.openPrice,
    this.openTime,
    this.profit,
    this.sl,
    this.swaps,
    this.symbol,
    this.tp,
    this.ticket,
    this.type,
    this.volume,
  });

  factory UserTradesModel.fromJson(Map<String, dynamic> json) =>
      UserTradesModel(
        currentPrice: json["currentPrice"]?.toDouble(),
        comment: json["comment"],
        digits: json["digits"],
        login: json["login"],
        openPrice: json["openPrice"]?.toDouble(),
        openTime:
            json["openTime"] == null ? null : DateTime.parse(json["openTime"]),
        profit: json["profit"]?.toDouble(),
        sl: json["sl"]?.toDouble(),
        swaps: json["swaps"]?.toDouble(),
        symbol: json["symbol"],
        tp: json["tp"],
        ticket: json["ticket"],
        type: json["type"],
        volume: json["volume"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "currentPrice": currentPrice,
        "comment": comment,
        "digits": digits,
        "login": login,
        "openPrice": openPrice,
        "openTime": openTime?.toIso8601String(),
        "profit": profit,
        "sl": sl,
        "swaps": swaps,
        "symbol": symbol,
        "tp": tp,
        "ticket": ticket,
        "type": type,
        "volume": volume,
      };
}
