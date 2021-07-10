import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g60/screens/createworkoutsscreen/widgets/textdropdownfield.dart';
import 'package:g60/screens/createworkoutsscreen/widgets/textentryfield.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:intl/intl.dart';
import 'package:g60/screens/basescreen/base_view.dart';
import '../../routes.dart';
import 'createworkoutviewmodel.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/services.dart';
import 'dart:ui';


class CreateWorkoutScreen extends StatefulWidget {

  @override
  _CreateWorkoutScreenState createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {

  ScrollController sc = ScrollController();

  int numStations = 15;
  int setsPerStation= 3;
  int setDuration = 45;
  int breakBetweenStations = 30;
  int breakBetweenSets = 20;
  int hydrationBreaks = 0;


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
        return Container(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/sushil-ghimire-5UbIqV58CW8-unsplash (1).jpg', fit: BoxFit.cover,)),
              Positioned.fill(child: Container(color: Colors.black.withOpacity(0.7),)),
              SlidingUpPanel(
                maxHeight: _panelHeightOpen,
                minHeight: _panelHeightClosed,
                parallaxEnabled: true,
                parallaxOffset: .5,
                body: _body(),
                panelBuilder: (sc) => _panel(sc),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0)),
                onPanelSlide: (double pos) => setState(() {
                  // _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  //     _initFabHeight;
                }),
              ),

            ],
          ),
        );
        }
      ),
    );
  }


  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: ListView(
            controller: sc,
            children: <Widget>[
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  ),
                ],
              ),
              SizedBox(
                height: 18.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Create Workout",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 36.0,
              ),

              Column(
                children: [
                  TextEntryField(
                    hintText: 'Workout Name',
                    initialValue: '',
                    inputType: TextInputType.text,
                    numberOfLines: 1,
                    onChanged: (){},
                    enable: true,
                  )
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Number of stations",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '1',
                          dropDownList: ['1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Sets per station",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '1',
                          dropDownList: ['1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Set duration",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '1',
                          dropDownList: ['1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Break between stations",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '1',
                          dropDownList: ['1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Break between sets",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '1',
                          dropDownList: ['1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(width: 20,),

                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Hydration breaks",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(height: 5,),
                        TextDropdownField(
                          hintText: '',
                          onChanged: (){},
                          value: '0',
                          dropDownList: ['0','1', '2', '3', '4', '5'],
                        ),
                      ],
                    ),
                  ),

                ],
              ),



              SizedBox(
                height: 24,
              ),
            ],
          ),
        ));
  }

  Widget _body() {
    return Stack(
      children: [
        Image.asset('assets/sushil-ghimire-5UbIqV58CW8-unsplash (1).jpg', fit: BoxFit.cover,),
        Positioned.fill(child:
        ListView.builder(
            itemCount: numStations,
            itemBuilder: (BuildContext ctxt, int stationIndex) {
              return Padding(
                padding: EdgeInsets.only(bottom: 100, left: 50, right: 50),
                child: Container(
                  width: double.infinity,

                  child: Column(
                    children: [
                      Text('Station ' + (stationIndex + 1).toString(), style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white)),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: setsPerStation,
                          itemBuilder: (BuildContext ctxt, int setIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                color: g60LightGreyBlue.withOpacity(0.8),
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image.asset('assets/fit1jpg.jpg', width: 200, height: 200, fit: BoxFit.cover,)),
                                      SizedBox(width: 30,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Exercise: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                                          SizedBox(height: 5,),
                                          Text('Set Duration: ' + setDuration.toString(), style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                                          SizedBox(height: 5,),
                                          Text('Rest period after set: ', style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
                                        ],
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.edit_rounded, size: 40, color: Colors.white,),
                                        onPressed: (){}),
                                      SizedBox(width: 20,),
                                    ],
                                  ),
                                )),
                              ),
                            );
                          }
                      )],
                  ),
                ),
              );
            }
        )
        ),
      ],

    );
  }
}







