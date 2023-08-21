import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../utilities/global_variables.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (
          BuildContext ctx,
          int index,
        ) {
          int start = StartingDayOfWeek.monday.index;
          int day = (start + index) % 7;
          TextStyle tex = const TextStyle(fontSize: 15, color: Colors.grey);
          if (weekStartList[day] == "Sa" || weekStartList[day] == "Su") {
            tex = const TextStyle(fontSize: 15, color: Colors.grey);
          }
          return SizedBox(
            width: (MediaQuery.of(context).size.width - 32 - 27) * 0.141,
            child: Center(
              child: Text(weekStartList[day], style: tex),
            ),
          );
        },
      ),
    );
  }
}
