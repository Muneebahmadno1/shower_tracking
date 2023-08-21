// To parse this JSON data, do
//
//     final currentLeaderModel = currentLeaderModelFromJson(jsonString);

import 'dart:convert';

List<PastLeaderModel> currentLeaderModelFromJson(String str) =>
    List<PastLeaderModel>.from(
        json.decode(str).map((x) => PastLeaderModel.fromJson(x)));

String currentLeaderModelToJson(List<PastLeaderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PastLeaderModel {
  int id;
  String userName;
  String profileImage;
  int totalSessions;
  int rank;
  String date;

  PastLeaderModel({
    required this.id,
    required this.userName,
    required this.profileImage,
    required this.totalSessions,
    required this.rank,
    required this.date,
  });

  factory PastLeaderModel.fromJson(Map<String, dynamic> json) =>
      PastLeaderModel(
        id: json["id"],
        userName: json["user_name"],
        profileImage: json["profile_image"],
        totalSessions: json["total_sessions"],
        rank: json["rank"],
        date: json["date"] == null ? "March 2023" : json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "profile_image": profileImage,
        "total_sessions": totalSessions,
        "rank": rank,
        "date": date,
      };
}
