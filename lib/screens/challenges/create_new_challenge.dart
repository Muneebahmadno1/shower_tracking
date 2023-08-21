import 'package:animated_switch/animated_switch.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/challenge_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class CreateNewChallenge extends StatefulWidget {
  const CreateNewChallenge({Key? key}) : super(key: key);

  @override
  State<CreateNewChallenge> createState() => _CreateNewChallengeState();
}

class _CreateNewChallengeState extends State<CreateNewChallenge> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ChallengeController _challengeController = Get.find();
  bool buttonStatus1 = true;
  bool buttonStatus2 = false;
  TextEditingController nameController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  bool state = false;
  int minTime = 0;
  int secTime = 0;

  datePickerDialog(BuildContext context, int index) {
    DateTime startDate = _startDate;
    DateTime endDate = _endDate;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              // title: Text("Notice"),
              // content: Text("Launching this missile will destroy the entire universe. Is this what you intended to do?"),
              actions: [
                const SizedBox(
                  height: 20,
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
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Text(
                  "Select Day",
                  style: textStyleBlackB.copyWith(fontSize: 21),
                )),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 300,
                  width: 350,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.single,
                        firstDate: DateTime.now(),
                        selectedDayHighlightColor: Colors.black),
                    value: index == 1 ? [startDate] : [endDate],
                    onValueChanged: (dates) => index == 1
                        ? startDate = dates[0]!
                        : endDate = dates[0]!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0),
                  child: AppButton1(
                    text: "Okay",
                    btnPressed: () {
                      setState(() {
                        index == 1
                            ? _startDate = startDate
                            : _endDate = endDate;
                        _endDate.isBefore(_startDate)
                            ? _endDate = _startDate
                            : null;
                      });
                      Get.back();
                    },
                  ),
                )
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        elevation: 0,
        title: Text(
          "Create a Challenge",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 2.5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonStatus2 = false;
                            buttonStatus1 = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              side: BorderSide(color: Colors.black)),
                          fixedSize: Size(44.w, 45),
                          backgroundColor: (buttonStatus1 == false)
                              ? Colors.white
                              : Colors.black,
                          shadowColor: Colors.white,
                          padding: const EdgeInsets.symmetric(),
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: (buttonStatus1 == false)
                            ? Text(
                                "Shower",
                                style: textStyleBlackB.copyWith(
                                    fontSize: 16, color: Colors.black),
                              )
                            : Text(
                                "Shower",
                                style: textStyleBlackB.copyWith(
                                    fontSize: 16, color: Colors.white),
                              )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonStatus2 = true;
                            buttonStatus1 = false;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                                side: BorderSide(color: Colors.black)),
                            fixedSize: Size(44.w, 45),
                            backgroundColor: (buttonStatus2 == false)
                                ? Colors.white
                                : Colors.black,
                            padding: const EdgeInsets.symmetric(),
                            shadowColor: Colors.white,
                            textStyle: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            )),
                        child: (buttonStatus2 == true)
                            ? Text(
                                "Plunge",
                                style: textStyleBlackB.copyWith(
                                    fontSize: 16, color: Colors.white),
                              )
                            : Text(
                                "Plunge",
                                style: textStyleBlackB.copyWith(
                                    fontSize: 16, color: Colors.black),
                              )),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      height: 53,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: HexColor('#D8EAFF'),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Name",
                              style: textStyleBlackR.copyWith(fontSize: 17),
                            ),
                            SizedBox(
                                height: 38,
                                width: 65.w,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: nameController,
                                  cursorColor: Colors.black,
                                  textAlignVertical: TextAlignVertical.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: AppColors.borderColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide(
                                            color: AppColors.borderColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: AppColors.borderColor),
                                      ),
                                      errorStyle: const TextStyle(
                                        color: Colors.red,
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(
                                          left: 2.w, right: 2.w)),
                                )),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      height: 50,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: HexColor('#D8EAFF'),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Start Date",
                              style: textStyleBlackR.copyWith(fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await datePickerDialog(context, 1);
                                setState(() {});
                              },
                              child: Container(
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      DateFormat.yMMMMd('en_US')
                                          .format(_startDate),
                                      style: textStyleBlackR.copyWith(
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      height: 50,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: HexColor('#D8EAFF'),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "End Date",
                              style: textStyleBlackR.copyWith(fontSize: 17),
                            ),
                            GestureDetector(
                              onTap: () async {
                                await datePickerDialog(context, 2);
                                setState(() {});
                              },
                              child: Container(
                                  height: 33,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0),
                                    child: Text(
                                      DateFormat.yMMMMd('en_US')
                                          .format(_endDate),
                                      style: textStyleBlackR.copyWith(
                                          fontSize: 16.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                      height: 220,
                      width: 90.w,
                      decoration: BoxDecoration(
                          color: HexColor('#D8EAFF'),
                          borderRadius: BorderRadius.circular(7)),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration",
                              style: textStyleBlackR.copyWith(fontSize: 17),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 156,
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
                                    highlightBorderRadius:
                                        BorderRadius.circular(8),
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
                                    onValueChanged:
                                        (SelectorWheelValue<int> value) {
                                      // print the value that was selected
                                      setState(() {
                                        minTime = value.value;
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
                                    highlightBorderRadius:
                                        BorderRadius.circular(8),
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
                                    onValueChanged:
                                        (SelectorWheelValue<int> value) {
                                      // print the value that was selected
                                      setState(() {
                                        secTime = value.value;
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
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 130,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Is this a private challenge?",
                    style: textStyleBlackR,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedSwitch(
                        value: state,
                        onChanged: (value) {
                          state = value;
                        },
                        colorOn: Colors.black,
                        colorOff: HexColor('#B7B7B7'),
                        indicatorColor: Colors.white,
                        height: 30,
                        width: 60,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                          onTap: () {
                            createChallengeDialog(context);
                          },
                          child: const Icon(
                            Icons.info,
                            color: Colors.black,
                            size: 30,
                          )),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AppButton1(
                text: "Create Challenge",
                btnPressed: () {
                  setState(() {
                    variable = true;
                  });
                  if (formKey.currentState!.validate()) {
                    Map<String, String> map = {
                      "title": nameController.text,
                      "type": buttonStatus1 == true ? "1" : "3",
                      "duration": minTime < 10 && secTime < 10
                          ? "0$minTime:0$secTime"
                          : minTime < 10
                              ? "0$minTime:$secTime"
                              : secTime < 10
                                  ? "$minTime:0$secTime"
                                  : "$minTime:$secTime",
                      "start_date": _startDate.toString().substring(0, 10),
                      "end_date": _endDate.toString().substring(0, 10),
                      "mode": state ? "2" : "1"
                    };
                    _challengeController.createChallenge(map, context);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
