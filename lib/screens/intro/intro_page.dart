import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utilities/constants.dart';
import '../../utilities/widgets.dart';
import '../auth/signup_screen.dart';

class IntroPageScreen extends StatefulWidget {
  const IntroPageScreen({Key? key}) : super(key: key);

  @override
  State<IntroPageScreen> createState() => _IntroPageScreenState();
}

class _IntroPageScreenState extends State<IntroPageScreen> {
  List<String> banners = [
    Asset.intro1,
    Asset.intro2,
    Asset.intro3,
    Asset.intro4,
    Asset.intro5,
    Asset.intro6
  ];
  int yourActiveIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            CarouselSlider(
              items: [
                for (int i = 0; i < banners.length; i++)
                  Image.asset(
                    banners[i],
                    fit: BoxFit.fill,
                  ),
              ],
              options: CarouselOptions(
                onPageChanged: (index, reason) {
                  setState(() {
                    yourActiveIndex = index;
                  });
                },
                height: 65.h,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll:
                    banners.length == 0 || banners.length == 1 ? false : true,
                reverse: false,
                autoPlay:
                    banners.length == 0 || banners.length == 1 ? false : true,
                autoPlayInterval: const Duration(seconds: 7),
                autoPlayAnimationDuration: const Duration(milliseconds: 1500),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                //onPageChanged: callbackFunction,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: banners.asMap().entries.map((entry) {
                return Container(
                  width: 7.0,
                  height: 7.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey
                              : Colors.black)
                          .withOpacity(
                              yourActiveIndex == entry.key ? 0.9 : 0.4)),
                );
              }).toList(),
            ),
            SizedBox(
              height: 3.h,
            ),
            AppButton1(
              text: "Get Started",
              btnPressed: () {
                Get.to(() => const SignupScreen());
              },
            ),
            SizedBox(
              height: 3.h,
            ),
            HaveAccount.already(),
          ],
        ),
      ),
    );
  }
}
