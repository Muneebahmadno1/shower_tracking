import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/shimmer_loaders.dart';

import '../../controllers/leaderboard_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class LeadersScreen extends StatefulWidget {
  const LeadersScreen({Key? key}) : super(key: key);

  @override
  State<LeadersScreen> createState() => _LeadersScreenState();
}

class _LeadersScreenState extends State<LeadersScreen> {
  LeadersboardController leadersboardController =
      Get.find<LeadersboardController>();
  AuthController authController = Get.find<AuthController>();
  bool buttonStatus1 = false;
  bool buttonStatus2 = true;

  getData() async {
    Map<String, String> map = {"type": "1"};
    await leadersboardController.getCurrentLeaderboard(map, context);
    map = {"type": "2"};
    await leadersboardController.getPastLeaderboard(map, context);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              Center(
                  child: Text(
                "My current standing",
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
                              "Past Winners",
                              style: textStyleBlackB.copyWith(
                                  fontSize: 16, color: Colors.black),
                            )
                          : Text(
                              "Past Winners",
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
                              "Current Leaders",
                              style: textStyleBlackB.copyWith(
                                  fontSize: 16, color: Colors.white),
                            )
                          : Text(
                              "Current Leaders",
                              style: textStyleBlackB.copyWith(
                                  fontSize: 16, color: Colors.black),
                            )),
                ],
              ),
              leadersboardController.leaders.value == true
                  ? SizedBox(
                      height: 2.h,
                    )
                  : Container(),
              leadersboardController.leaders.value == false
                  ? Expanded(
                      child: SizedBox(
                        child: Shimmers.listTileShimmer(),
                      ),
                    )
                  : buttonStatus1
                      ? Expanded(
                          child: Column(
                            children: [
                              for (int i = 0;
                                  i <
                                      leadersboardController
                                          .pastLeaderData.length;
                                  i++)
                                RectangleBox.leaderRectangleBox(
                                  context: context,
                                  color: leadersColors[i],
                                  month: leadersboardController
                                      .pastLeaderData[i].date,
                                  number: leadersboardController
                                      .pastLeaderData[i].totalSessions,
                                  name: leadersboardController
                                      .pastLeaderData[i].userName,
                                  rank: leadersboardController
                                      .pastLeaderData[i].rank,
                                  myAccount: leadersboardController
                                              .pastLeaderData[i].id ==
                                          authController.userData!.id
                                      ? true
                                      : false,
                                  border: leadersboardController
                                          .pastLeaderData[i].id ==
                                      authController.userData!.id,
                                  image: leadersboardController
                                              .pastLeaderData[i].profileImage ==
                                          "https://toocool.beckapps.co/"
                                      ? ""
                                      : leadersboardController
                                          .pastLeaderData[i].profileImage,
                                  btnPressed: () {},
                                ),
                              // RectangleBox.leaderRectangleBox(
                              //     context: context,
                              //     color: HexColor('#EFEFEF'),
                              //     number: 1,
                              //     month: "May 2023",
                              //     name: "My account",
                              //     myAccount: true,
                              //     rank: 104,
                              //     border: true),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                "This list shows the previous leaderboard winners with the month in which they ended at the top of the leaderboard.",
                                style: textStyleBlackR.copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        )
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (int i = 0;
                                  i <
                                      leadersboardController
                                          .currentLeaderData.length;
                                  i++)
                                RectangleBox.leaderRectangleBox(
                                  context: context,
                                  color: leadersColors[i],
                                  number: leadersboardController
                                      .currentLeaderData[i].totalSessions,
                                  image: leadersboardController
                                              .currentLeaderData[i]
                                              .profileImage ==
                                          "https://toocool.beckapps.co/"
                                      ? ""
                                      : leadersboardController
                                          .currentLeaderData[i].profileImage,
                                  name: leadersboardController
                                      .currentLeaderData[i].userName,
                                  myAccount: leadersboardController
                                              .currentLeaderData[i].id ==
                                          authController.userData!.id
                                      ? true
                                      : false,
                                  border: leadersboardController
                                              .currentLeaderData[i].id ==
                                          authController.userData!.id
                                      ? true
                                      : false,
                                  rank: leadersboardController
                                      .currentLeaderData[i].rank,
                                  btnPressed: () {},
                                ),
                              // RectangleBox.leaderRectangleBox(
                              //     context: context,
                              //     color: HexColor('#EFEFEF'),
                              //     number: 1,
                              //     name: "My account",
                              //     myAccount: true,
                              //     rank: 104,
                              //     border: true),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                "The leaderboard is based on your current streak.",
                                style: textStyleBlackR.copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "At the end of each month who ever is in top spot will receive some awesome TooCool Swag.",
                                style: textStyleBlackB.copyWith(fontSize: 14),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                "Terms and Conditions apply",
                                style: textStyleBlackR.copyWith(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                            ],
                          ),
                        )
            ],
          ),
        ),
      ),
    );
  }
}
