import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/challenge_controller.dart';

import '../../controllers/auth_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class MyChallengeInfoUpComing extends StatefulWidget {
  MyChallengeInfoUpComing({Key? key, required this.index}) : super(key: key);
  int index;
  @override
  State<MyChallengeInfoUpComing> createState() =>
      _MyChallengeInfoUpComingState();
}

class _MyChallengeInfoUpComingState extends State<MyChallengeInfoUpComing> {
  final ChallengeController _challengeController = Get.find();
  final AuthController authController = Get.find();
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
          "Challenge Name",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 4.h,
              ),
              Row(
                children: [
                  Text(
                    "Type: ",
                    style: textStyleBlackB.copyWith(fontSize: 15),
                  ),
                  Text(
                    _challengeController.challenges[widget.index].type
                                    .toString() ==
                                "1" &&
                            _challengeController.challenges[widget.index].type
                                    .toString() ==
                                "2"
                        ? "Shower"
                        : "Plunge" + ", Public",
                    style: textStyleBlackR.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "Time: ",
                    style: textStyleBlackB.copyWith(fontSize: 15),
                  ),
                  Text(
                    _challengeController.challenges[widget.index].time
                        .toString(),
                    style: textStyleBlackR.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "Days: ",
                    style: textStyleBlackB.copyWith(fontSize: 15),
                  ),
                  Text(
                    _challengeController.challenges[widget.index].days
                        .toString(),
                    style: textStyleBlackR.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "Start Date: ",
                    style: textStyleBlackB.copyWith(fontSize: 15),
                  ),
                  Text(
                    _challengeController.challenges[widget.index].startDate
                        .toString(),
                    style: textStyleBlackR.copyWith(fontSize: 15),
                  ),
                ],
              ),
              const SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Text(
                    "End Date: ",
                    style: textStyleBlackB.copyWith(fontSize: 15),
                  ),
                  Text(
                    _challengeController.challenges[widget.index].endDate
                        .toString(),
                    style: textStyleBlackR.copyWith(fontSize: 15),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                "${_challengeController.challenges[widget.index].challengesMembers.length} Members",
                style: textStyleBlackB.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 10.0,
              ),
              AppButton1(
                text: "Invite more friends",
                btnPressed: () {},
              ),
              SizedBox(
                height: 2.h,
              ),
              // RectangleBox.myChallengeInfoRectangleBox(
              //     context: context,
              //     color: HexColor("#EFEFEF"),
              //     name: "Erick Schmit",
              //     myAccount: true,
              //     rank: 12,
              //     imageUrl: ''),
              for (int i = 0;
                  i <
                      _challengeController
                          .challenges[widget.index].challengesMembers.length;
                  i++)
                RectangleBox.myChallengeInfoRectangleBox(
                    context: context,
                    color: HexColor("#C7E1FF"),
                    name: _challengeController
                        .challenges[widget.index].challengesMembers[i].userName
                        .toString(),
                    rank: _challengeController
                        .challenges[widget.index].challengesMembers[i].rank,
                    myAccount: _challengeController.challenges[widget.index]
                                .challengesMembers[i].fkUserId ==
                            authController.userData!.id.toString()
                        ? true
                        : false,
                    imageUrl: _challengeController.challenges[widget.index]
                        .challengesMembers[i].profileImage
                        .toString()),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        alignment: Alignment.topCenter,
        child: RectangleBox.roundText(
            context: context,
            text: "This challenge starts on May 15, 2023",
            color: HexColor('#FFE5A0')),
      ),
    );
  }
}
