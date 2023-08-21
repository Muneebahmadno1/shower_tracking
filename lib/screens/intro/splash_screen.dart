import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:too_cool/controllers/auth_controller.dart';
import 'package:too_cool/utilities/constants.dart';
import 'package:too_cool/utilities/styles.dart';

import '../navigation_bar/navigation_bar.dart';
import 'intro_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthController _authController = Get.find<AuthController>();
  getState() async {
    String fcmToken = (await FirebaseMessaging.instance.getToken())!;
    print("fcmToken");
    print(fcmToken);
    if (await getUserLoggedIn()) {
      _authController.token.value = await getUserDataToken();
      await _authController.getUserData(context);
      // _authController.getUserData(context);
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const CommonNavigationBar(index: 0));
        // Get.offAll(() => const CommonNavigationBar(index: 0));
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.offAll(() => const IntroPageScreen());
        // Get.offAll(() => const CommonNavigationBar(index: 0));
      });
    }
  }

  @override
  void initState() {
    getState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 180,
                child: Lottie.asset('assets/icons/too_cool_logo.json',
                    repeat: false, fit: BoxFit.fill)),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Cold exposure just got fun!",
              style: textStyleBlackR.copyWith(fontSize: 24),
            )
          ],
        ),
      ),
    );
  }

  incrementCounter() {}
}
