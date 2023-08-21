// To parse this JSON data, do
//
//     final timerDataModel = timerDataModelFromJson(jsonString);

import 'dart:convert';

List<TimerDataModel> timerDataModelFromJson(String str) =>
    List<TimerDataModel>.from(
        json.decode(str).map((x) => TimerDataModel.fromJson(x)));

String timerDataModelToJson(List<TimerDataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimerDataModel {
  int id;
  String title;
  String type;
  String duration;

  TimerDataModel({
    required this.id,
    required this.title,
    required this.type,
    required this.duration,
  });

  factory TimerDataModel.fromJson(Map<String, dynamic> json) => TimerDataModel(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        duration: json["duration"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "duration": duration,
      };
}
