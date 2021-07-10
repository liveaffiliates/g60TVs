import 'package:flutter/material.dart';
import 'package:g60/views/home/exercise_row.dart';
import 'package:g60/views/home/timer_row.dart';
import 'package:g60/theme/g60_colors.dart';


class NormalView extends StatelessWidget {

  final int screenNumber;

  NormalView(this.screenNumber);

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    double gapLargeWidth = 15;
    double gapSmallWidth = 5;
    double rowHeight = (height-(1*gapLargeWidth+2*gapSmallWidth))/4;
    double columnLeftWidth = width/4;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExerciseRow(exerciseNumber: (screenNumber == 1) ? '1' : '4', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth,
          gifLocation: (screenNumber == 1) ?'assets/1.gif' : 'assets/3.gif',),
        Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
        ExerciseRow(exerciseNumber: (screenNumber == 1) ? '2' : '5', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth,
          gifLocation: (screenNumber == 1) ? 'assets/2.gif' : 'assets/2.gif',),
        Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
        ExerciseRow(exerciseNumber: (screenNumber == 1) ? '3' : '6', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth,
          gifLocation: (screenNumber == 1) ?'assets/3.gif' : 'assets/1.gif')
      ],);
  }
}
