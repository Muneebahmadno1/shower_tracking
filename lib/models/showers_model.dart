// To parse this JSON data, do
//
//     final showersModel = showersModelFromJson(jsonString);

import 'dart:convert';

List<ShowersModel> showersModelFromJson(String str) => List<ShowersModel>.from(
    json.decode(str).map((x) => ShowersModel.fromJson(x)));

String showersModelToJson(List<ShowersModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowersModel {
  String title;
  int type;
  String duration;
  int fkTimerId;
  int fkChallengeId;
  DateTime date;

  ShowersModel({
    required this.title,
    required this.type,
    required this.duration,
    required this.fkTimerId,
    required this.fkChallengeId,
    required this.date,
  });

  factory ShowersModel.fromJson(Map<String, dynamic> json) => ShowersModel(
        title: json["title"],
        type: json["type"],
        duration: json["duration"],
        fkTimerId: json["fk_timer_id"],
        fkChallengeId: json["fk_challenge_id"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "duration": duration,
        "fk_timer_id": fkTimerId,
        "fk_challenge_id": fkChallengeId,
        "date": date.toIso8601String(),
      };
}
