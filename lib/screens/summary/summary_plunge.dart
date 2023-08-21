import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/timer/cold_plunge.dart';

import '../../controllers/home_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import '../navigation_bar/navigation_bar.dart';

class SummaryPlungeScreen extends StatefulWidget {
  const SummaryPlungeScreen({Key? key, required this.time}) : super(key: key);

  final int time;
  @override
  State<SummaryPlungeScreen> createState() => _SummaryPlungeScreenState();
}

class _SummaryPlungeScreenState extends State<SummaryPlungeScreen> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  String duration = '';
  final HomeController _homeController = Get.find<HomeController>();

  setShower() {
    Map<String, String> map = {};
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
      "title": "Cold Plunge",
      "type": "3",
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
    setShower();
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
          "Cold Plunge",
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
              Image.asset(
                Asset.clapIcon,
                scale: 4.0,
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
                "You just completed your Plunge today..",
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
                Get.to(() => ColdPlungeScreen(
                      continuePlunge: true,
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
            )
          ],
        ),
      ),
    );
  }
}
