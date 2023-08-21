// To parse this JSON data, do
//
//     final challengesModel = challengesModelFromJson(jsonString);

import 'dart:convert';

List<ChallengesModel> challengesModelFromJson(String str) =>
    List<ChallengesModel>.from(
        json.decode(str).map((x) => ChallengesModel.fromJson(x)));

String challengesModelToJson(List<ChallengesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChallengesModel {
  int id;
  String title;
  String type;
  String time;
  int days;
  String shareCode;
  String mode;
  String startDate;
  String endDate;
  String status;
  bool self;
  bool join;
  List<ChallengesMember> challengesMembers;

  ChallengesModel({
    required this.id,
    required this.title,
    required this.type,
    required this.time,
    required this.days,
    required this.shareCode,
    required this.mode,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.self,
    required this.join,
    required this.challengesMembers,
  });

  factory ChallengesModel.fromJson(Map<String, dynamic> json) =>
      ChallengesModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        time: json["time"],
        days: json["days"],
        shareCode: json["share_code"],
        mode: json["mode"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        status: json["status"],
        self: json["self"],
        join: json["join"],
        challengesMembers: List<ChallengesMember>.from(
            json["challenges_members"]
                .map((x) => ChallengesMember.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "time": time,
        "days": days,
        "share_code": shareCode,
        "mode": mode,
        "start_date": startDate,
        "end_date": endDate,
        "status": status,
        "self": self,
        "join": join,
        "challenges_members":
            List<dynamic>.from(challengesMembers.map((x) => x.toJson())),
      };
}

class ChallengesMember {
  String fkUserId;
  String userName;
  String profileImage;
  int totalSessions;
  int rank;

  ChallengesMember({
    required this.fkUserId,
    required this.userName,
    required this.profileImage,
    required this.totalSessions,
    required this.rank,
  });

  factory ChallengesMember.fromJson(Map<String, dynamic> json) =>
      ChallengesMember(
        fkUserId: json["fk_user_id"].toString(),
        userName: json["user_name"],
        profileImage: json["profile_image"],
        totalSessions: json["total_sessions"],
        rank: json["rank"],
      );

  Map<String, dynamic> toJson() => {
        "fk_user_id": fkUserId,
        "user_name": userName,
        "profile_image": profileImage,
        "total_sessions": totalSessions,
        "rank": rank,
      };
}
