import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/challenge_controller.dart';
import 'package:too_cool/screens/challenges/my_challenge_info_complete.dart';
import 'package:too_cool/screens/challenges/my_challenge_info_upcoming.dart';

import '../../utilities/constants.dart';
import '../../utilities/shimmer_loaders.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import 'my_challenge_info.dart';

class MyChallenges extends StatefulWidget {
  const MyChallenges({Key? key}) : super(key: key);

  @override
  State<MyChallenges> createState() => _MyChallengesState();
}

class _MyChallengesState extends State<MyChallenges> {
  final ChallengeController _challengeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "active") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? Text(
                    "My Active Challenges",
                    style: textStyleBlackB.copyWith(fontSize: 16),
                  )
                : const SizedBox.shrink(),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "active") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? SizedBox(
                    height: 5,
                  )
                : const SizedBox.shrink(),
            _challengeController.challenge.value == false
                ? SizedBox(
                    height: 60.h,
                    child: Shimmers.challengesShimmer(),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _challengeController.challenges.length,
                    itemBuilder: (context, index) {
                      return _challengeController.challenges[index].status ==
                                  "active" &&
                              _challengeController.challenges[index].mode ==
                                  "Public" && _challengeController.challenges[index].join ==
                          true
                          ? RectangleBox.challengeRectangleBox(
                              context: context,
                              color: HexColor('#83BCFF'),
                              challengeName: _challengeController
                                  .challenges[index].title
                                  .toString(),
                              type: _challengeController.challenges[index].type
                                              .toString() ==
                                          "1" ||
                                      _challengeController
                                              .challenges[index].type
                                              .toString() ==
                                          "2"
                                  ? "Shower"
                                  : "Plunge",
                              time: _challengeController.challenges[index].time
                                  .toString(),
                              days: _challengeController.challenges[index].days
                                  .toString(),
                              members: _challengeController
                                  .challenges[index].challengesMembers.length
                                  .toString(),
                              buttonText: 'Info',
                              btnPressed: () {
                                Get.to(() => MyChallengeInfo(
                                      index: index,
                                    ));
                              })
                          : Container();
                    },
                  ),
            // for (int i = 0; i < _challengeController.challenges.length; i++)
            //   _challengeController.challenges[i].status == "active" &&
            //           _challengeController.challenges[i].mode == "Public"
            //       ? RectangleBox.challengeRectangleBox(
            //           context: context,
            //           color: HexColor('#83BCFF'),
            //           challengeName:
            //               _challengeController.challenges[i].title.toString(),
            //           type:
            //               _challengeController.challenges[i].type.toString() ==
            //                           "1" ||
            //                       _challengeController.challenges[i].type
            //                               .toString() ==
            //                           "2"
            //                   ? "Shower"
            //                   : "Plunge",
            //           time: _challengeController.challenges[i].time.toString(),
            //           days: _challengeController.challenges[i].days.toString(),
            //           members: _challengeController
            //               .challenges[i].challengesMembers.length
            //               .toString(),
            //           buttonText: 'Info',
            //           btnPressed: () {
            //             Get.to(() => MyChallengeInfo(
            //                   index: i,
            //                 ));
            //           })
            //       : Container(),
            const SizedBox(
              height: 10,
            ),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "completed") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? Text(
                    "My Completed Challenges",
                    style: textStyleBlackB.copyWith(fontSize: 16),
                  )
                : const SizedBox.shrink(),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "completed") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? SizedBox(
                    height: 5,
                  )
                : const SizedBox.shrink(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _challengeController.challenges.length,
              itemBuilder: (context, index) {
                return _challengeController.challenges[index].status ==
                            "completed" &&
                        _challengeController.challenges[index].mode == "Public"
                    && _challengeController.challenges[index].join ==
                        true
                    ? RectangleBox.challengeRectangleBox(
                        context: context,
                        color: HexColor('#D8EAFF'),
                        challengeName: _challengeController
                            .challenges[index].title
                            .toString(),
                        type: _challengeController.challenges[index].type
                                        .toString() ==
                                    "1" ||
                                _challengeController.challenges[index].type
                                        .toString() ==
                                    "2"
                            ? "Shower"
                            : "Plunge",
                        time: _challengeController.challenges[index].time
                            .toString(),
                        days: _challengeController
                            .challenges[index].days
                            .toString(),
                        members: _challengeController
                            .challenges[index].challengesMembers.length
                            .toString(),
                        buttonText: 'Info',
                        btnPressed: () {
                          Get.to(() => MyChallengeInfoComplete(
                                index: index,
                              ));
                        })
                    : const SizedBox.shrink();
              },
            ),
            // for (int i = 0; i < _challengeController.challenges.length; i++)
            //   _challengeController.challenges[i].status == "completed" &&
            //           _challengeController.challenges[i].mode == "Public"
            //       ? RectangleBox.challengeRectangleBox(
            //           context: context,
            //           color: HexColor('#D8EAFF'),
            //           challengeName:
            //               _challengeController.challenges[i].title.toString(),
            //           type:
            //               _challengeController.challenges[i].type.toString() ==
            //                           "1" ||
            //                       _challengeController.challenges[i].type
            //                               .toString() ==
            //                           "2"
            //                   ? "Shower"
            //                   : "Plunge",
            //           time: _challengeController.challenges[i].time.toString(),
            //           days: _challengeController.challenges[i].days.toString(),
            //           members: _challengeController
            //               .challenges[i].challengesMembers.length
            //               .toString(),
            //           buttonText: 'Info',
            //           btnPressed: () {
            //             Get.to(() => MyChallengeInfoComplete(
            //                   index: i,
            //                 ));
            //           })
            //       : const SizedBox.shrink(),
            const SizedBox(
              height: 10,
            ),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "upcoming") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? Text(
                    "My UpComing Challenges",
                    style: textStyleBlackB.copyWith(fontSize: 16),
                  )
                : const SizedBox.shrink(),
            _challengeController.challenges
                    .any((challenge) => challenge.status == "upcoming") && _challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? SizedBox(
                    height: 5,
                  )
                : const SizedBox.shrink(),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _challengeController.challenges.length,
              itemBuilder: (context, index) {
                return _challengeController.challenges[index].status ==
                            "upcoming" &&
                        _challengeController.challenges[index].mode == "Public"
                    && _challengeController.challenges[index].join ==
                        true
                    ? RectangleBox.challengeRectangleBox(
                        context: context,
                        color: HexColor('#83BCFF'),
                        challengeName: _challengeController
                            .challenges[index].title
                            .toString(),
                        type: _challengeController.challenges[index].type
                                        .toString() ==
                                    "1" ||
                                _challengeController.challenges[index].type
                                        .toString() ==
                                    "2"
                            ? "Shower"
                            : "Plunge",
                        time: _challengeController
                            .challenges[index].time
                            .toString(),
                        days: _challengeController
                            .challenges[index].days
                            .toString(),
                        members: _challengeController
                            .challenges[index].challengesMembers.length
                            .toString(),
                        buttonText: 'Info',
                        btnPressed: () {
                          Get.to(() => MyChallengeInfoUpComing(
                                index: index,
                              ));
                        })
                    : const SizedBox.shrink();
              },
            ),
            !_challengeController.challenges
                        .any((challenge) => challenge.status == "upcoming") &&
                    !_challengeController.challenges
                        .any((challenge) => challenge.status == "active") &&
                    !_challengeController.challenges
                        .any((challenge) => challenge.status == "completed") || !_challengeController.challenges
                .any((challenge) => challenge.join == true)
                ? Container(
              height: 40.h,
              alignment: Alignment.center,
                  child: Center(
                      child: Text(
                        "No data found.",
                        style: textStyleBlackR,
                      ),
                    ),
                )
                : Container()
            // for (int i = 0; i < _challengeController.challenges.length; i++)
            //   _challengeController.challenges[i].status == "upcoming" &&
            //           _challengeController.challenges[i].mode == "Public"
            //       ? RectangleBox.challengeRectangleBox(
            //           context: context,
            //           color: HexColor('#83BCFF'),
            //           challengeName:
            //               _challengeController.challenges[i].title.toString(),
            //           type:
            //               _challengeController.challenges[i].type.toString() ==
            //                           "1" ||
            //                       _challengeController.challenges[i].type
            //                               .toString() ==
            //                           "2"
            //                   ? "Shower"
            //                   : "Plunge",
            //           time: _challengeController.challenges[i].time.toString(),
            //           days: _challengeController.challenges[i].days.toString(),
            //           members: _challengeController
            //               .challenges[i].challengesMembers.length
            //               .toString(),
            //           buttonText: 'Info',
            //           btnPressed: () {
            //             Get.to(() => MyChallengeInfoUpComing(
            //                   index: i,
            //                 ));
            //           })
            //       : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
