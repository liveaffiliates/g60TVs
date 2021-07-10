import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:g60/theme/g60_colors.dart';
import 'package:intl/intl.dart';
import 'package:g60/screens/basescreen/base_view.dart';
import '../../routes.dart';
import 'setupstudioviewmodel.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SetupStudioScreen extends StatefulWidget {

  @override
  _SetupStudioScreenState createState() => _SetupStudioScreenState();
}

class _SetupStudioScreenState extends State<SetupStudioScreen> {



  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: BaseView<SetupStudioViewModel>(
      onModelReady:(_){},
      builder: (context, model, child) {

        return Container(
          height: height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/sushil-ghimire-5UbIqV58CW8-unsplash (1).jpg', fit: BoxFit.cover,)),
              Positioned.fill(child: Container(color: Colors.black.withOpacity(0.7),)),
              Align(alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [

                  ],),
                ),
              )

            ],
          ),
        );
        }
      ),
    );
  }
}
