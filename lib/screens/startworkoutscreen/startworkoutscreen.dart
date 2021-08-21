import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g60/comms/udp_test.dart';
import 'package:g60/screens/startworkoutscreen/widget/exercisevideo.dart';
import 'package:g60/theme/g60_colors.dart';
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


  List <String> _videos = [
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
    'https://res.cloudinary.com/roboticc/video/upload/v1626518968/exercises/One-Arm_Dumbbell_Row_r8xpfh.mp4',
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

      exerciseVideos.add(ExerciseVideo(controller: null));

      controller = VideoPlayerController.network(
        _videos[i],
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      );
      controller.setLooping(true);

      controllers.add(controller);

      controllers[i].initialize().then((value) {
        ExerciseVideo exerciseVideo = ExerciseVideo(controller: controllers[i]);
        exerciseVideos[i] = exerciseVideo;
        setState(() {});
      });

    }

  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<StartWorkoutViewModel>(
      onModelReady:(_){},
      builder: (context, model, child) {
        return
          Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children:
              exerciseVideos,
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
