import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:after_layout/after_layout.dart';
import 'package:video_player/video_player.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AfterLayoutMixin<HomeView>{

  CountDownController _controller = CountDownController();
  int _duration = 60;



  @override
  void afterFirstLayout(BuildContext context) {
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {



    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    double gapLargeWidth = 15;
    double gapSmallWidth = 5;

    double rowHeight = (height-(1*gapLargeWidth+2*gapSmallWidth))/4;

    double columnLeft = width/4;
    double columnRight = width/3*2;

    double topColumnSize = (width-(2*gapLargeWidth))/3;

    double timerStrokeSize = 15;
    double timerDiameter = topColumnSize - timerStrokeSize - 40;


    return Scaffold(
      body: Container(
        height: height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Container(
                  width: topColumnSize,
                  height:rowHeight,
                  color: g60LightBlue,
                  child: Center(child:
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WORK', style: Theme.of(context).textTheme.headline3,),
                      SizedBox(height: 20,),
                      Icon(Icons.favorite, color: Colors.white, size: 75,),
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
                    duration: _duration,
                    initialDuration: 0,

                    // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
                    controller: _controller,
                    width: timerDiameter,
                    height: timerDiameter,

                    // Ring Color for Countdown Widget.
                    ringColor: g60LightBlue,

                    // Filling Color for Countdown Widget.
                    fillColor: Colors.white,

                    // Background Color for Countdown Widget.
                    backgroundColor: Colors.white.withAlpha(0),

                    // Background Gradient for Countdown Widget.
                    backgroundGradient: null,

                    // Border Thickness of the Countdown Ring.
                    strokeWidth: timerStrokeSize,

                    // Begin and end contours with a flat edge and no extension.
                    strokeCap: StrokeCap.square,

                    // Text Style for Countdown Text.
                    textStyle: Theme.of(context).textTheme.headline1,

                    // Format for the Countdown Text.
                    textFormat: CountdownTextFormat.S,

                    // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
                    isReverse: true,

                    // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
                    isReverseAnimation: true,

                    // Handles visibility of the Countdown Text.
                    isTimerTextShown: true,

                    // Handles the timer start.
                    autoStart: false,

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
                  color: g60LightBlue,
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
            ),
            Container(color: Colors.black, height: gapLargeWidth, width: double.infinity,),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(
                height: rowHeight,
                child: Row(children: [
                  Container(
                    color: g60DarkBlue,
                    width: columnLeft,
                    child: Center(child: Text('1', style: Theme.of(context).textTheme.headline2,)),
                  ),
                  Expanded(child: Container(color: Colors.white,))
                ],),
              ),
              Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
              Container(
                height: rowHeight,
                child: Row(children: [
                  Container(
                    color: g60DarkBlue,
                    width: columnLeft,
                    child: Center(child: Text('2', style: Theme.of(context).textTheme.headline2,)),
                  ),
                  Expanded(child:
                    Container(
                      color: Colors.white,

                  ))
                ],),
              ),
              Container(color: Colors.black, height: gapSmallWidth, width: double.infinity),
              Container(
                height: rowHeight,
                child: Row(children: [
                  Container(
                    color: g60DarkBlue,
                    width: columnLeft,
                    child: Center(child: Text('3', style: Theme.of(context).textTheme.headline2,)),

                  ),
                  Expanded(child: Container(color: Colors.white,))
                ],),
              ),
            ],),
          ],
        ),
      ),
    );
  }
}
