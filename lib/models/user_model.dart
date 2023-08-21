// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:too_cool/controllers/auth_controller.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

AuthController _authController = Get.find();

class UserModel {
  int id;
  String name;
  int type;
  String email;
  dynamic referral;
  String profileImage;
  int subscription;
  DateTime subscriptionExpires;
  int currentStreak;
  int bestStreak;
  String totalTime;
  int totalSessions;
  String accessToken;
  String tokenType;

  UserModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
    this.referral,
    required this.profileImage,
    required this.subscription,
    required this.subscriptionExpires,
    required this.currentStreak,
    required this.bestStreak,
    required this.totalTime,
    required this.totalSessions,
    required this.accessToken,
    required this.tokenType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        email: json["email"],
        referral: json["referral"],
        profileImage: json["profile_image"],
        subscription: json["subscription"],
        subscriptionExpires: DateTime.parse(json["subscription_expires"]),
        currentStreak: json["current_streak"],
        bestStreak: json["best_streak"],
        totalTime: json["total_time"],
        totalSessions: json["total_sessions"],
        accessToken: json["access_token"] ?? _authController.token.value,
        tokenType: json["token_type"] ?? "Bearer",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "email": email,
        "referral": referral,
        "profile_image": profileImage,
        "subscription": subscription,
        "subscription_expires":
            "${subscriptionExpires.year.toString().padLeft(4, '0')}-${subscriptionExpires.month.toString().padLeft(2, '0')}-${subscriptionExpires.day.toString().padLeft(2, '0')}",
        "current_streak": currentStreak,
        "best_streak": bestStreak,
        "total_time": totalTime,
        "total_sessions": totalSessions,
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
