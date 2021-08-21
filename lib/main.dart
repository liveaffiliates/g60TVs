import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:g60/app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
//import 'package:firebase/firebase.dart' as FB;
import  'package:firebase_core/firebase_core.dart';
import 'locator.dart';
import 'package:device_info_plus/device_info_plus.dart';



void main() async{
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  if (!kIsWeb){
    await Firebase.initializeApp();
  } else {

   var deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);

   print(deviceData);

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

Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
  return <String, dynamic>{
    'version.securityPatch': build.version.securityPatch,
    'version.sdkInt': build.version.sdkInt,
    'version.release': build.version.release,
    'version.previewSdkInt': build.version.previewSdkInt,
    'version.incremental': build.version.incremental,
    'version.codename': build.version.codename,
    'version.baseOS': build.version.baseOS,
    'board': build.board,
    'bootloader': build.bootloader,
    'brand': build.brand,
    'device': build.device,
    'display': build.display,
    'fingerprint': build.fingerprint,
    'hardware': build.hardware,
    'host': build.host,
    'id': build.id,
    'manufacturer': build.manufacturer,
    'model': build.model,
    'product': build.product,
    'supported32BitAbis': build.supported32BitAbis,
    'supported64BitAbis': build.supported64BitAbis,
    'supportedAbis': build.supportedAbis,
    'tags': build.tags,
    'type': build.type,
    'isPhysicalDevice': build.isPhysicalDevice,
    'androidId': build.androidId,
    'systemFeatures': build.systemFeatures,
  };
}

