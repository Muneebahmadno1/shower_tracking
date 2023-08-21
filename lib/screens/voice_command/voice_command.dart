import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';

class VoiceCommandScreen extends StatefulWidget {
  const VoiceCommandScreen({Key? key}) : super(key: key);

  @override
  State<VoiceCommandScreen> createState() => _VoiceCommandScreenState();
}

class _VoiceCommandScreenState extends State<VoiceCommandScreen> {
  getPermission() async {
    if (await Permission.microphone.request().isGranted) {
      // Either the permission was already granted before or the user just granted it.
    }
    // askForPermissions();
  }

  // Future askForPermissions() async {
  //   Map<PermissionGroup, PermissionStatus> permissions =
  //       await PermissionHandler()
  //           .requestPermissions([PermissionGroup.microphone]);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "Voice Commands",
          style: textStyleBlackB.copyWith(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 2.h,
              ),
              RectangleBox.voiceCommandRectangleBox(
                  context: context,
                  text1: "Skip warm shower",
                  text2: "'Skip'",
                  color: HexColor('#D8EAFF')),
              RectangleBox.voiceCommandRectangleBox(
                  context: context,
                  text1: "Pause Timer",
                  text2: "'Stop'",
                  color: HexColor('#D8EAFF')),
              RectangleBox.voiceCommandRectangleBox(
                  context: context,
                  text1: "Resume Timer",
                  text2: "'Start'",
                  color: HexColor('#D8EAFF')),
              RectangleBox.voiceCommandRectangleBox(
                  context: context,
                  text1: "Restart Timer",
                  text2: "'Restart'",
                  color: HexColor('#D8EAFF')),
              SizedBox(
                height: 3.5.h,
              ),
              Text(
                'TooCool does NOT store any audio data.',
                style: textStyleBlackR.copyWith(
                    fontSize: 14, color: Colors.grey.shade700),
              ),
              Text(
                'We only listen for these specific command words',
                style: textStyleBlackR.copyWith(
                    fontSize: 14, color: Colors.grey.shade700),
              ),
              SizedBox(
                height: 3.5.h,
              ),
              Container(
                width: 90.w,
                decoration: BoxDecoration(
                    color: HexColor('#D8EAFF'),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          getPermission();
                        },
                        child: Icon(
                          Icons.info,
                          color: Colors.black,
                          size: 40,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        'In order to use this feature make sure you enable both speech recognition and microphone in settings',
                        style: textStyleBlackR.copyWith(
                            fontSize: 16.0, color: Colors.grey.shade700),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
