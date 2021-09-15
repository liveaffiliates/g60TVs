
import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:animate_do/animate_do.dart';
import 'package:g60/widgets/Timer/countdown_timer.dart';


class TimerRow extends StatefulWidget {

  final int setsToGo;
  final Color timerContainerBackgroundColor;
  final TimerWidget timerWidget;

  TimerRow({required this.timerWidget, required this.timerContainerBackgroundColor, required this.setsToGo});

  @override
  _TimerRowState createState() => _TimerRowState();
}

class _TimerRowState extends State<TimerRow> {

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    double gapLargeWidth = 15;
    double gapSmallWidth = 5;

    double rowHeight = (height-(1*gapLargeWidth+2*gapSmallWidth))/4;
    double topColumnSize = (width-(2*gapLargeWidth))/3;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: topColumnSize,
            height:rowHeight,
            color: g60DarkBlue,
            child: Center(child:
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('WORK', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: 20,),
                Pulse(
                  duration: Duration(milliseconds: 1000),
                  delay: Duration(milliseconds: 1000),
                  infinite: true,
                  child: Icon(Icons.favorite, color: Colors.white, size: 50,),)
              ],
            )),
          ),
          Container(color: Colors.black, width: gapLargeWidth, height:rowHeight,),
          Container(
            width: topColumnSize,
            height:rowHeight,
            color: widget.timerContainerBackgroundColor,
            child: Container(
                height: rowHeight,
                width: rowHeight,
                child: Center(child: widget.timerWidget)),
          ),
          Container(color: Colors.black, width: gapLargeWidth, height:rowHeight,),
          Container(
            width: topColumnSize,
            height:rowHeight,
            color: g60DarkBlue,
            child: Center(child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SETS TO GO', textAlign:TextAlign.center, style: Theme.of(context).textTheme.headline3,),
                Text(widget.setsToGo.toString(), style: Theme.of(context).textTheme.headline2,),
              ],
            )),
          ),
        ],),
    );
  }
}



