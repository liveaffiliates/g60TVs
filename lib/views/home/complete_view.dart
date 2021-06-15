import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';

class CompleteView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        color: g60LightBlue,
        child: Center(child: Text('Congratulations Workout Complete', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2,)),
      ),
    );
  }
}
