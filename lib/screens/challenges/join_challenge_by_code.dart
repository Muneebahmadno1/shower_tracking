import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/challenge_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class JoinChallengeByCodeScreen extends StatefulWidget {
  const JoinChallengeByCodeScreen({Key? key}) : super(key: key);

  @override
  State<JoinChallengeByCodeScreen> createState() =>
      _JoinChallengeByCodeScreenState();
}

class _JoinChallengeByCodeScreenState extends State<JoinChallengeByCodeScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _codeController = TextEditingController();
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
          "Join a Private Challenge",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: formKey,
            child: Container(
              height: 85.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "Enter the challenge code to join",
                        style: textStyleBlackR.copyWith(fontSize: 18),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            fillColor: AppColors.background,
                            filled: true,
                            hintText: "Enter challenge code here",
                            hintStyle: textStyleBlackR.copyWith(
                              fontSize: 16.0,
                              color: AppColors.hintColor,
                            )),
                        textAlign: TextAlign.center,
                        controller: _codeController,
                      ),
                    ],
                  ),
                  // Column(
                  //   children: [
                  //     AppButton1(
                  //         text: "Join this Challenge",
                  //         btnPressed: () {
                  //           setState(() {
                  //             variable = true;
                  //           });
                  //           if (formKey.currentState!.validate()) {
                  //             // Get.to(()=>const SubscribeScreen());
                  //           }
                  //         }),
                  //     SizedBox(
                  //       height: 4.h,
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 90,
        alignment: Alignment.topCenter,
        child: AppButton1(
            text: "Join this Challenge",
            btnPressed: () {
              setState(() {
                variable = true;
              });
              if (formKey.currentState!.validate()) {
                Map<String, String> map = {"share_code": _codeController.text};
                _challengeController.joinChallenge(map, context);
                // Get.to(()=>const SubscribeScreen());
              }
            }),
      ),
    );
  }
}
