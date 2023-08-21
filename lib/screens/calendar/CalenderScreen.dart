import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'habit.dart';
import 'habits_manager.dart';

class CalendarColumn extends StatelessWidget {
  const CalendarColumn({super.key});

  @override
  Widget build(BuildContext context) {
    List<Habit> calendars = Provider.of<HabitsManager>(context).getAllHabits;

    return Column(
      children: <Widget>[
        // const Padding(
        //   padding: EdgeInsets.fromLTRB(18, 10, 18, 10),
        //   child: CalendarHeader(),
        // ),
        Expanded(
          child: (calendars.isNotEmpty)
              ? ReorderableListView(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 120),
                  children: calendars
                      .map(
                        (index) => Container(
                          key: ObjectKey(index),
                          child: index,
                        ),
                      )
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    Provider.of<HabitsManager>(context, listen: false)
                        .reorderList(oldIndex, newIndex);
                  },
                )
              : const Text("Empty List"),
        ),
      ],
    );
  }
}
