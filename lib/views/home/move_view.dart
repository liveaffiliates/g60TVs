import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:g60/theme/g60_colors.dart';

class MoveView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        height: double.infinity,
        color: g60LightBlue,
        child: Center(child: Text('Move Station', style: Theme.of(context).textTheme.headline2,)),
      ),
    );
  }
}
