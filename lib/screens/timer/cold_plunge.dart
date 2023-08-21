import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sizer/sizer.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:too_cool/controllers/home_controller.dart';
import 'package:too_cool/screens/summary/summary_plunge.dart';

import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/styles.dart';
import '../../utilities/widgets.dart';
import '../navigation_bar/navigation_bar.dart';

class ColdPlungeScreen extends StatefulWidget {
  const ColdPlungeScreen({
    Key? key,
    required this.continuePlunge,
    required this.previousTime,
  }) : super(key: key);

  final int previousTime;
  final bool continuePlunge;

  @override
  State<ColdPlungeScreen> createState() => _ColdPlungeScreenState();
}

class _ColdPlungeScreenState extends State<ColdPlungeScreen> {
  final HomeController _homeController = Get.find();
  bool volume = true;
  final _countDownController = CountDownController();
  final assetsAudioPlayer = AssetsAudioPlayer();
  var stopWatchTimer = StopWatchTimer();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  int newTime = 0;
  String duration = '';

  setShower() {
    Map<String, String> map = {};
    if ((int.parse(((widget.previousTime + plungeDuration - newTime / 60)
                    .floor()
                    .toString())))
                .toString()
                .length ==
            2 &&
        ((widget.previousTime + plungeDuration - newTime) % 60)
                .toString()
                .length ==
            2) {
      setState(() {
        duration =
            "${int.parse(((widget.previousTime + plungeDuration - newTime) / 60).floor().toString())}:${(widget.previousTime + plungeDuration - newTime) % 60}";
      });
    } else if ((int.parse(
                ((widget.previousTime + plungeDuration - newTime) / 60)
                    .floor()
                    .toString()))
            .toString()
            .length ==
        2) {
      setState(() {
        duration =
            "${int.parse(((widget.previousTime + plungeDuration - newTime) / 60).floor().toString())}:0${(widget.previousTime + plungeDuration - newTime) % 60}";
      });
    } else if (((widget.previousTime + plungeDuration - newTime) % 60)
            .toString()
            .length ==
        2) {
      setState(() {
        duration =
            "0${int.parse(((widget.previousTime + plungeDuration - newTime) / 60).floor().toString())}:${(widget.previousTime + plungeDuration - newTime) % 60}";
      });
    } else {
      setState(() {
        duration =
            "0${int.parse(((widget.previousTime + plungeDuration - newTime) / 60).floor().toString())}:0${(widget.previousTime + plungeDuration - newTime) % 60}";
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

  checkTimeLeft(int timeLeft) {
    if (volume && !widget.continuePlunge) {
      if (plungeDuration == 62 ||
          plungeDuration == 61 ||
          plungeDuration == 60 ||
          plungeDuration == 12 ||
          plungeDuration == 11 ||
          plungeDuration == 10) {
        if (timeLeft == 10) {
          Future.delayed(const Duration(seconds: 2), () {
            assetsAudioPlayer.open(
              Audio("assets/voices/10-seconds-to-go.mp3"),
            );
          });
        } else if (timeLeft == 60) {
          Future.delayed(const Duration(seconds: 2), () {
            assetsAudioPlayer.open(
              Audio("assets/voices/60-seconds-to-go.mp3"),
            );
          });
        }
      } else {
        if (timeLeft == 10) {
          assetsAudioPlayer.open(
            Audio("assets/voices/10-seconds-to-go.mp3"),
          );
        } else if (timeLeft == 60) {
          assetsAudioPlayer.open(
            Audio("assets/voices/60-seconds-to-go.mp3"),
          );
        }
      }
    }
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
    // _startListening();

    print(_speechEnabled);
  }

  void _startListening() async {
    if (!_speechEnabled) {
      print("idhar a raha ha");
      bool available = await _speechToText.initialize();
      print('_startListening');
      setState(() {});
      print("idhar bhi raha ha");
      if (available) {
        setState(() {
          _speechEnabled = true;
        });
        print("idhar bhi a gaya");
        Future.delayed(const Duration(seconds: 2), () async {
          await _speechToText.listen(
            onResult: _onSpeechResult,
            onDevice: false,
          );
        });
        print("jhola lal");
      }
    }
  }

  void _stopListening() async {
    if (_speechEnabled) {
      await _speechToText.stop();
      setState(() {
        _speechEnabled = false;
      });
    }
  }

  String getLastWord(String input) {
    List<String> words = input.split(' ');
    if (words.isNotEmpty) {
      return words.last;
    } else {
      return ''; // Handle case where input is empty
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    print("result");
    print(result);
    setState(() {
      _lastWords = getLastWord(result.recognizedWords.toLowerCase());
      print("_lastWords");
      print(_lastWords);
      if (_lastWords.contains('pause') || _lastWords.contains('stop')) {
        // Pause your timer
        _countDownController.pause();
        stopWatchTimer.onStopTimer();
      } else if (_lastWords.contains('reset')) {
        // Reset your timer
        _countDownController.restart();
        stopWatchTimer.onResetTimer();
      } else if (_lastWords.contains('play') || _lastWords.contains('start')) {
        // Start or resume your timer
        _countDownController.resume();
        stopWatchTimer.onStartTimer();
      }
    });
  }

  // Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initSpeech();
    _startListening();
    if (!widget.continuePlunge) {
      if (volume) {
        assetsAudioPlayer.open(
          Audio("assets/voices/Starting-cold-plunge.mp3"),
        );
      }
    }
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(plungeDuration),
      onChangeRawSecond: (p0) {
        setState(() {
          newTime = p0;
        });
        print("widget.previousTime");
        print(widget.previousTime);
        print("newTime");
        print(newTime);
        checkTimeLeft(p0);
      },
    );
    stopWatchTimer.onStartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [HexColor('#FFFFFF'), HexColor('#83BCFF')])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () async {
                // exitDialog(context, _countDownController);
                if (widget.continuePlunge) {
                  await setShower();
                }
                _stopListening();
                setState(() {
                  stopWatchTimer.onStopTimer();
                  _countDownController.pause();
                });
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    volume = false;
                  });
                },
                child: volume
                    ? const Icon(
                        Icons.volume_up,
                        color: Colors.black,
                      )
                    : const Icon(
                        Icons.volume_off,
                        color: Colors.black,
                      ),
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: CircularCountDownTimer(
                        controller: _countDownController,
                        duration: plungeDuration,
                        isReverse: !widget.continuePlunge,
                        fillColor: Colors.black,
                        height: 35.h,
                        width: 35.h,
                        strokeWidth: 25,
                        onComplete: () {
                          assetsAudioPlayer.open(
                            Audio(
                                "assets/voices/cold-plunge-completed-great-work.mp3"),
                          );
                          Get.to(() => SummaryPlungeScreen(
                                time: widget.previousTime + plungeDuration,
                              ));
                        },
                        timeFormatterFunction:
                            (defaultFormatterFunction, duration) {
                          // other durations by it's default format
                          return Function.apply(formatTime, [duration]);
                        },
                        strokeCap: StrokeCap.square,
                        isReverseAnimation: !widget.continuePlunge,
                        ringColor: HexColor('#707070'),
                        autoStart: true,
                        textStyle: widget.continuePlunge
                            ? textStyleBlackB.copyWith(fontSize: 0)
                            : textStyleBlackB.copyWith(fontSize: 40),
                      ),
                    ),
                    widget.continuePlunge
                        ? Text(
                            "${double.parse(((widget.previousTime + plungeDuration - newTime) / 60).toString()).floor()}:${widget.previousTime + (plungeDuration - newTime) % 60}",
                            style: const TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  "INSTRUCTIONS",
                  style: textStyleBlackB.copyWith(fontSize: 18),
                ),
                Text(
                  "Breath deeply and remember to relax",
                  style: textStyleBlackR.copyWith(fontSize: 18),
                ),
                widget.continuePlunge
                    ? SizedBox(
                        height: 20.h,
                      )
                    : SizedBox(
                        height: 7.h,
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                child: widget.continuePlunge
                    ? AppButton1(
                        text: "Stop",
                        btnPressed: () async {
                          stopWatchTimer.onStopTimer();
                          _countDownController.pause();
                          Get.to(() => SummaryPlungeScreen(
                                time: widget.previousTime +
                                    (plungeDuration - newTime),
                              ));
                        },
                      )
                    : Container(
                        width: 90.w,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    stopWatchTimer.onResetTimer();
                                    _countDownController.restart();
                                  },
                                  child: Image.asset(
                                    Asset.resetIcon,
                                    scale: 5.0,
                                  )),
                              GestureDetector(
                                  onTap: () {
                                    if (_countDownController.isPaused) {
                                      stopWatchTimer.onStopTimer();
                                      _countDownController.pause();
                                    } else {
                                      stopWatchTimer.onStartTimer();
                                      _countDownController.resume();
                                    }
                                    setState(() {});
                                  },
                                  child: _countDownController.isPaused
                                      ? Image.asset(
                                          Asset.playIcon,
                                          scale: 5.0,
                                        )
                                      : const Icon(
                                          Icons.pause,
                                          color: Colors.white,
                                          size: 45,
                                        )),
                              GestureDetector(
                                onTap: () {
                                  // _speechToText.isNotListening
                                  //     ? _startListening()
                                  //     : _stopListening();
                                },
                                child: Image.asset(
                                  Asset.forwardIcon,
                                  scale: 5.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
