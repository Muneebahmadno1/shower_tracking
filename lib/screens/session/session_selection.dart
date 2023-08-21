import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';
import 'package:too_cool/screens/timer/cold_plunge.dart';
import 'package:too_cool/screens/timer/warmTimer.dart';

import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class SessionSelectionScreen extends StatefulWidget {
  const SessionSelectionScreen({Key? key}) : super(key: key);

  @override
  State<SessionSelectionScreen> createState() => _SessionSelectionScreenState();
}

class _SessionSelectionScreenState extends State<SessionSelectionScreen> {
  bool buttonStatus1 = true;
  bool buttonStatus2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.offAll(const CommonNavigationBar(index: 0));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Select Session Type",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                            ),
                            side: BorderSide(color: Colors.black),
                          ),
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
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "You’ve got this! \nTake a deep breath \n& relax into the cold.",
                    style: textStyleBlackB.copyWith(fontSize: 28),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          height: 90,
          alignment: Alignment.topCenter,
          child: AppButton1(
              text: "Start",
              btnPressed: () {
                buttonStatus1
                    ? Get.to(() => const WarmTimerScreen())
                    : Get.to(() => const ColdPlungeScreen(
                          continuePlunge: false,
                          previousTime: 0,
                        ));
              })),
    );
  }
}
