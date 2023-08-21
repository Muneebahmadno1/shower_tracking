// To parse this JSON data, do
//
//     final badgesModel = badgesModelFromJson(jsonString);

import 'dart:convert';

List<BadgesModel> badgesModelFromJson(String str) => List<BadgesModel>.from(
    json.decode(str).map((x) => BadgesModel.fromJson(x)));

String badgesModelToJson(List<BadgesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BadgesModel {
  String title;
  String description;
  String? message;
  String image;
  bool win;

  BadgesModel({
    required this.title,
    required this.description,
    this.message,
    required this.image,
    required this.win,
  });

  factory BadgesModel.fromJson(Map<String, dynamic> json) => BadgesModel(
        title: json["title"],
        description: json["description"],
        message: json["message"],
        image: json["image"],
        win: json["win"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "message": message,
        "image": image,
        "win": win,
      };
}
