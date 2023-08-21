import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:too_cool/screens/challenges/challenges_screen.dart';
import 'package:too_cool/screens/setting/setting_screen.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../utilities/constants.dart';
import '../badges/badges_screen.dart';
import '../home/home_screen.dart';
import '../leaders/leaders_page.dart';

class CommonNavigationBar extends StatefulWidget {
  const CommonNavigationBar({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<CommonNavigationBar> createState() => _CommonNavigationBarState();
}

class _CommonNavigationBarState extends State<CommonNavigationBar> {
  int index = 0;

  final List _pages=[
    const HomeScreen(
    ),
    const LeadersScreen(),
    const BadgesScreen(),
    const ChallengesScreen(
    ),
    const SettingScreen()
  ];

  void _onItemTapped(value){
    index=value;
    setState(() {

    });
  }

  @override
  void initState() {
    index = widget.index;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[index] ,
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: index,
        onTap: (value) => _onItemTapped(value),
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withOpacity(.60),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: (index == 0 || index == -1)
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(Asset.statsIconSelected,
                          height: 3.5.h),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(Asset.statsIcon,
                          height: 3.5.h),
                    ),
                  ),
                  (index == 0 || index == -1)
                      ? Text(
                    "Stats",
                    style: textStyleBlackR.copyWith(
                        fontSize: 10),
                  )
                      : Text(
                    "Stats",
                    style: textStyleBlackR.copyWith(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: (index == 1 || index == -2)
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(Asset.leadersIconSelected,
                          height: 3.5.h),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(Asset.leadersIcon,
                          height: 3.5.h),
                    ),
                  ),
                  (index == 1 || index == -2)
                      ? Text(
                    "Leaders",
                    style: textStyleBlackR.copyWith(
                        fontSize: 10),
                  )
                      : Text(
                    "Leaders",
                    style: textStyleBlackR.copyWith(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: (index == 2 || index == -3)
                        ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(Asset.badgesIconSelected,
                          height: 3.5.h),
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.asset(
                        Asset.badgesIcon,
                        height: 3.5.h,
                      ),
                    ),
                  ),
                  (index == 2 || index == -3)
                      ? Text(
                    "Badges",
                    style: textStyleBlackR.copyWith(
                        fontSize: 10),
                  )
                      : Text(
                    "Badges",
                    style: textStyleBlackR.copyWith(fontSize: 10),
                  )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: index == 3
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(Asset.challengesIconSelected,
                            height: 3.5.h),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(Asset.challengesIcon,
                            height: 2.5.h),
                      )),
                  index == 3
                      ? Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text(
                    "Challenges",
                    style: textStyleBlackR.copyWith(
                          fontSize: 10),
                  ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                    "Challenges",
                    style: textStyleBlackR.copyWith(fontSize: 10),
                  ),
                      )
                ],
              ),
              label: ''),
          BottomNavigationBarItem(
              icon: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: index == 4
                          ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(Asset.settingIconSelected,
                            height: 3.5.h),
                      )
                          : Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Image.asset(Asset.settingIcon,
                            height: 3.5.h),
                      )),
                  index == 4
                      ? Text(
                    "Setting",
                    style: textStyleBlackR.copyWith(
                        fontSize: 10),
                  )
                      : Text(
                    "Setting",
                    style: textStyleBlackR.copyWith(fontSize: 10),
                  )
                ],
              ),
              label: ''),
        ],
      ),
    );
  }
}
