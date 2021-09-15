import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class ExerciseVideo extends StatefulWidget {

  final VideoPlayerController? controller;
  final int exerciseNumber;

  ExerciseVideo({this.controller, required this.exerciseNumber});


  @override
  _ExerciseVideoState createState() => _ExerciseVideoState();
}

class _ExerciseVideoState extends State<ExerciseVideo> {
  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var videoWidth = (width/2)-10;

    return widget.controller != null && widget.controller!.value.isInitialized
          ? Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              children: [
                Container(
                  width: videoWidth,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(child: AspectRatio(
                        aspectRatio: 16/9,
                        child: VideoPlayer(widget.controller!))),
                  ),
                ),
                Container(
                  height: 30,
                  width: videoWidth,
                  color: Colors.deepPurpleAccent,
                  child: Center(child: Text(widget.exerciseNumber.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),)),
                ),
              ],
            ),
          )
          : Container(height: 300, child: Center(child: Text('Loading...', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
    );
  }
}

//     aspectRatio: widget.controller!.value.aspectRatio,