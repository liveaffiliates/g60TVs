import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';


class ExerciseRow extends StatefulWidget {
  final String exerciseNumber;
  final double rowHeight;
  final double columnLeftWidth;
  final String gifLocation;

  ExerciseRow({required this.exerciseNumber, required this.rowHeight, required this.columnLeftWidth, required this.gifLocation});

  @override
  _ExerciseRowState createState() => _ExerciseRowState();
}

class _ExerciseRowState extends State<ExerciseRow>{

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.rowHeight,
      child: Row(children: [
        Container(
          color: g60DarkBlue,
          width: widget.columnLeftWidth,
          child: Center(child: Text(widget.exerciseNumber, style: Theme.of(context).textTheme.headline2,)),
        ),
        Expanded(child: Container(color: Colors.white, child:  Image.asset(widget.gifLocation)
          ,))
      ],),
    );
  }

}

