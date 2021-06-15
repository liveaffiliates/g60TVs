import 'package:flutter/material.dart';
import 'package:g60/views/home/exercise_row.dart';
import 'package:g60/views/home/timer_row.dart';
import 'package:g60/theme/g60_colors.dart';


class NormalView extends StatelessWidget {

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
        ExerciseRow(exerciseNumber: '1', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth, gifLocation: 'assets/1.gif',),
        Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
        ExerciseRow(exerciseNumber: '2', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth, gifLocation: 'assets/2.gif',),
        Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
        ExerciseRow(exerciseNumber: '3', rowHeight: rowHeight, columnLeftWidth: columnLeftWidth, gifLocation: 'assets/3.gif',),
      ],);
  }
}
