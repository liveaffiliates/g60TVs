import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';

class ExerciseRow extends StatelessWidget {

  final String exerciseNumber;
  final double rowHeight;
  final double columnLeftWidth;

  ExerciseRow({required this.exerciseNumber, required this.rowHeight, required this.columnLeftWidth});

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: rowHeight,
      child: Row(children: [
        Container(
          color: g60DarkBlue,
          width: columnLeftWidth,
          child: Center(child: Text(exerciseNumber, style: Theme.of(context).textTheme.headline2,)),
        ),
        Expanded(child: Container(color: Colors.white,))
      ],),
    );
  }
}
