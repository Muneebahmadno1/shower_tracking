import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/controllers/home_controller.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/widgets.dart';

import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../navigation_bar/navigation_bar.dart';
import '../timer/cold_shower.dart';

class SummaryShowerScreen extends StatefulWidget {
  const SummaryShowerScreen({Key? key, required this.time}) : super(key: key);
  final int time;

  @override
  State<SummaryShowerScreen> createState() => _SummaryShowerScreenState();
}

class _SummaryShowerScreenState extends State<SummaryShowerScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final HomeController _homeController = Get.find<HomeController>();
  String duration = '';

  setShower() {
    if (int.parse((warmDuration / 60).floor().toString()).toString().length ==
            2 &&
        (warmDuration % 60).toString().length == 2) {
      setState(() {
        duration =
            "${int.parse((warmDuration / 60).floor().toString())}:${warmDuration % 60}";
      });
    } else if (int.parse((warmDuration / 60).floor().toString())
            .toString()
            .length ==
        2) {
      setState(() {
        duration =
            "${int.parse((warmDuration / 60).floor().toString())}:0${warmDuration % 60}";
      });
    } else if ((warmDuration % 60).toString().length == 2) {
      setState(() {
        duration =
            "0${int.parse((warmDuration / 60).floor().toString())}:${warmDuration % 60}";
      });
    } else {
      setState(() {
        duration =
            "0${int.parse((warmDuration / 60).floor().toString())}:0${warmDuration % 60}";
      });
    }
    Map<String, String> map = {
      "title": "Warm Shower",
      "type": "2",
      "duration": duration,
      "fk_timer_id": "1",
    };
    _homeController.takeShowers(map, context);
    if ((int.parse(((widget.time / 60).floor().toString())))
                .toString()
                .length ==
            2 &&
        (widget.time % 60).toString().length == 2) {
      setState(() {
        duration =
            "${int.parse((widget.time / 60).floor().toString())}:${widget.time % 60}";
      });
    } else if ((int.parse((widget.time / 60).floor().toString()))
            .toString()
            .length ==
        2) {
      setState(() {
        duration =
            "${int.parse((widget.time / 60).floor().toString())}:0${widget.time % 60}";
      });
    } else if ((widget.time % 60).toString().length == 2) {
      setState(() {
        duration =
            "0${int.parse((widget.time / 60).floor().toString())}:${widget.time % 60}";
      });
    } else {
      setState(() {
        duration =
            "0${int.parse((widget.time / 60).floor().toString())}:0${widget.time % 60}";
      });
    }
    map = {
      "title": "Cold Shower",
      "type": "1",
      "duration": duration,
      "fk_timer_id": "1",
    };
    _homeController.takeShowers(map, context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      print('hello world');
      assetsAudioPlayer.open(
        Audio("assets/voices/do-you-want-to-keep-going.mp3"),
      );
    });
    // setShower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
            onTap: () async {
              await setShower();
              Get.offAll(() => const CommonNavigationBar(index: 0));
            },
            child: const Icon(
              Icons.close,
              color: Colors.black,
            )),
        title: Text(
          "Cold Shower",
          style: textStyleBlackB.copyWith(fontSize: 22),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.volume_up,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Image.asset(
                  Asset.clapIcon,
                  scale: 4.0,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "Congratulations!",
                style: textStyleBlackB.copyWith(fontSize: 19),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                "You just completed your Shower today.",
                style: textStyleBlackM,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 220,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  badgeDialog(context, "Super Streak", badgesList[0],
                      "You’ve completed a 100 day cold shower streak!", true);
                },
                child: Text(
                  "Feel like pushing your limits?",
                  style: textStyleBlackB.copyWith(fontSize: 18),
                )),
            const SizedBox(
              height: 40,
            ),
            AppButton1(
              text: "I want to keep going",
              btnPressed: () {
                Get.to(() => ColdShowerScreen(
                      continueShower: true,
                      previousTime: widget.time,
                    ));
              },
            ),
            const SizedBox(
              height: 12,
            ),
            GestureDetector(
              onTap: () async {
                await setShower();
                Get.offAll(() => const CommonNavigationBar(index: 0));
              },
              child: Container(
                height: 50,
                width: 90.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black,
                    )),
                alignment: Alignment.center,
                child: Text(
                  "Close",
                  style: textStyleBlackB.copyWith(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
