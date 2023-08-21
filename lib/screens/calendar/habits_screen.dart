import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:too_cool/screens/calendar/CalenderScreen.dart';
import 'package:too_cool/screens/calendar/habits_manager.dart';

import '../../utilities/constants.dart';

class HabitsScreen extends StatefulWidget {
  static MaterialPage page() {
    return const MaterialPage(
      child: HabitsScreen(),
    );
  }

  const HabitsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HabitsScreen> createState() => _HabitsScreenState();
}

class _HabitsScreenState extends State<HabitsScreen> {
  @override
  void initState() {
    print("HabitScreen");
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      showNotificationDialog(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text(
        //   "Habo",
        //   style: TextStyle(fontWeight: FontWeight.w700),
        // ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        // actions: <Widget>[
        //   IconButton(
        //     icon: const Icon(
        //       Icons.bar_chart,
        //       semanticLabel: 'Statistics',
        //     ),
        //     color: Colors.grey[400],
        //     tooltip: 'Statistics',
        //     onPressed: () {
        //       Provider.of<HabitsManager>(context, listen: false)
        //           .hideSnackBar();
        //     },
        //   ),
        //   IconButton(
        //     icon: const Icon(
        //       Icons.settings,
        //       semanticLabel: 'Settings',
        //     ),
        //     color: Colors.grey[400],
        //     tooltip: 'Settings',
        //     onPressed: () {
        //       Provider.of<HabitsManager>(context, listen: false)
        //           .hideSnackBar();
        //     },
        //   ),
        // ],
      ),
      body: const CalendarColumn(), //CalendarColumn(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Provider.of<HabitsManager>(context, listen: false).hideSnackBar();
      //   },
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //     semanticLabel: 'Add',
      //     size: 35.0,
      //   ),
      // ),
    );
  }

  void showNotificationDialog(BuildContext context) {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        showRestoreDialog(context);
      } else {
        resetNotifications();
      }
    });
  }

  void showRestoreDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: "Notifications",
      desc: "Habo needs permission to send notifications to work properly.",
      btnOkText: "Allow",
      btnCancelText: "Cancel",
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        AwesomeNotifications()
            .requestPermissionToSendNotifications()
            .then((value) {
          resetNotifications();
        });
      },
    ).show();
  }

  void resetNotifications() {
    Provider.of<HabitsManager>(context, listen: false)
        .resetHabitsNotifications();
  }
}
