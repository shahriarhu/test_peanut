import 'dart:convert';

PromoModel promoModelFromJson(String str) =>
    PromoModel.fromJson(json.decode(str));

class PromoModel {
  Advertisement? forexCopy;
  Advertisement? ferrari;
  Advertisement? tether;
  Advertisement? luckyDeposit;

  PromoModel({
    this.forexCopy,
    this.ferrari,
    this.tether,
    this.luckyDeposit,
  });

  factory PromoModel.fromJson(Map<String, dynamic> json) => PromoModel(
        forexCopy: json["forex_copy"] == null
            ? null
            : Advertisement.fromJson(json["forex_copy"]),
        ferrari: json["ferrari"] == null
            ? null
            : Advertisement.fromJson(json["ferrari"]),
        tether: json["tether"] == null
            ? null
            : Advertisement.fromJson(json["tether"]),
        luckyDeposit: json["lucky_deposit"] == null
            ? null
            : Advertisement.fromJson(json["lucky_deposit"]),
      );
}

class Advertisement {
  String? image;
  String? text;
  String? link;
  String? buttonText;
  String? buttonColor;
  bool? euroAvailable;
  int? dieDate;

  Advertisement({
    this.image,
    this.text,
    this.link,
    this.buttonText,
    this.buttonColor,
    this.euroAvailable,
    this.dieDate,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) => Advertisement(
        image: json["image"],
        text: json["text"],
        link: json["link"],
        buttonText: json["button_text"],
        buttonColor: json["button_color"],
        euroAvailable: json["euro_available"],
        dieDate: json["die_date"],
      );
}
