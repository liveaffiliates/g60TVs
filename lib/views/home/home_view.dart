import 'dart:isolate';

//import 'package:firebase/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g60/models/workout_set.dart';
import 'package:g60/models/workout_set_type.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:after_layout/after_layout.dart';
import 'package:g60/views/home/complete_view.dart';
import 'package:g60/views/home/hydrate_view.dart';
import 'package:g60/views/home/move_view.dart';
import 'package:g60/views/home/normal_view.dart';
import 'package:g60/views/home/stay_view.dart';
import 'package:g60/views/home/timer_row.dart';
import 'package:g60/views/home/waiting_view.dart';
import 'package:g60/widgets/Timer/timer_colors.dart';
import 'dart:async';
//import 'package:firebase/firebase.dart';

import '../../widgets/Timer/countdown_timer.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AfterLayoutMixin<HomeView>, TickerProviderStateMixin{

  late AnimationController controller;

  late int timerValue;
  late int timerDuration;
  int timerCurrentSeconds = 0;
  late StreamSubscription secondsSub;
  int numberOfSetsCompleted = 0;
  int normalTime = 200;
  int moveTime = 10;
  int hydrationTime = 10;
  int stayTime = 10;
  late WorkoutSetType setType;
  List<WorkoutSet> workoutSets = [];
  Color timerColor = g60Green;
  Color timerFontColor = Colors.black;
  late int setsToGo;
  var startSignalSub;
  int screenNumber = 2;



  @override
  void initState() {
    super.initState();
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(stayTime, WorkoutSetType.Stay),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(moveTime, WorkoutSetType.Move),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(stayTime, WorkoutSetType.Stay),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(moveTime, WorkoutSetType.Move),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(stayTime, WorkoutSetType.Stay),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    workoutSets.add(WorkoutSet(normalTime, WorkoutSetType.Normal),);
    setType = WorkoutSetType.Waiting;
    timerDuration = workoutSets[0].getDuration;
    setsToGo = workoutSets.length;
    timerValue = timerDuration;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: workoutSets[0].getDuration),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) async {
    listenForStartSignal();
  }

  void listenForStartSignal(){
    // Database db = database();
    // DatabaseReference ref = db.ref('start');
    // startSignalSub = ref
    //     .onValue
    //     .listen((data) {
    //
    //       bool startValue = data.snapshot.val();
    //
    //       if (startValue == true){
    //         print('running');
    //         startExercise();
    //       }
    //     });
  }

  void startExercise() async {
    setState(() {
      setType = workoutSets[0].getType;
    });
    const Duration timerDuration = const Duration(seconds: 1);
    secondsSub = new Stream.periodic(timerDuration)
        .listen((_) => updateTimer());
  }

  void startTimer(){
    if (!controller.isAnimating){
      controller.reverse(
          from: controller.value == 0.0
              ? 1.0
              : controller.value);
    }
  }

  void updateTimer () async {
    startTimer();
    setState(() {
      timerValue = timerDuration - timerCurrentSeconds;
    });

    if (timerCurrentSeconds == timerDuration) {
      print(numberOfSetsCompleted);
      print(workoutSets.length);
      if (numberOfSetsCompleted != workoutSets.length-1){
        setState(() {
          // Reset the seconds counter
          timerCurrentSeconds = 0;
          // Go to the next set
          numberOfSetsCompleted++;
          // Set the new timer time for the new set
          timerDuration = workoutSets[numberOfSetsCompleted].getDuration;
          // Set the set type to the type of the new set
          setType = workoutSets[numberOfSetsCompleted].getType;
          // Reset the timer
          controller.reset();

          // Update the sets to go
          setsToGo = workoutSets.length - numberOfSetsCompleted;
        });

      } else {

        secondsSub.cancel();
        setState(() {
          setType = WorkoutSetType.Complete;
          setsToGo = 0;
        });
      }

    } else {
      // Add one to the timer seconds
      timerCurrentSeconds++;
    }
  }

  @override
  Widget build(BuildContext context) {
    print(setType.toString());

    double height = MediaQuery. of(context). size. height;
    double width = MediaQuery. of(context). size. width;

    double gapLargeWidth = 15;
    double gapSmallWidth = 5;

    double rowHeight = (height-(1*gapLargeWidth+2*gapSmallWidth))/4;
    double topColumnSize = (width-(2*gapLargeWidth))/3;

    return Scaffold (
      body: Container(
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Visibility(
                visible: setType != WorkoutSetType.Waiting && setType != WorkoutSetType.Complete,
                child: Column(
                  children: [
                    TimerRow(
                      timerContainerBackgroundColor: timerContainerBackgroundColor(setType),
                      setsToGo: setsToGo,
                      timerWidget: TimerWidget(
                        timerValue: timerValue,
                        animationController: controller,
                        timerDuration: timerDuration,
                        timerTextColor: timerTextColor(setType),
                      )
                    ),
                    Container(color: Colors.black, width: double.infinity, height: 15,),
                  ],
                ),
              ),
              getContentSection(),
            ],
          )),
    );
  }

  Widget getContentSection(){
    switch(setType) {
      case WorkoutSetType.Normal: {
        return NormalView(screenNumber);
      }
      case WorkoutSetType.Move: {
        return MoveView();
      }
      case WorkoutSetType.Stay: {
        return StayView();
      }
      case WorkoutSetType.Complete: {
        return CompleteView();
      }
      case WorkoutSetType.Waiting: {
        return WaitingView();
      }
      default: {
        return NormalView(screenNumber);
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    startSignalSub.cancel();
    secondsSub.cancel();
  }
}

