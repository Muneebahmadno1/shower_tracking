// To parse this JSON data, do
//
//     final subscriptionModel = subscriptionModelFromJson(jsonString);

import 'dart:convert';

List<SubscriptionModel> subscriptionModelFromJson(String str) =>
    List<SubscriptionModel>.from(
        json.decode(str).map((x) => SubscriptionModel.fromJson(x)));

String subscriptionModelToJson(List<SubscriptionModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubscriptionModel {
  int id;
  String title;
  String description;
  String duration;
  int price;
  dynamic discount;
  bool trial;

  SubscriptionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    required this.price,
    this.discount,
    required this.trial,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        duration: json["duration"],
        price: json["price"],
        discount: json["discount"],
        trial: json["trial"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "duration": duration,
        "price": price,
        "discount": discount,
        "trial": trial,
      };
}
