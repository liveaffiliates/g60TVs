import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:g60/theme/g60_colors.dart';

class StayView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        height: double.infinity,
        color: g60Red,
        child: Center(child: Text('Stay in station', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline2,)),
      ),
    );
  }
}
