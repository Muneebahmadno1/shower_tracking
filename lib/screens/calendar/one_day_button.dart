import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:too_cool/utilities/styles.dart';

import '../../controllers/home_controller.dart';
import '../../utilities/constants.dart';
import '../../utilities/global_variables.dart';
import '../../utilities/helpers.dart';
import '../session/day_session.dart';
import 'habit.dart';
import 'habits_manager.dart';
import 'in_button.dart';

class OneDayButton extends StatelessWidget {
  OneDayButton(
      {Key? key,
      required date,
      this.color,
      this.child,
      required this.id,
      required this.parent,
      required this.callback,
      required this.event})
      : date = transformDate(date),
        super(key: key);

  final int id;
  final DateTime date;
  final Color? color;
  final Widget? child;
  final HabitState parent;
  final void Function() callback;
  final List? event;
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<InButton> icons = [
      InButton(
        key: const Key('Date'),
        text: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 17,
                child: child ??
                    Text(
                      date.day.toString(),
                      style: textStyleBlackR.copyWith(
                          fontSize: 10,
                          color: (date.weekday > 5) ? Colors.black : null),
                    ),
              ),
              date.day == DateTime.now().day &&
                      date.month == DateTime.now().month
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 1.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Container(
                            height: 10,
                            width: 10,
                            alignment: Alignment.topLeft,
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 1.5),
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
      const InButton(
        key: Key('Check'),
        icon: Icon(
          Icons.check,
          color: Colors.green,
          semanticLabel: 'Check',
        ),
      ),
      const InButton(
        key: Key('Fail'),
        icon: Icon(
          Icons.close,
          color: Colors.red,
          semanticLabel: 'Fail',
        ),
      ),
      const InButton(
        key: Key('Skip'),
        icon: Icon(
          Icons.last_page,
          color: Colors.yellow,
          semanticLabel: 'Skip',
        ),
      ),
      const InButton(
        key: Key('Comment'),
        icon: Icon(
          Icons.chat_bubble_outline,
          semanticLabel: 'Comment',
          color: HaboColors.orange,
        ),
      )
    ];

    int index = 0;
    String comment = "";

    if (event != null) {
      if (event![0] != 0) {
        index = (event![0].index);
      }

      if (event!.length > 1 && event![1] != null && event![1] != "") {
        comment = (event![1]);
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(2.0),
          child: Material(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 2,
            shadowColor: Theme.of(context).shadowColor,
            child: GestureDetector(
              onTap: () {
                if (homeController.isEventDay(date)) {
                  Get.to(() => DaySessionScreen(
                        date: date,
                      ));
                }
              },
              child: InButton(
                key: const Key('Date'),
                text: Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 17,
                        child: child ??
                            Text(
                              date.day.toString(),
                              style: textStyleBlackR.copyWith(
                                  fontSize: 10,
                                  color:
                                      (date.weekday > 5) ? Colors.black : null),
                            ),
                      ),
                      date.day == DateTime.now().day &&
                              date.month == DateTime.now().month
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 1.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: Container(
                                    height: 10,
                                    width: 10,
                                    alignment: Alignment.topLeft,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 1.5),
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: DropdownButton<InButton>(
              //     iconSize: 0,
              //     elevation: 3,
              //     alignment: Alignment.center,
              //     dropdownColor: Theme.of(context).colorScheme.primaryContainer,
              //     underline: Container(),
              //     items: icons.map(
              //       (InButton value) {
              //         return DropdownMenuItem<InButton>(
              //           key: value.key,
              //           value: value,
              //           child: Center(child: value),
              //         );
              //       },
              //     ).toList(),
              //     value: icons[index],
              //     onTap: () {
              //       parent.setSelectedDay(date);
              //       Get.to(() => DaySessionScreen(
              //             date: date,
              //           ));
              //     },
              //     onChanged: (value) {
              //       // if (value != null) {
              //       //   if (value.key == const Key('Check') ||
              //       //       value.key == const Key('Fail') ||
              //       //       value.key == const Key('Skip')) {
              //       //     print("Add Event 1");
              //       //     Provider.of<HabitsManager>(context, listen: false)
              //       //         .addEvent(id, date, [
              //       //       DayType.values[icons
              //       //           .indexWhere((element) => element.key == value.key)],
              //       //       comment
              //       //     ]);
              //       //     parent.events[date] = [
              //       //       DayType.values[icons
              //       //           .indexWhere((element) => element.key == value.key)],
              //       //       comment
              //       //     ];
              //       //     print("parent.events.length");
              //       //     print(parent.events.length);
              //       //     if (value.key == const Key('Check')) {
              //       //       parent.showRewardNotification(date);
              //       //     } else {
              //       //       if (value.key == const Key('Fail')) {
              //       //         parent.showSanctionNotification(date);
              //       //       }
              //       //     }
              //       //   } else if (value.key == const Key('Comment')) {
              //       //     showCommentDialog(context, index, comment);
              //       //   } else {
              //       //     if (comment != "") {
              //       //       print("Add Event 2");
              //       //       Provider.of<HabitsManager>(context, listen: false)
              //       //           .addEvent(id, date, [DayType.clear, comment]);
              //       //       parent.events[date] = [DayType.clear, comment];
              //       //     } else {
              //       //       Provider.of<HabitsManager>(context, listen: false)
              //       //           .deleteEvent(id, date);
              //       //       parent.events.remove(date);
              //       //     }
              //       //   }
              //       //   callback();
              //       // }
              //     },
              //   ),
              // ),
            ),
          ),
        ),
      ),
    );
  }

  showCommentDialog(BuildContext context, int index, String comment) {
    TextEditingController commentController =
        TextEditingController(text: comment);
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          child: Column(
            children: [
              const Text("Comment"),
              TextField(
                controller: commentController,
                autofocus: true,
                maxLines: 5,
                showCursor: true,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(11),
                  border: InputBorder.none,
                  hintText: "Your comment here",
                ),
              ),
            ],
          ),
        ),
      ),
      btnOkText: "Save",
      btnCancelText: "Close",
      btnCancelColor: Colors.grey,
      btnOkColor: HaboColors.primary,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        print("Add Event 3");
        Provider.of<HabitsManager>(context, listen: false).addEvent(
            id, date, [DayType.values[index], commentController.text]);
        parent.events[date] = [DayType.values[index], commentController.text];
        callback();
      },
    ).show();
  }
}
