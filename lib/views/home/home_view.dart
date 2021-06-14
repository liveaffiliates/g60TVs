import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g60/models/workout_set.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:after_layout/after_layout.dart';
import 'package:g60/views/home/hydrate_view.dart';
import 'package:g60/views/home/move_view.dart';
import 'package:g60/views/home/normal_view.dart';
import 'package:g60/views/home/timer_row.dart';
import 'package:video_player/video_player.dart';
import 'package:g60/services/ntp.dart';
import 'dart:async';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AfterLayoutMixin<HomeView>{

  CountDownController controller = CountDownController();

  int numberOfSecondPast = 0;
  int setsToGo = 3;
  int timersComplete = 0;
  List <int> pod1Timers = [15,15,15];
  List <int> pod2Timers = [15,15,15];
  List <int> pod3Timers = [15,15,15];
  //Color timerColor = g60Green;
  //Color timerFontColor = Colors.black;
  bool workoutComplete = false;
  //int hydrationBreakTimer = 30;

  int setTime = 5;
  int moveTime = 5;
  int hydrationTime = 5;
  String setType = 'Normal';


  List<WorkoutSet> timers = [
    WorkoutSet(10, 'Normal'),
    WorkoutSet(10, 'Move'),
    WorkoutSet(10, 'Normal'),
    WorkoutSet(10, 'Move'),
    WorkoutSet(20, 'Normal'),
    WorkoutSet(10, 'Move'),
    WorkoutSet(20, 'Normal'),
    WorkoutSet(20, 'Hydrate'),
    WorkoutSet(10, 'Normal'),
    WorkoutSet(20, 'Hydrate'),
    WorkoutSet(20, 'Normal'),
  ];

  bool start = false;

  late int timerValue;
  late int timerLength = 10;

  late StreamSubscription secondsSub;

  @override
  void afterFirstLayout(BuildContext context) async {
    secondsLoop();
  }


  void secondsLoop() async {
    const Duration timerDuration = const Duration(seconds: 1);

    secondsSub = new Stream.periodic(timerDuration)
        .listen((_) => updateTimer());
  }

  void updateTimer () async {

    // if (timersComplete == timers.length-1){
    //   secondsSub.cancel();
    //   workoutComplete = true;
    // }

    numberOfSecondPast++;
    if (numberOfSecondPast == timers[timersComplete].getDuration) {
      numberOfSecondPast = 0;
      timersComplete++;
      setState(() {
        timerLength = timers[timersComplete].getDuration;
        controller.restart(duration: timerLength);
      });
      setType = timers[timersComplete].getType;
      print(timersComplete.toString());
      print(timers.length.toString());
    }

    setState(() {
      timerLength = timers[timersComplete].getDuration;
      // int timeLeft = timerLength-numberOfSecondPast;
      // timerValue = timeLeft;

      // if (timeLeft > 5){
      //   timerColor = g60Green;
      //   timerFontColor = Colors.black;
      // } else {
      //   timerColor = g60Red;
      //   timerFontColor = Colors.white;
      // }



    });
  }

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery. of(context).size.height;

    return Scaffold (
      body: Container(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              TimerRow(timerLength: timerLength, controller: controller,),
              Container(color: Colors.black, width: double.infinity, height: 15,),
              getContentSection(),
            ],
          )),
    );
  }

  Widget getContentSection(){
    switch(setType) {
      case 'Normal': {
        return NormalView();
      }
      case 'Move': {
        return MoveView();
      }
      case 'Hydrate': {
        return HydrateView();
      }
      default: {
        return NormalView();
      }
    }
  }
}

