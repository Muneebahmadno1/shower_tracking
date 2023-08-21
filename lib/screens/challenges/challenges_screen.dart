import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/challenges/private_challenge.dart';

import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import 'create_new_challenge.dart';
import 'join_challenge.dart';
import 'my_challenge.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({Key? key}) : super(key: key);

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  bool buttonStatus1 = false;
  bool buttonStatus2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Center(
                child: Text(
              "Join or Create a Challenge",
              style: textStyleBlackB.copyWith(fontSize: 20),
            )),
            SizedBox(height: 2.h),
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
                            "My Challenges",
                            style: textStyleBlackB.copyWith(
                                fontSize: 16, color: Colors.black),
                          )
                        : Text(
                            "My Challenges",
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
                            "Join",
                            style: textStyleBlackB.copyWith(
                                fontSize: 16, color: Colors.white),
                          )
                        : Text(
                            "Join",
                            style: textStyleBlackB.copyWith(
                                fontSize: 16, color: Colors.black),
                          )),
              ],
            ),
            SizedBox(
              height: 2.h,
            ),
            buttonStatus2 == true
                ? const Expanded(child: JoinChallenge())
                : const Expanded(child: MyChallenges()),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const PrivateChallengeScreen());
                    // Get.to(() => const JoinChallengeByCodeScreen());
                  },
                  child: Container(
                    height: 43,
                    width: 50.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Private Challenges",
                      style: textStyleBlackB.copyWith(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  height: 43,
                  width: 36.w,
                  child: AppButton1(
                    text: "Create New",
                    fontSize: 16,
                    btnPressed: () {
                      Get.to(() => const CreateNewChallenge());
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
