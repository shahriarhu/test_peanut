import 'dart:convert';

List<UserTradesModel> userTradesModelFromJson(String str) =>
    List<UserTradesModel>.from(
        json.decode(str).map((x) => UserTradesModel.fromJson(x)));

class UserTradesModel {
  double? currentPrice;
  dynamic comment;
  double? digits;
  double? login;
  double? openPrice;
  DateTime? openTime;
  double? profit;
  double? sl;
  double? swaps;
  String? symbol;
  double? tp;
  double? ticket;
  double? type;
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
        digits: json["digits"]?.toDouble(),
        login: json["login"]?.toDouble(),
        openPrice: json["openPrice"]?.toDouble(),
        openTime:
            json["openTime"] == null ? null : DateTime.parse(json["openTime"]),
        profit: json["profit"]?.toDouble(),
        sl: json["sl"]?.toDouble(),
        swaps: json["swaps"]?.toDouble(),
        symbol: json["symbol"],
        tp: json["tp"]?.toDouble(),
        ticket: json["ticket"]?.toDouble(),
        type: json["type"]?.toDouble(),
        volume: json["volume"]?.toDouble(),
      );
}
