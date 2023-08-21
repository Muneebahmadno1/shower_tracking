import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Asset {
  static const intro1 = "assets/images/intro1.png";
  static const intro2 = "assets/images/intro2.png";
  static const intro3 = "assets/images/intro3.png";
  static const intro4 = "assets/images/intro4.png";
  static const intro5 = "assets/images/intro5.png";
  static const intro6 = "assets/images/intro6.png";
  static const google = "assets/icons/google.png";
  static const facebook = "assets/icons/facebook.png";
  static const apple = "assets/icons/apple.png";
  static const subscribeLogo = "assets/images/subscribe_logo.png";
  static const appLogo = "assets/images/app_logo.png";
  static const statsIconSelected = "assets/icons/stats_icon_selected.png";
  static const leadersIconSelected = "assets/icons/leaders_icon_selected.png";
  static const badgesIconSelected = "assets/icons/badges_icon_selected.png";
  static const challengesIconSelected =
      "assets/icons/challenges_icon_selected.png";
  static const settingIconSelected = "assets/icons/settings_icon_selected.png";
  static const statsIcon = "assets/icons/stats_icon.png";
  static const leadersIcon = "assets/icons/leaders_icon.png";
  static const badgesIcon = "assets/icons/badges_icon.png";
  static const challengesIcon = "assets/icons/challenges_icon.png";
  static const settingIcon = "assets/icons/settings_icon.png";
  static const currentStreakIcon = "assets/icons/current_streak_icon.png";
  static const bestStreakIcon = "assets/icons/best_streak_icon.png";
  static const totalSessionsIcon = "assets/icons/total_sessions_icon.png";
  static const totalTimeIcon = "assets/icons/total_time_icon.png";
  static const addIcon = "assets/icons/add_icon.png";
  static const userIcon = "assets/icons/user_icon.png";
  static const iceIcon = "assets/icons/ice_icon.png";
  static const badge1 = "assets/images/badge1.png";
  static const badge2 = "assets/images/badge2.png";
  static const badge3 = "assets/images/badge3.png";
  static const clapsIcon = "assets/icons/claps_icon.png";
  static const shareIcon = "assets/icons/share_icon.png";
  static const partyIcon = "assets/icons/party_icon.png";
  static const resetIcon = "assets/icons/reset_icon.png";
  static const playIcon = "assets/icons/play_icon.png";
  static const forwardIcon = "assets/icons/forward_icon.png";
  static const clapIcon = "assets/icons/clap_icon.png";
  static const calenderIcon = "assets/icons/calender_icon.png";
}

List<String> homepageIcons = [
  Asset.currentStreakIcon,
  Asset.bestStreakIcon,
  Asset.calenderIcon,
  Asset.totalTimeIcon
];
List<int> homepageNumbers = [0, 0, 0, 0];
List<Color> homepageColors = [
  HexColor('#83BCFF'),
  HexColor("#A8D0FF"),
  HexColor("#D8EAFF"),
  HexColor("#EFF6FF")
];
List<String> homepageTitles = [
  "Current Streak",
  "Best Streak",
  "Total Sessions",
  "Total Time"
];
List<Color> leadersColors = [
  HexColor('#83BCFF'),
  HexColor("#ACD2FF"),
  HexColor("#C7E1FF"),
  HexColor("#D8EAFF"),
  HexColor('#E6F0FF')
];
List<String> leadersName = ["Smith", "Doe", "Marks", "Dowe", "Doe"];
List<String> badgesList = [
  Asset.badge1,
  Asset.badge2,
  Asset.badge3,
  Asset.badge1,
  Asset.badge2,
  Asset.badge3,
  Asset.badge2,
  Asset.badge3,
  Asset.badge2,
  Asset.badge1,
  Asset.badge3,
  Asset.badge2,
];

class AppColors {
  static const background = Colors.white;
  static Color hintColor = HexColor('#9B9B9B');
  static Color borderColor = Colors.grey.withOpacity(0.5);
}

class HaboColors {
  static const Color primary = Color(0xFF09BF30);
  static const Color red = Color(0xFFF44336);
  static const Color skip = Color(0xFFFBC02D);
  static const Color orange = Color(0xFFFF9800);
}

void setUserLoggedIn(bool key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool("isLoggedIn", key);
}

Future getUserLoggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var log = prefs.getBool("isLoggedIn") ?? false;
  return log;
}

void setUserType(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("type", key);
}

Future getUserType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var log = prefs.getString("type") ?? '';
  return log;
}

void saveUserDataToken({@required token}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString("token", token);
}

Future getUserDataToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? result = pref.getString("token");
  return result;
}
