import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:animate_do/animate_do.dart';

class TimerRow extends StatefulWidget {

  final int timerLength;
  final CountDownController controller;

  TimerRow({required this.timerLength, required this.controller});

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

    Color? grey = Colors.grey;
    Color? purple = Colors.purple;

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
                Text('WORK', style: Theme.of(context).textTheme.headline3,),
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
            color: g60Green,
            child: Center(child:
            CircularCountDownTimer(
              duration: widget.timerLength,
              initialDuration: 0,

              // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
              controller: widget.controller,
              width: 100,
              height: 100,

              // Ring Color for Countdown Widget.
              ringColor: g60LightBlue,

              // Filling Color for Countdown Widget.
              fillColor: Colors.white,

              // Background Color for Countdown Widget.
              backgroundColor: Colors.white.withAlpha(0),

              // Background Gradient for Countdown Widget.
              backgroundGradient: null,

              // Border Thickness of the Countdown Ring.
              strokeWidth: 10,

              // Begin and end contours with a flat edge and no extension.
              strokeCap: StrokeCap.square,

              // Text Style for Countdown Text.
              textStyle: Theme.of(context).textTheme.headline3,

              // Format for the Countdown Text.
              textFormat: CountdownTextFormat.S,

              // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
              isReverse: true,

              // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
              isReverseAnimation: true,

              // Handles visibility of the Countdown Text.
              isTimerTextShown: true,

              // Handles the timer start.
              autoStart: true,

              // This Callback will execute when the Countdown Starts.
              onStart: () {
                // Here, do whatever you want
                print('Countdown Started');
              },

              // This Callback will execute when the Countdown Ends.
              onComplete: () {
                // Here, do whatever you want
                print('Countdown Ended');
              },
            ),
            ),
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
                Text('SETS TO GO', style: Theme.of(context).textTheme.headline3,),
                SizedBox(height: 20,),
                Text('3', style: Theme.of(context).textTheme.headline2,),
              ],
            )),

          ),
        ],),
    );
  }
}



