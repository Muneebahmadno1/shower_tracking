// To parse this JSON data, do
//
//     final currentLeaderModel = currentLeaderModelFromJson(jsonString);

import 'dart:convert';

List<CurrentLeaderModel> currentLeaderModelFromJson(String str) =>
    List<CurrentLeaderModel>.from(
        json.decode(str).map((x) => CurrentLeaderModel.fromJson(x)));

String currentLeaderModelToJson(List<CurrentLeaderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CurrentLeaderModel {
  int id;
  String userName;
  String profileImage;
  int totalSessions;
  int rank;

  CurrentLeaderModel({
    required this.id,
    required this.userName,
    required this.profileImage,
    required this.totalSessions,
    required this.rank,
  });

  factory CurrentLeaderModel.fromJson(Map<String, dynamic> json) =>
      CurrentLeaderModel(
        id: json["id"],
        userName: json["user_name"],
        profileImage: json["profile_image"],
        totalSessions: json["total_sessions"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_name": userName,
        "profile_image": profileImage,
        "total_sessions": totalSessions,
        "rank": rank,
      };
}
