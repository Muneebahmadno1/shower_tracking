import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:numeral/fun.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/screens/auth/signup_screen.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/styles.dart';

import '../controllers/badges_controller.dart';
import '../controllers/challenge_controller.dart';
import '../controllers/home_controller.dart';
import '../controllers/leaderboard_controller.dart';
import '../controllers/setting_controller.dart';
import '../models/badges_model.dart';
import '../models/challenges_model.dart';
import '../models/city_model.dart';
import '../models/country_model.dart';
import '../models/current_leaderboard_model.dart';
import '../models/past_leaderboard_model.dart';
import '../models/showers_model.dart';
import '../models/subscription_model.dart';
import '../models/timer_data_model.dart';
import '../screens/auth/login_screen.dart';

class SocialLoginButtons {
  final AuthController _authController = Get.find<AuthController>();
  Widget logos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
            onTap: () {},
            child: Container(
                height: 50,
                width: 85,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Image.asset(
                  Asset.facebook,
                  scale: 5.0,
                ))),
        const SizedBox(width: 10),
        GestureDetector(
            onTap: () async {
              _authController.signIn(context);
            },
            child: Container(
                height: 50,
                width: 85,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor),
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Image.asset(
                  Asset.google,
                  scale: 5.0,
                ))),
        Platform.isIOS ? const SizedBox(width: 10) : Container(),
        Platform.isIOS
            ? GestureDetector(
                onTap: () async {
                  _authController.appleSignUp(context);
                },
                child: Container(
                    height: 50,
                    width: 85,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      Asset.apple,
                      scale: 5.0,
                    )))
            : Container()
      ],
    );
  }
}

class HaveAccount {
  static Widget already() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: textStyleBlackR.copyWith(fontSize: 15),
        ),
        GestureDetector(
          onTap: () {
            Get.to(() => const LoginScreen());
          },
          child: Image.asset(
            "assets/images/Log In.png",
            scale: 4.5,
          ),
          // Text("Log In", style: textStyleBlackB.copyWith(fontSize: 15))
        ),
      ],
    );
  }

  static Widget doNot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ",
            style: textStyleBlackR.copyWith(fontSize: 15)),
        GestureDetector(
            onTap: () {
              Get.to(() => const SignupScreen());
            },
            child: Image.asset(
              "assets/images/Sign Up.png",
              scale: 4.5,
            )),
      ],
    );
  }
}

// void loginDialog (BuildContext context){
//   AwesomeDialog(
//     context: context,
//     dialogType: DialogType.infoReverse,
//     animType: AnimType.rightSlide,
//     title: 'Oops',
//     desc: 'Please Login First!',
//     dialogBackgroundColor: Colors.grey.shade800,
//     btnCancelColor: Colors.grey,
//     btnOkColor: Colors.red,
//     btnOkOnPress: () {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (context) {
//             return const SignUpDialog(showStoreField: false,);
//           });
//     },
//     btnCancelOnPress: () {
//       return;
//     },
//   ).show();
// }

class AppButton1 extends StatefulWidget {
  final String text;
  final double fontSize;
  final VoidCallback? btnPressed;
  const AppButton1({
    Key? key,
    required this.text,
    this.fontSize = 20,
    this.btnPressed,
  }) : super(key: key);

  @override
  State<AppButton1> createState() => _AppButton1State();
}

class _AppButton1State extends State<AppButton1>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 150),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: () async {
        _controller.forward();
        await Future.delayed(const Duration(milliseconds: 100), () {
          _controller.reverse();
        });
        widget.btnPressed!();
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 0.9,
        ).animate(_controller),
        child: Container(
          height: 55,
          width: 90.w,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(8)),
          alignment: Alignment.center,
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colors.white,
                fontSize: widget.fontSize,
                fontFamily: 'Helvetica-B',
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AppButton {
  static Bounceable appButton({
    required BuildContext context,
    required String text,
    double fontSize = 0,
    required VoidCallback? btnPressed,
  }) {
    return Bounceable(
      onTap: () => btnPressed!(),
      child: Container(
        height: 55,
        width: 90.w,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(8)),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize == 0 ? 20 : fontSize,
              fontFamily: 'Helvetica-B',
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class RectangleBox {
  static GestureDetector homeRectangleBox({
    required BuildContext context,
    VoidCallback? btnPressed,
    required String asset,
    required String title,
    int? number,
    String? time,
    required totalTime,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 45,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    asset,
                    scale: 8.0,
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: textStyleBlackR.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    totalTime == true
                        ? "${time.toString().split(":")[0]}h ${time.toString().split(":")[1]}m ${time.toString().split(":")[2].toString()}s"
                        : number.toString(),
                    style: textStyleBlackR.copyWith(fontSize: 16.sp),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector leaderRectangleBox({
    required BuildContext context,
    required String name,
    VoidCallback? btnPressed,
    String month = '',
    String image = '',
    bool border = false,
    bool myAccount = false,
    required int rank,
    required int number,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 53,
            width: 90.w,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: border ? Colors.grey : color,
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: image == ""
                                  ? Image.asset(
                                      Asset.userIcon,
                                      scale: 4.0,
                                    )
                                  : SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(200),
                                          child: CachedNetworkImage(
                                            imageUrl: image,
                                            fit: BoxFit.fill,
                                          )),
                                    )),
                          myAccount
                              ? Positioned(
                                  left: 3.5,
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        border: Border.fromBorderSide(
                                            BorderSide(color: Colors.white))),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rank: $rank",
                            style: textStyleBlackB.copyWith(fontSize: 12),
                          ),
                          SizedBox(
                              width: 40.w,
                              child: month == ''
                                  ? Text("$name",
                                      style: textStyleBlackR.copyWith(
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1)
                                  : Text("$name - $month",
                                      style: textStyleBlackR.copyWith(
                                          fontSize: 12),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1)),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Asset.iceIcon,
                          scale: 6.0,
                        ),
                        Text(
                          numeral(number),
                          style: textStyleBlackR.copyWith(fontSize: 25),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector daySessionRectangleBox({
    required BuildContext context,
    VoidCallback? btnPressed,
    String month = '',
    String image = '',
    bool border = false,
    bool myAccount = false,
    required Color color,
    required String title,
    required String duration,
    required DateTime date,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 53,
            width: 90.w,
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: border ? Colors.grey : color,
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      "${DateFormat.jm().format(date)} - $title",
                      style: textStyleBlackR,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 40.w,
                          child: Text(
                            "${duration.split(":")[0]} min, ${duration.split(":")[1]} sec",
                            style: textStyleBlackR,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector challengeRectangleBox({
    required BuildContext context,
    required Color color,
    required VoidCallback btnPressed,
    required String challengeName,
    required String type,
    required String time,
    required String days,
    required String members,
    required String buttonText,
  }) {
    return GestureDetector(
      onTap: () => btnPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
            height: 58,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challengeName,
                        style: textStyleBlackB.copyWith(fontSize: 15),
                      ),
                      SizedBox(
                          width: 60.w,
                          child: Text(
                            "$type | $time | $days Days  | $members members",
                            style: textStyleBlackR.copyWith(fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ))
                    ],
                  ),
                  Container(
                    height: 4.5.h,
                    width: 20.w,
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    alignment: Alignment.center,
                    child: GestureDetector(
                        onTap: btnPressed,
                        child: Text(
                          buttonText,
                          style: textStyleBlackB.copyWith(fontSize: 16),
                        )),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector privateChallengeRectangleBox({
    required BuildContext context,
    required Color color,
    required VoidCallback btnPressed,
    required String challengeName,
    required String type,
    required String time,
    required String days,
    required String members,
  }) {
    return GestureDetector(
      onTap: () => btnPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: GestureDetector(
          onTap: btnPressed,
          child: Container(
              height: 58,
              width: 90.w,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          challengeName,
                          style: textStyleBlackB.copyWith(fontSize: 15),
                        ),
                        SizedBox(
                            width: 60.w,
                            child: Text(
                              "$type | $time | $days Days  | $members members",
                              style: textStyleBlackR.copyWith(fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ))
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  static GestureDetector joinInfoRectangleBox({
    required BuildContext context,
    required String name,
    VoidCallback? btnPressed,
    required int rank,
    required Color color,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 60,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Asset.userIcon,
                        scale: 4.0,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                          width: 25.w,
                          child: Text(name,
                              style: textStyleBlackR.copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1)),
                    ],
                  ),
                  Text(
                    "Rank $rank",
                    style: textStyleBlackR.copyWith(fontSize: 14),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector myChallengeInfoRectangleBox({
    required BuildContext context,
    required String name,
    VoidCallback? btnPressed,
    bool myAccount = false,
    required int rank,
    required Color color,
    required String imageUrl,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 55,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            Asset.userIcon,
                            scale: 4.0,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          SizedBox(
                              width: 25.w,
                              child: Text(name,
                                  style: textStyleBlackR.copyWith(fontSize: 14),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1)),
                        ],
                      ),
                      Text(
                        "Rank $rank",
                        style: textStyleBlackR.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                myAccount
                    ? Positioned(
                        left: 15,
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.fromBorderSide(
                                  BorderSide(color: Colors.white))),
                        ),
                      )
                    : Container()
              ],
            )),
      ),
    );
  }

  static GestureDetector myChallengeCompletedInfoRectangleBox({
    required BuildContext context,
    required String name,
    VoidCallback? btnPressed,
    required int rank,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 50,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        Asset.userIcon,
                        scale: 5.0,
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      SizedBox(
                          width: 25.w,
                          child: Text(name,
                              style: textStyleBlackR.copyWith(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1)),
                    ],
                  ),
                  Text(
                    "Rank $rank",
                    style: textStyleBlackR.copyWith(fontSize: 14),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector roundText({
    required BuildContext context,
    VoidCallback? btnPressed,
    required String text,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 40,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: textStyleBlackR.copyWith(fontSize: 16),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  static GestureDetector voiceCommandRectangleBox({
    required BuildContext context,
    VoidCallback? btnPressed,
    required String text1,
    required String text2,
    DateTime? time,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () => btnPressed!(),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Container(
            height: 60,
            width: 90.w,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    text1,
                    style: textStyleBlackR.copyWith(fontSize: 16),
                  ),
                  Text(
                    text2,
                    style: textStyleBlackB.copyWith(fontSize: 16),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

badgeDialog(BuildContext context, String streakName, String badge, String text,
    bool win) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Theme(
            data: Theme.of(context).copyWith(
                // useMaterial3: true,
                brightness: Brightness.light,
                dialogBackgroundColor: Colors.white),
            child: AlertDialog(
              // backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              // title: Text("Notice"),
              // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
              actions: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      streakName,
                      style: textStyleBlackB.copyWith(fontSize: 22),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    SizedBox(
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: badge,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 50.w,
                            alignment: Alignment.center,
                            child: Text(
                              text,
                              style: textStyleBlackR.copyWith(fontSize: 14),
                              maxLines: 8,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Asset.clapIcon,
                          scale: 4.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Image.asset(
                          Asset.clapIcon,
                          scale: 4.0,
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        Image.asset(
                          Asset.clapIcon,
                          scale: 4.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    win
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: () {
                                // Get.back();
                                Share.share(streakName);
                              },
                              child: Container(
                                height: 50,
                                width: 80.w,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Share",
                                      style: textStyleBlackB.copyWith(
                                          color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      Asset.shareIcon,
                                      scale: 4.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          );
        });
      });
}

createChallengeDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Icon(
                      Icons.info,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Public Challenges",
                      style: textStyleBlackB.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Are visible on the challenges page and can be joined by anyone.",
                      style: textStyleBlackR.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Private Challenges",
                      style: textStyleBlackB.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Are not visible on the challenges page and participants must be invited by you.",
                      style: textStyleBlackR.copyWith(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: AppButton1(
                        text: "OK",
                        btnPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
      });
}

exitDialog(BuildContext context, CountDownController _countDownController) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Are you sure you want to exit?",
                      style: textStyleBlackB.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Cancel",
                              style: textStyleBlackB.copyWith(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: AppButton1(
                            text: "OK",
                            btnPressed: () {
                              Get.offAll(
                                  () => const CommonNavigationBar(index: 0));
                              _countDownController.pause();
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      });
}

toSettingDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Configure cold exposure durations",
                      style: textStyleBlackB.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Cancel",
                              style: textStyleBlackB.copyWith(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110,
                          child: AppButton1(
                            text: "OK",
                            btnPressed: () {
                              Get.offAll(
                                  () => const CommonNavigationBar(index: 4));
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
      });
}

formatTime(Duration duration) {
  String formattedHours = duration.inMinutes.toString().padLeft(2, '0');
  String formattedMinutes =
      (duration.inSeconds % 60).toString().padLeft(2, '0');
  return '$formattedHours:$formattedMinutes';
}

logOutAlertDialog(BuildContext context) {
  TextEditingController insertController = TextEditingController();
  AuthController authController = Get.find<AuthController>();
  // set up the AlertDialog
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "Logout",
                    style: textStyleBlackB.copyWith(
                        fontSize: 12.sp, height: 0.25.h),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w, right: 5.w),
                    child: Text(
                      "Are you sure you want to logout?",
                      style: textStyleBlackR.copyWith(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: InkWell(
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 50,
                            width: 110,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Cancel",
                              style: textStyleBlackB.copyWith(fontSize: 16.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 110,
                        child: AppButton1(
                          text: "OK",
                          btnPressed: () async {
                            setState(() {
                              print(insertController.text);
                            });
                            // await getData();
                            clearData();
                            authController.logOut(context);
                            setUserLoggedIn(false);
                            if (await getUserType() == "Google") {
                              authController.signOut();
                            }
                            Get.offAll(
                              () => const LoginScreen(),
                            );
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        });
      });
}

successDialog(BuildContext context, String title, String description) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Icon(
                      Icons.done,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      title,
                      style: textStyleBlackB.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: textStyleBlackR.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: AppButton1(
                        text: "OK",
                        btnPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
      });
}

errorDialog(BuildContext context, String title, String description) {
  return showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            // title: Text("Notice"),
            // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
            actions: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Icon(
                      Icons.error,
                      color: Colors.black,
                      size: 40,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      title,
                      style: textStyleBlackB.copyWith(fontSize: 22),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      style: textStyleBlackR.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      width: 150,
                      height: 45,
                      child: AppButton1(
                        text: "OK",
                        btnPressed: () {
                          Get.back();
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        });
      });
}

clearData() {
  AuthController authController = Get.find<AuthController>();
  BadgesController badgesController = Get.find<BadgesController>();
  ChallengeController challengeController = Get.find<ChallengeController>();
  HomeController homeController = Get.find<HomeController>();
  LeadersboardController leadersboardController =
      Get.find<LeadersboardController>();
  SettingController settingController = Get.find<SettingController>();

  authController.fcmToken.value = '';
  authController.userData = null;
  authController.cities = <CityModel>[].obs;
  authController.countries = <CountryModel>[].obs;
  authController.subscriptions = <SubscriptionModel>[].obs;
  authController.token.value = '';

  badgesController.badges.value = false;
  badgesController.badgesData = <BadgesModel>[].obs;

  challengeController.challenge.value = false;
  challengeController.challenges = <ChallengesModel>[].obs;

  homeController.dayShowerData = <ShowersModel>[].obs;
  homeController.showersData = <ShowersModel>[].obs;
  homeController.eventDates = <DateTime>[].obs;

  leadersboardController.leaders.value = false;
  leadersboardController.currentLeaderData = <CurrentLeaderModel>[].obs;
  leadersboardController.pastLeaderData = <PastLeaderModel>[].obs;

  settingController.timerData = <TimerDataModel>[].obs;

  homepageNumbers = [0, 0, 0, 0];
}
