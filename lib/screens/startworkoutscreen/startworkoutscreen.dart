import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g60/comms/udp_test.dart';
import 'package:g60/screens/startworkoutscreen/widget/exercisevideo.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:g60/views/home/timer_row.dart';
import 'package:intl/intl.dart';
import 'package:g60/screens/basescreen/base_view.dart';
import '../../routes.dart';
import 'startworkoutviewmodel.dart';
import 'package:websafe_svg/websafe_svg.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class StartWorkoutScreen extends StatefulWidget {

  @override
  _StartWorkoutScreenState createState() => _StartWorkoutScreenState();
}

class _StartWorkoutScreenState extends State<StartWorkoutScreen> {

  // Max 10 per screen

  // 4 screens

  // 4 * 1 = 4
  // 4 * 2 = 8
  // 4 * 3 = 12
  // 4 * 4 = 16
  // 4 * 5 = 20
  // 4 * 6 = 24
  // 4 * 8 = 32
  // 4 * 9 = 36
  // 4 * 10 = 40
  //
  // 40 = 10, 10, 10, 10     10
  // 39 = 10, 10, 10, 9      10
  // 38 = 10, 10, 10, 8      10
  // 37 = 10, 10, 10, 7      10
  // 36 = 9, 9, 9, 9         10
  // 35 = 9, 9, 9, 8         10
  // 34 = 9, 9, 9, 7         10
  // 33 = 9, 9, 9, 6         10
  // 32 = 8, 8, 8, 8         8
  // 31 = 8, 8, 8, 7         8
  // 30 = 8, 8, 8, 6         8
  // 29 = 8, 8, 8, 5         8
  // 28 = 7, 7, 7, 7         8
  // 27 = 7, 7, 7, 6
  // 26 =

  // number of screens / sets = 39
  //
  // int stationIndex = ((index+1) / workout.setsPerStation!).ceil();
  // int setIndex = (index+1) % workout.setsPerStation!.floor();
  // setIndex == 0 ? setIndex = workout.setsPerStation! : setIndex = setIndex;



  List <String> _videos = [
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626764447/exercises/Wide-grip_barbell_curl_zvzw1k.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626764447/exercises/Suspended_ab_fall-out_r2tgsu.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626764446/exercises/Step-up_with_knee_raise_xhocks.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626518982/exercises/Lat_pull-down_lwvzn3.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626518980/exercises/Incline_dumbbell_bench_press_m7vnul.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/c_fill,h_270,w_480/v1626518977/exercises/Dumbbell_Flyes_vkqu6e.mp4',
  ];

  bool playing = false;
  late List <VideoPlayerController> controllers = [];
  late List <ExerciseVideo> exerciseVideos = [];
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    setupPlayer();
  }


  void setupPlayer(){

    for (int i = 0; i < _videos.length; i ++){

      exerciseVideos.add(ExerciseVideo(controller: null, exerciseNumber: 0,));

      controller = VideoPlayerController.network(
        _videos[i],
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true,),
      );

      controller.setLooping(true);
      controllers.add(controller);

      controllers[i].initialize().then((value) {
        ExerciseVideo exerciseVideo = ExerciseVideo(controller: controllers[i], exerciseNumber: i+1,);
        exerciseVideos[i] = exerciseVideo;
        setState(() {});
      });

    }

  }

  

  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: BaseView<StartWorkoutViewModel>(
        onModelReady:(_){},
        builder: (context, model, child) {
          return
            Container(
              color: Colors.blue,
              width: width,
              height: height,
              child: Column(
                children: [
                  // TimerRow(
                  //     timerContainerBackgroundColor: timerContainerBackgroundColor(setType),
                  //     setsToGo: setsToGo,
                  //     timerWidget: TimerWidget(
                  //       timerValue: timerValue,
                  //       animationController: controller,
                  //       timerDuration: timerDuration,
                  //       timerTextColor: timerTextColor(setType),
                  //     )
                  // ),
                  Wrap(
                    spacing: 5,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    children:
                      exerciseVideos,
                  ),
                ],
              ),
            );

          }
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            
            controllers.forEach((controller) {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            });

            setState(() {
              playing = !playing;
            });

          },
          child: Icon(
            playing ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controllers.forEach((controller) {
      controller.dispose();
    });
  }
}
