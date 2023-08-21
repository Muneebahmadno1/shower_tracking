import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';

import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class FinishCreatingNewChallengeScreen extends StatefulWidget {
  FinishCreatingNewChallengeScreen({Key? key, required this.shareCode})
      : super(key: key);
  String shareCode;
  @override
  State<FinishCreatingNewChallengeScreen> createState() =>
      _FinishCreatingNewChallengeScreenState();
}

class _FinishCreatingNewChallengeScreenState
    extends State<FinishCreatingNewChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.offAll(const CommonNavigationBar(index: 2));
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(
          "Create a Challenge",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: SizedBox(
            height: 72.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    Image.asset(
                      Asset.partyIcon,
                      scale: 4.0,
                    ),
                    Text(
                      "Challenges are much more fun with friends and family",
                      style: textStyleBlackR.copyWith(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 9.h,
                    ),
                    Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(""),
                            Text(
                              widget.shareCode.toString(),
                              style: textStyleBlackR.copyWith(fontSize: 20),
                            ),
                            GestureDetector(
                              onTap: () {
                                final snackBar = SnackBar(
                                  content: const Text('Copied to Clipboard'),
                                  action: SnackBarAction(
                                    label: '',
                                    onPressed: () {},
                                  ),
                                );
                                Clipboard.setData(ClipboardData(
                                        text: widget.shareCode.toString()))
                                    .then((value) {
                                  //only if ->
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      snackBar); // -> show a notification
                                });
                              },
                              child: const Icon(
                                Icons.copy,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        "Share this code via text or email to invite friends to your challenge",
                        style: textStyleBlackR.copyWith(fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Invite via text",
                          style: textStyleBlackB.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 55,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Invite via email",
                          style: textStyleBlackB.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: AppButton1(
              text: "Finish",
              btnPressed: () {
                Get.to(() => const CommonNavigationBar(index: 3));
              }),
        ),
      ),
    );
  }
}
