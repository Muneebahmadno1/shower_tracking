import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/controllers/home_controller.dart';

import '../../controllers/setting_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/widgets.dart';
import '../calendar/CalenderScreen.dart';
import '../session/add_session.dart';
import '../session/session_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SettingController _settingController = Get.find<SettingController>();
  final HomeController _homeController = Get.find<HomeController>();
  final AuthController _authController = Get.find<AuthController>();

  getData(BuildContext context) async {
    await _authController.getUserData(context);
    await _settingController.getTimerData({}, context);
    if (!mounted) {
      return;
    }
    await _homeController.getShowers({}, context);
    setState(() {});
    for (int i = 0; i < _settingController.timerData.length; i++) {
      if (_settingController.timerData[i].title == "Warm Shower Duration") {
        warmDuration = int.parse(
                    _settingController.timerData[i].duration.split(":")[0]) *
                60 +
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      } else if (_settingController.timerData[i].title ==
          "Cold Shower Duration") {
        coldDuration = int.parse(
                    _settingController.timerData[i].duration.split(":")[0]) *
                60 +
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      } else {
        plungeDuration = int.parse(
                    _settingController.timerData[i].duration.split(":")[0]) *
                60 +
            int.parse(_settingController.timerData[i].duration.split(":")[1]);
      }
    }
    print("Warm Duration");
    print(warmDuration);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 360,
                  child: CalendarColumn(),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MediaQuery.of(context).size.height <= 750
                        ? smallSizeWidget()
                        : bigSizeWidget())
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10.h,
            child: Column(
              children: [
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppButton1(
                          text: "Start Session",
                          btnPressed: () {
                            Get.to(() => const SessionSelectionScreen());
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const AddSessionScreen());
                        },
                        child: Container(
                            height: 55,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Image.asset(
                                Asset.addIcon,
                                scale: 4.5,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  smallSizeWidget() {
    print("in small");
    print(100.h);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < homepageIcons.length; i++)
            RectangleBox.homeRectangleBox(
                context: context,
                color: homepageColors[i],
                asset: homepageIcons[i],
                number: homepageNumbers[i],
                time: _authController.userData == null
                    ? "00:00:00"
                    : _authController.userData!.totalTime,
                totalTime: i == homepageIcons.length - 1 ? true : false,
                title: homepageTitles[i]),
        ],
      ),
    );
  }

  bigSizeWidget() {
    print("in big");
    print(100.h);
    return Column(
      children: [
        for (int i = 0; i < homepageIcons.length; i++)
          Expanded(
            child: RectangleBox.homeRectangleBox(
                context: context,
                color: homepageColors[i],
                asset: homepageIcons[i],
                number: homepageNumbers[i],
                time: _authController.userData == null
                    ? "00:00:00"
                    : _authController.userData!.totalTime,
                totalTime: i == homepageIcons.length - 1 ? true : false,
                title: homepageTitles[i]),
          ),
      ],
    );
  }
}
