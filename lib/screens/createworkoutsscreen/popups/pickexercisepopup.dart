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
                                          Container(
                                            height: 200,
                                            child: Card(
                                              child: ChewieListItem(
                                                videoUrl: exercises[index].getVideoURL ??
                                                    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/error.mp4',
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
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16/9,
      showControls: false,
      // Prepare the video to be played and display the first frame
      looping: true,
      autoPlay: true,
      allowFullScreen: false,
      allowMuting: true,
      allowedScreenSleep: false,
      autoInitialize: true,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

  }

  Future<void> initializeVideoPlayer() async {
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
      await Future.wait([
        _videoPlayerController.initialize()
      ]);
  }

  Future<bool> playVideo () async{
    await Future.delayed(const Duration(seconds: 2), (){});
    return true;
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: playVideo(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          //_videoPlayerController.play();
          return Center(
            child: Chewie(
              controller: _chewieController,
            )
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
    _chewieController.dispose();
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
//             //         Text(exercises[index].getName ?? 'No exercise', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white)),
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

