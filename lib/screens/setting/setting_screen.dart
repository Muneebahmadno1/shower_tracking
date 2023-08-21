import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/home_controller.dart';
import 'package:too_cool/screens/setting/privacy_policy.dart';
import 'package:too_cool/screens/setting/profile.dart';
import 'package:too_cool/screens/setting/term&condition.dart';
import 'package:too_cool/screens/voice_command/voice_command.dart';
import 'package:too_cool/utilities/constants.dart';

import '../../controllers/setting_controller.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final HomeController _homeController = Get.find<HomeController>();
  final SettingController _settingController = Get.find<SettingController>();
  int minWarmTime = 0;
  int secWarmTime = 0;
  int minColdTime = 0;
  int secColdTime = 0;
  int minPlungeTime = 0;
  int secPlungeTime = 0;

  getData() {
    for (int i = 0; i < _settingController.timerData.length; i++) {
      if (_settingController.timerData[i].title == "Warm Shower Duration") {
        minWarmTime =
            int.parse(_settingController.timerData[i].duration.split(":")[0]);
        secWarmTime =
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      } else if (_settingController.timerData[i].title ==
          "Cold Shower Duration") {
        minColdTime =
            int.parse(_settingController.timerData[i].duration.split(":")[0]);
        secColdTime =
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      } else {
        minPlungeTime =
            int.parse(_settingController.timerData[i].duration.split(":")[0]);
        secPlungeTime =
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 60.0, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                  child: Text(
                "Configure Your Settings",
                style: textStyleBlackB.copyWith(fontSize: 20),
              )),
              SizedBox(
                height: 3.h,
              ),
              Container(
                width: 90.w,
                height: 700,
                decoration: BoxDecoration(
                  color: HexColor('#D8EAFF'),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Warm Shower Duration",
                        style: textStyleBlackR.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 180,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              selectedItemIndex: minWarmTime,
                              highlightBorderRadius: BorderRadius.circular(8),
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  minWarmTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "min",
                              style: textStyleBlackR,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              highlightBorderRadius: BorderRadius.circular(8),
                              selectedItemIndex: secWarmTime,
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  secWarmTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "sec",
                              style: textStyleBlackR,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cold Shower Duration",
                        style: textStyleBlackR.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 180,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              highlightBorderRadius: BorderRadius.circular(8),
                              selectedItemIndex: minColdTime,
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  minColdTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "min",
                              style: textStyleBlackR,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              highlightBorderRadius: BorderRadius.circular(8),
                              selectedItemIndex: secColdTime,
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  secColdTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "sec",
                              style: textStyleBlackR,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cold Plunge Duration",
                        style: textStyleBlackR.copyWith(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 180,
                        width: 80.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              selectedItemIndex: minPlungeTime,
                              highlightBorderRadius: BorderRadius.circular(8),
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  minPlungeTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "min",
                              style: textStyleBlackR,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            SelectorWheel(
                              childCount: 60,
                              width: 35,
                              highlightWidth: 35,
                              highlightBorderRadius: BorderRadius.circular(8),
                              selectedItemIndex: secPlungeTime,
                              // convertIndexToValue is a function that converts the index of the
                              // child to a value that is displayed on the selector wheel. In this
                              // case, we are converting the index to a string. I.e we'll have
                              // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 on the selector wheel.
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: index.toString(),
                                  value: index,
                                  index: index,
                                );
                              },
                              onValueChanged: (SelectorWheelValue<int> value) {
                                // print the value that was selected
                                setState(() {
                                  secPlungeTime = value.value;
                                });
                                print(value);
                              },
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              "sec",
                              style: textStyleBlackR,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              AppButton1(
                text: "Save",
                btnPressed: () {
                  Map<String, String> map = {
                    "title": "Warm Shower Duration",
                    "type": "2",
                    "duration": minWarmTime < 10 && secWarmTime < 10
                        ? "0$minWarmTime:0$secWarmTime"
                        : minWarmTime < 10
                            ? "0$minWarmTime:$secWarmTime"
                            : secWarmTime < 10
                                ? "$minWarmTime:0$secWarmTime"
                                : "$minWarmTime:$secWarmTime",
                  };
                  _homeController.addSession(map, false, context,2);
                  map = {
                    "title": "Cold Shower Duration",
                    "type": "1",
                    "duration": minColdTime < 10 && secColdTime < 10
                        ? "0$minColdTime:0$secColdTime"
                        : minColdTime < 10
                            ? "0$minColdTime:$secColdTime"
                            : secColdTime < 10
                                ? "$minColdTime:0$secColdTime"
                                : "$minColdTime:$secColdTime",
                  };
                  _homeController.addSession(map, false, context,2);
                  map = {
                    "title": "Cold Plunge Duration",
                    "type": "3",
                    "duration": minPlungeTime < 10 && secPlungeTime < 10
                        ? "0$minPlungeTime:0$secPlungeTime"
                        : minPlungeTime < 10
                            ? "0$minPlungeTime:$secPlungeTime"
                            : secPlungeTime < 10
                                ? "$minPlungeTime:0$secPlungeTime"
                                : "$minPlungeTime:$secPlungeTime",
                  };
                  _homeController.addSession(map, false, context,2);
                  _settingController.getTimerData({}, context);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const ProfileScreen());
                },
                child: Container(
                  width: 90.w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Profile",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const VoiceCommandScreen());
                },
                child: Container(
                  width: 90.w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Voice Command",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const TermConditionScreen());
                },
                child: Container(
                  width: 90.w,
                  height: 50,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Terms & Conditions",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => const PrivacyPolicyScreen());
                },
                child: Container(
                  width: 90.w,
                  height: 55,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Privacy Policy",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 90.w,
                  height: 55,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Report issue",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  logOutAlertDialog(context);
                },
                child: Container(
                  width: 90.w,
                  height: 55,
                  decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Logout",
                          style: textStyleBlackR.copyWith(fontSize: 18),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "version 4.0.2",
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
