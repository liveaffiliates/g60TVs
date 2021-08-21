import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g60/models/exercise.dart';
import 'package:g60/models/workout.dart';
import 'package:g60/screens/createworkoutsscreen/popups/pickexercisepopup.dart';
import 'package:g60/screens/createworkoutsscreen/settingdropdown.dart';
import 'package:g60/screens/createworkoutsscreen/widgets/textdropdownfield.dart';
import 'package:g60/screens/createworkoutsscreen/widgets/textentryfield.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:intl/intl.dart';
import 'package:g60/screens/basescreen/base_view.dart';
import '../../routes.dart';
import 'createworkoutviewmodel.dart';
import 'package:flutter/services.dart';
import 'dart:ui';


class CreateWorkoutScreen extends StatefulWidget {

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {

  ScrollController sc = ScrollController();

  String workoutName = '';
  int numberOfStations = 7;
  int setsPerStation= 3;
  int setDuration = 45;
  int breakBetweenStations = 30;
  int breakBetweenSets = 20;
  late List <Exercise> exercises;
  late Workout workout;

  @override
  void initState() {
     super.initState();

     exercises = List<Exercise>.filled(numberOfStations * setsPerStation, Exercise(), growable: true);

     workout = Workout(
         name: workoutName,
         numberOfStations: numberOfStations,
         setsPerStation: setsPerStation,
         setDuration: setDuration,
         breakBetweenStations: breakBetweenStations,
         breakBetweenSets: breakBetweenSets,
         exercises: exercises);
  }

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    double _panelHeightOpen = height * .80;
    double _panelHeightClosed = height * .10;

    return Scaffold(
      body: BaseView<CreateWorkoutViewModel>(
      onModelReady:(_){},
      builder: (context, model, child) {
        return _body();
        }
      ),
    );
  }


  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50.0,
            ),

            Text(
              "Create Workout",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),

            TextEntryField(
              hintText: 'Workout Name',
              initialValue: '',
              inputType: TextInputType.text,
              numberOfLines: 1,
              onChanged: (){},
              enable: true,
            ),
            SizedBox(
              height: 20.0,
            ),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              children: [
                SettingDropDown(
                  headerText: 'Number of stations',
                  initialValue: numberOfStations,
                  onValueSelected: (newValue){
                    setState(() {
                      numberOfStations = newValue;
                    });
                  },
                  inputList: [for(var i=1; i<21; i+=1) i],
                ),

                SettingDropDown(
                  headerText: 'Sets per station',
                  initialValue: setsPerStation,
                  onValueSelected: (newValue){
                    setState(() {
                      setsPerStation = newValue;
                    });
                  },
                  inputList: [for(var i=1; i<6; i+=1) i],
                ),

                SettingDropDown(
                  headerText: 'Set duration',
                  initialValue: setDuration,
                  onValueSelected: (newValue){
                    setState(() {
                      setDuration = newValue;
                    });
                  },
                  inputList: [for(var i=1; i<61; i+=1) i]
                ),

                SettingDropDown(
                  headerText: 'Break between sets',
                  initialValue: breakBetweenSets,
                  onValueSelected: (newValue){
                    setState(() {
                      breakBetweenSets = newValue;
                    });
                  },
                  inputList: [for(var i=1; i<61; i+=1) i],
                ),

                SettingDropDown(
                  headerText: 'Break between stations',
                  initialValue: breakBetweenStations,
                  onValueSelected: (newValue){
                    setState(() {
                      breakBetweenStations = newValue;
                    });
                  },
                  inputList: [for(var i=1; i<60; i+=1) i],
                ),
            ]),

            SizedBox(
              height: 24,
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: numberOfStations,
                itemBuilder: (BuildContext ctxt, int stationIndex) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text('Station ' + (stationIndex + 1).toString(), style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.black)),
                          SizedBox(height: 20,),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: setsPerStation,
                              itemBuilder: (BuildContext ctxt, int setIndex) {
                                int exerciseIndex = stationIndex * setsPerStation + setIndex;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: InkWell(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 250,
                                        width: double.infinity,
                                        decoration: BoxDecoration(image:
                                        DecorationImage(image: AssetImage('assets/1.gif'),
                                          fit: BoxFit.cover,
                                          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken)
                                         )
                                        ),
                                        child: Center(
                                          child: Text(exercises[exerciseIndex].getName ?? 'Choose Exercise', textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white)) ,
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder: (_) => PickExercisePopup()
                                      );
                                      // setState(() {
                                      //   exercises[exerciseIndex] = Exercise(name: 'Test Exercise');
                                      // });
                                    },
                                  ),
                                );
                              }
                          )],
                      ),
                    ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}







