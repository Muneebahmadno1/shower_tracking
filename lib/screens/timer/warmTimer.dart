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
import 'package:too_cool/controllers/setting_controller.dart';
import 'package:too_cool/screens/navigation_bar/navigation_bar.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/global_variables.dart';
import 'package:too_cool/utilities/widgets.dart';

import '../../utilities/styles.dart';
import 'cold_shower.dart';

class WarmTimerScreen extends StatefulWidget {
  const WarmTimerScreen({Key? key}) : super(key: key);

  @override
  State<WarmTimerScreen> createState() => _WarmTimerScreenState();
}

class _WarmTimerScreenState extends State<WarmTimerScreen> {
  bool volume = true;
  final _countDownController = CountDownController();
  final SettingController _settingController = Get.find<SettingController>();
  int initialDuration = 0;
  final Stopwatch _activeTimer = Stopwatch();
  final assetsAudioPlayer = AssetsAudioPlayer();
  var stopWatchTimer = StopWatchTimer();
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  // void _onSpeechResult(SpeechRecognitionResult result) {
  //   setState(() {
  //     String _lastWords = result.recognizedWords.toLowerCase();
  //   });
  //   print("_lastWords");
  //   print(_lastWords);
  //   if (_lastWords.contains('pause')) {
  //     // Pause your timer
  //     print("PAUSED IS CALLED");
  //     _countDownController.pause();
  //     stopWatchTimer.onStopTimer();
  //   } else if (_lastWords.contains('reset')) {
  //     // Reset your timer
  //     print("RESET IS CALLED");
  //     _countDownController.reset();
  //     stopWatchTimer.onResetTimer();
  //   } else if (_lastWords.contains('play') || _lastWords.contains('start')) {
  //     // Start or resume your timer
  //     print("PLAY IS CALLED");
  //     _countDownController.start();
  //     stopWatchTimer.onStartTimer();
  //   }
  // }

  // Future<void> startListening() async {
  //   print("before available");
  //   bool available = await _speech.initialize();
  //   print("available");
  //   if (available) {
  //     print("Started mic");
  //     _speech.listen(
  //       listenFor: const Duration(days: 1),
  //       listenMode: stt.ListenMode.dictation,
  //       partialResults: true,
  //       onResult: (SpeechRecognitionResult result) {
  //         String _lastWords = result.recognizedWords.toLowerCase();
  //         print("_lastWords");
  //         print(_lastWords);
  //         if (_lastWords.contains('pause')) {
  //           // Pause your timer
  //           print("PAUSED IS CALLED");
  //           _countDownController.pause();
  //           stopWatchTimer.onStopTimer();
  //         } else if (_lastWords.contains('reset')) {
  //           // Reset your timer
  //           print("RESET IS CALLED");
  //           _countDownController.reset();
  //           stopWatchTimer.onResetTimer();
  //         } else if (_lastWords.contains('play') || _lastWords.contains('start')) {
  //           // Start or resume your timer
  //           print("PLAY IS CALLED");
  //           _countDownController.start();
  //           stopWatchTimer.onStartTimer();
  //         }
  //       },
  //     );
  //   }
  // }

  checkTimeLeft(int timeLeft) {
    if (volume) {
      if (warmDuration == 62 ||
          warmDuration == 61 ||
          warmDuration == 60 ||
          warmDuration == 12 ||
          warmDuration == 11 ||
          warmDuration == 10) {
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

  fun() async {
    _initSpeech();
    Future.delayed(const Duration(seconds: 3), () {
      // _startListening();
    });
  }

  void _initSpeech() async {
    try {
      _speechEnabled = await _speechToText.initialize();
      setState(() {});
      // _startListening();
      print("initSpeech");
      print(_speechEnabled);
    } catch (e) {
      if (e is PlatformException) {
        String? errorMessage = e.message;
        errorDialog(context, "Error", errorMessage!);
        print(
            errorMessage); // This will print "Speech recognition not available on this device"
      } else {
        // Handle other types of exceptions if needed
      }
    }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _initSpeech();
    _startListening();
    // fun();
    if (volume) {
      assetsAudioPlayer.open(
        Audio("assets/voices/Starting-warm-shower.mp3"),
      );
    }
    stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(warmDuration),
      onChangeRawSecond: (p0) {
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
              colors: [HexColor('#FFF685'), HexColor('#FF8194')])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                // exitDialog(context, _countDownController);
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
            "Warm Shower",
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
                Center(
                  child: CircularCountDownTimer(
                    controller: _countDownController,
                    duration: warmDuration,
                    initialDuration: initialDuration,
                    isReverse: true,
                    fillColor: Colors.black,
                    height: 35.h,
                    width: 35.h,
                    strokeWidth: 25,
                    onComplete: () {
                      Get.to(() => const ColdShowerScreen(
                            continueShower: false,
                            previousTime: 0,
                          ));
                    },
                    onChange: (value) {
                      print("Value");
                      print(_countDownController.getTime());
                      if (_countDownController.getTime() == "10") {
                        print("Value");
                        print(value);
                        assetsAudioPlayer.open(
                          Audio("assets/voices/10-seconds-to-go.mp3"),
                        );
                      }
                    },
                    timeFormatterFunction:
                        (defaultFormatterFunction, duration) {
                      // other durations by it's default format
                      return Function.apply(formatTime, [duration]);
                    },
                    // textFormat: ,
                    strokeCap: StrokeCap.square,
                    isReverseAnimation: true,
                    ringColor: HexColor('#707070'),
                    autoStart: true,
                    textStyle: textStyleBlackB.copyWith(fontSize: 40),
                  ),
                ),
                SizedBox(
                  height: 7.h,
                ),
                Text(
                  "INSTRUCTIONS",
                  style: textStyleBlackB.copyWith(fontSize: 18),
                ),
                Text(
                  "Begin with a comfortably warm shower",
                  style: textStyleBlackR.copyWith(fontSize: 18),
                ),
                SizedBox(
                  height: 7.h,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
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
                            if (!_countDownController.isPaused) {
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
                            // if (_speechEnabled) {
                            //   _stopListening();
                            // } else {
                            //   _startListening();
                            // }
                            // _speechToText.isNotListening
                            //     ? _startListening()
                            //     : _stopListening();
                            // print("Hello");
                            // print(_countDownController.getTime());
                            // setState(() {
                            //   initialDuration = warmDuration -
                            //       10 -
                            //       int.parse(_countDownController
                            //           .getTime()
                            //           .toString());
                            // });
                            // print("Remaning time");
                            // print(initialDuration);
                            // _countDownController.restart();
                            // Get.to(() => const ColdShowerScreen(
                            //       continueShower: false,
                            //     ));
                          },
                          child: Image.asset(
                            Asset.forwardIcon,
                            scale: 5.0,
                          )),
                    ],
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
