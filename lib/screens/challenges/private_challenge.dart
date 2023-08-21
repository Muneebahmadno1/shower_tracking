import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/challenge_controller.dart';
import 'package:too_cool/screens/challenges/my_challenge_info.dart';
import 'package:too_cool/screens/challenges/my_challenge_info_complete.dart';
import 'package:too_cool/screens/challenges/my_challenge_info_upcoming.dart';
import 'package:too_cool/utilities/constants.dart';

import '../../utilities/shimmer_loaders.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import 'join_challenge_by_code.dart';

class PrivateChallengeScreen extends StatefulWidget {
  const PrivateChallengeScreen({Key? key}) : super(key: key);

  @override
  State<PrivateChallengeScreen> createState() => _PrivateChallengeScreenState();
}

class _PrivateChallengeScreenState extends State<PrivateChallengeScreen> {
  final ChallengeController _challengeController = Get.find();
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
          "Private Challenges",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => Column(
              children: [
                SizedBox(
                    height: 70.h,
                    child: _challengeController.challenge.value == false
                        ? Shimmers.challengesShimmer()
                        : _challengeController.challenges
                                .any((challenge) => challenge.mode == "Private")
                            ? ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    _challengeController.challenges.length,
                                itemBuilder: (context, index) {
                                  return _challengeController
                                              .challenges[index].mode ==
                                          "Private"
                                      ? RectangleBox
                                          .privateChallengeRectangleBox(
                                              context: context,
                                              color: HexColor('#D8EAFF'),
                                              challengeName:
                                                  _challengeController
                                                      .challenges[index].title,
                                              type: _challengeController
                                                              .challenges[index]
                                                              .type
                                                              .toString() ==
                                                          "1" &&
                                                      _challengeController
                                                              .challenges[index]
                                                              .type
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
                                                  .challenges[index]
                                                  .challengesMembers
                                                  .length
                                                  .toString(),
                                              btnPressed: () {
                                                _challengeController
                                                            .challenges[index]
                                                            .status
                                                            .toString() ==
                                                        "active"
                                                    ? Get.to(() =>
                                                        MyChallengeInfo(
                                                            index: index))
                                                    : _challengeController
                                                                .challenges[
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "completed"
                                                        ? Get.to(() =>
                                                            MyChallengeInfoComplete(
                                                                index: index))
                                                        : Get.to(() =>
                                                            MyChallengeInfoUpComing(
                                                                index: index));
                                              })
                                      : const SizedBox.shrink();
                                },
                              )
                            : Center(
                                child: Text(
                                  "No data found",
                                  style: textStyleBlackR,
                                ),
                              )),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        alignment: Alignment.topCenter,
        child: AppButton1(
          text: "Join Challenge By Code",
          btnPressed: () async {
            Get.to(() => const JoinChallengeByCodeScreen());
          },
        ),
      ),
    );
  }
}
