import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g60/models/exercise.dart';
import 'package:g60/screens/basescreen/base_view.dart';
import 'package:g60/screens/createworkoutsscreen/popups/pickexerciseviewmodel.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:after_layout/after_layout.dart';


class PickExercisePopup extends StatefulWidget {

  PickExercisePopup ();

  @override
  State<StatefulWidget> createState() => PickExercisePopupState();
}

class PickExercisePopupState extends State<PickExercisePopup>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;


  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  TextStyle style = TextStyle(
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.normal);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseView<PickExerciseViewModel>(
          onModelReady:(_){},
          builder: (context, model, child) {
            return Center(
              child: Material(
                color: Colors.transparent,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 50, right: 20, left: 20),
                        child: (Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              children: [
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(top:16.0, left: 0.0),
                                  child: InkWell(
                                    child: Icon(Icons.close,size: 25),onTap: (){
                                    Navigator.pop(context);
                                  },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20,),
                            Center(
                              child: Text(
                                  'Select Exercise',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.black)),
                            ),
                            SizedBox(height: 20,),
                            FutureBuilder(
                              future: model.firestoreService.getExercises(),
                              builder: (BuildContext context, snapshot) {
                                if (!snapshot.hasData){
                                  return Container(
                                      width: double.infinity,
                                      child: Center(child: CircularProgressIndicator()));
                                } else {
                                  List <Exercise> exercises = snapshot.data! as List<Exercise>;
                                  return ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: exercises.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        Exercise exercise = exercises[index];
                                        return
                                          Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(exercises[index].getName ?? '', textAlign: TextAlign.center,  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                                                  ChewieListItem(
                                                    videoUrl: exercises[index].getVideoURL ??
                                                        'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/error.mp4',
                                                  ),
                                                 Text('Exercise Type: ' +  (exercises[index].getType ?? 'General'), textAlign: TextAlign.center,  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black)),
                                                 Text('Muscle Group: ' +  (exercises[index].getSubType ?? 'Whole body'), textAlign: TextAlign.center,  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.normal, fontSize: 16, color: Colors.black)),
                                                ],
                                              ),
                                            ),
                                          );
                                      }
                                  );
                                }
                              },
                            ),
                          ],
                        )),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
      ),
    );
  }


}

class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final String videoUrl;


  ChewieListItem({required this.videoUrl});

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {

  late VideoPlayerController _videoPlayerController;


  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
        widget.videoUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _videoPlayerController.addListener(() {
            if (!_videoPlayerController.value.isPlaying &&
                _videoPlayerController.value.isInitialized &&
                (_videoPlayerController.value.duration ==
                    _videoPlayerController.value
                        .position)) { //checking the duration and position every time
              //Video Completed//
              setState(() {
                _videoPlayerController.play();
              });
            }
        });
      });
  }

  Future <bool> playVideo() async {
    return true;
  }

    @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: playVideo(),
      builder: (context, snapshot) {

        if (snapshot.hasData){

          return _videoPlayerController.value.isInitialized
                ? Container(
                    height: 200,
                    child: Stack(
                      children: [
                        Center(
                          child: AspectRatio(
                            aspectRatio: _videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(_videoPlayerController),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              icon: Icon(
                                  _videoPlayerController.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.lightBlue),
                              onPressed: () {
                                setState(() {
                                  _videoPlayerController.value.isPlaying
                                      ? _videoPlayerController.pause()
                                      : _videoPlayerController.play();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(
                  height: 200,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
                );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading'),
            ],
          );
        }

      }
    );
  }


  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    _videoPlayerController.dispose();

  }
}

//   InkWell(
//     child: ClipRRect(
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         height: 300,
//         width: double.infinity,
//         child: Stack(
//           children: [
//
//             // Container(
//             //   // decoration: BoxDecoration(image:
//             //   // DecorationImage(image: NetworkImage(exercise.getImageURL ?? ''),
//             //   //     fit: BoxFit.cover,
//             //   //     colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken)
//             //   // )
//             //   //),
//             //   child: Center(
//             //     child: Column(
//             //       mainAxisSize: MainAxisSize.min,
//             //       children: [
//             //         Text('Type: ' +  (exercises[index].getType ?? 'No type'), textAlign: TextAlign.center,  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
//             //         Text('Subtype: ' +  (exercises[index].getSubType ?? 'No subtype'), textAlign: TextAlign.center,  style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
//             //       ],
//             //     ),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     ),
//     onTap: (){
//
//     },
//   ),
// );

