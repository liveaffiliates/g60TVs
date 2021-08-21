import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ExerciseVideo extends StatefulWidget {

  final VideoPlayerController? controller;

  ExerciseVideo({this.controller});


  @override
  _ExerciseVideoState createState() => _ExerciseVideoState();
}

class _ExerciseVideoState extends State<ExerciseVideo> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:  widget.controller != null && widget.controller!.value.isInitialized
          ? AspectRatio(
        aspectRatio: widget.controller!.value.aspectRatio,
        child: VideoPlayer(widget.controller!),
      )
          : Container(height: 300, child: Center(child: Text('Loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),),
    );
  }
}
