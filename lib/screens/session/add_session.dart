import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:sizer/sizer.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

import '../../controllers/home_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({Key? key}) : super(key: key);

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  DateTime _startDate = DateTime.now();
  DateTime dateTime = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool buttonStatus1 = true;
  bool buttonStatus2 = false;
  String selectedTime = '';
  final HomeController _homeController = Get.find();
  int minTime = 0;
  int secTime = 0;

  timePickerDialog(BuildContext context) {
    DateTime time = dateTime;
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
                  "Select Time",
                  style: textStyleBlackB.copyWith(fontSize: 21),
                )),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TimePickerSpinner(
                    locale: const Locale('en', ''),
                    time: time,
                    is24HourMode: false,
                    isShowSeconds: false,
                    itemHeight: 40,
                    normalTextStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    highlightedTextStyle:
                        const TextStyle(fontSize: 18, color: Colors.blue),
                    isForce2Digits: true,
                    onTimeChange: (changeTime) {
                      setState(() {
                        time = changeTime;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0),
                  child: AppButton1(
                    text: "Okay",
                    btnPressed: () {
                      setState(() {
                        dateTime = time;
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

  datePickerDialog(BuildContext context) {
    DateTime date = _startDate;
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
                Container(
                  height: 300,
                  width: 350,
                  child: CalendarDatePicker2(
                    config: CalendarDatePicker2Config(
                        calendarType: CalendarDatePicker2Type.single,
                        lastDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 2)),
                        selectedDayHighlightColor: Colors.black),
                    value: [dateTime],
                    onValueChanged: (dates) => dateTime = dates[0]!,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, bottom: 10.0),
                  child: AppButton1(
                    text: "Okay",
                    btnPressed: () {
                      setState(() {
                        _startDate = dateTime;
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
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Add Session",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 4.h,
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
                            side: BorderSide(color: Colors.black),
                          ),
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
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    height: 58,
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
                            "When",
                            style: textStyleBlackR.copyWith(fontSize: 16),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await datePickerDialog(context);
                                  setState(() {});
                                },
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        DateFormat.yMMMMd('en_US')
                                            .format(_startDate),
                                        style: textStyleBlackR.copyWith(
                                            fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await timePickerDialog(context);
                                  setState(() {});
                                },
                                child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: Colors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        DateFormat('hh:mm a')
                                            .format(dateTime)
                                            .toString(),
                                        style: textStyleBlackR.copyWith(
                                            fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    )),
                              ),
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                    height: 220,
                    width: 90.w,
                    decoration: BoxDecoration(
                        color: HexColor('#D8EAFF'),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Duration",
                            style: textStyleBlackR.copyWith(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 156,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
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
                                    setState(() {
                                      secTime = value.value;
                                    });
                                    // print the value that was selected
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
      bottomNavigationBar: Container(
        height: 90,
        alignment: Alignment.topCenter,
        child: AppButton1(
            text: "Save Session",
            btnPressed: () {
              setState(() {
                variable = true;
              });
              if (formKey.currentState!.validate()) {
                Map<String, String> map = {
                  "title": buttonStatus1 == true
                      ? "Cold Shower Duration"
                      : "Cold Plunge Duration",
                  "type": buttonStatus1 == true ? "1" : "3",
                  "duration": minTime < 10 && secTime < 10
                      ? "0$minTime:0$secTime"
                      : minTime < 10
                          ? "0$minTime:$secTime"
                          : secTime < 10
                              ? "$minTime:0$secTime"
                              : "$minTime:$secTime",
                  "date": _startDate.toString().substring(0, 10),
                };
                _homeController.addSession(map, true, context, 1);
              }
            }),
      ),
    );
  }
}
