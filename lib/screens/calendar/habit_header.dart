import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utilities/constants.dart';
import 'habit.dart';
import 'habits_manager.dart';

class HabitHeader extends StatelessWidget {
  const HabitHeader({
    Key? key,
    required this.widget,
    required bool streakVisible,
    required bool orangeStreak,
    required int streak,
  })  : _streakVisible = streakVisible,
        _orangeStreak = orangeStreak,
        _streak = streak,
        super(key: key);

  final Habit widget;
  final bool _streakVisible;
  final bool _orangeStreak;
  final int _streak;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(3, 0, 0, 0),
            child: Text(
              Provider.of<HabitsManager>(context)
                  .getNameOfHabit(widget.habitData.id!),
              style: const TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
          child: Visibility(
            visible: _streakVisible,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: (_orangeStreak)
                        ? HaboColors.orange
                        : HaboColors.primary,
                  ),
                  color:
                      (_orangeStreak) ? HaboColors.orange : HaboColors.primary,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 4,
                        offset: Offset.fromDirection(1, 3),
                        color: const Color(0x21000000))
                  ]),
              alignment: Alignment.center,
              child: Text(
                "$_streak",
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
