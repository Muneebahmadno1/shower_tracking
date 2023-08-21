import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utilities/styles.dart';

class OneDay extends StatelessWidget {
  const OneDay({
    Key? key,
    required this.date,
    required this.color,
    this.child,
  }) : super(key: key);

  final DateTime date;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(2.0),
          child: Material(
            color: HexColor('#FFFFFF'),
            borderRadius: BorderRadius.circular(10.0),
            elevation: 2,
            shadowColor: Theme.of(context).shadowColor,
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 5, top: 5),
              child: child ??
                  Center(
                    child: date.day == DateTime.now().day
                        ? Row(
                            children: [
                              Text(date.day.toString(),
                                  style: textStyleBlackR.copyWith(
                                      fontSize: 11,
                                      color: (date.weekday > 5)
                                          ? Colors.red[300]
                                          : null)),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              )
                            ],
                          )
                        : Text(date.day.toString(),
                            style: textStyleBlackR.copyWith(
                                fontSize: 11,
                                color: (date.weekday > 5)
                                    ? Colors.red[300]
                                    : null)),
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
