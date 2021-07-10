import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:g60/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'package:firebase/firebase.dart' as FB;
import  'package:firebase_core/firebase_core.dart';
import 'locator.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  if (!kIsWeb){
    await Firebase.initializeApp();
  } else {
    // if (App.apps.length == 0){
    //   Firebase.initializeApp(
    //       apiKey: "AIzaSyDuGYGJt4YOXtIzZ_jdCdutXPqSqZk8hmU",
    //       authDomain: "g60workout.firebaseapp.com",
    //       databaseURL: "https://g60workout-default-rtdb.asia-southeast1.firebasedatabase.app",
    //       projectId: "g60workout",
    //       appId: "1:1084847433812:web:0ddb3b2defef3bad2c65c1");
    // }
  }
  runApp(G60App());
}

