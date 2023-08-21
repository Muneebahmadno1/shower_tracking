import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:too_cool/utilities/shimmer_loaders.dart';

import '../../controllers/challenge_controller.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import 'join_info.dart';

class JoinChallenge extends StatefulWidget {
  const JoinChallenge({Key? key}) : super(key: key);

  @override
  State<JoinChallenge> createState() => _JoinChallengeState();
}

class _JoinChallengeState extends State<JoinChallenge> {
  final ChallengeController _challengeController =
      Get.find<ChallengeController>();

  getData() async {
    _challengeController.challenges == []
        ? await _challengeController.getChallenge({}, context)
        : _challengeController.getChallenge({}, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _challengeController.challenge.value == false
          ? Shimmers.challengesShimmer()
          : !_challengeController.challenges
                      .any((challenge) => challenge.self == false) ||
                  !_challengeController.challenges
                      .any((challenge) => challenge.join == false) ||
                  !_challengeController.challenges
                      .any((challenge) => challenge.mode == "Public")
              ? Center(
                  child: Text(
                    "No data found.",
                    style: textStyleBlackR,
                  ),
                )
              : ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _challengeController.challenges.length,
                  itemBuilder: (context, index) {
                    return _challengeController.challenges[index].self ==
                                false &&
                            _challengeController.challenges[index].join ==
                                false &&
                            _challengeController.challenges[index].mode ==
                                "Public"
                        ? RectangleBox.challengeRectangleBox(
                            context: context,
                            color: HexColor('#D8EAFF'),
                            challengeName:
                                _challengeController.challenges[index].title,
                            type: _challengeController.challenges[index].type
                                            .toString() ==
                                        "1" &&
                                    _challengeController.challenges[index].type
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
                            buttonText: 'Join',
                            btnPressed: () {
                              Get.to(() => JoinInfo(
                                    index: index,
                                  ));
                            })
                        : const SizedBox.shrink();
                  },
                ),
    );
  }
}
