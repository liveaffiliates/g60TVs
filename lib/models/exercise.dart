
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:g60/models/workout_set_type.dart';

class Exercise with ChangeNotifier {

  Exercise();

  String? _id;
  String? _name;
  String? _type;
  String? _subtype;
  String? _videoURL;
  String? _imageURL;

  Exercise.fromSnapshot({required DocumentSnapshot snapshot, required Map<String, dynamic> data})
      :
        _id = snapshot.id,
        _name = data.containsKey('name')
            ? snapshot['name']
            ?? ''
            : '',
        _type = data.containsKey('type')
            ? snapshot['type']
            ?? ''
            : '',
        _subtype = data.containsKey('subtype')
            ? snapshot['subtype']
            ?? ''
            : '',
        _videoURL = data.containsKey('videoUrl')
            ? snapshot['videoUrl']
            ?? ''
            : '',
        _imageURL = data.containsKey('imageUrl')
            ? snapshot['imageUrl']
            ?? ''
            : '';


  void setId(String value){
    _id = value;
    notifyListeners();
  }

  String? get getId => _id;

  void setName(String value){
    _name = value;
    notifyListeners();
  }

  String? get getName => _name;

  void setType(String value){
    _type = value;
    notifyListeners();
  }

  String? get getType => _type;

  void setSubType(String value){
    _subtype = value;
    notifyListeners();
  }

  String? get getSubType => _subtype;

  void setVideoURL(String value){
    _videoURL = value;
    notifyListeners();
  }

  String? get getVideoURL => _videoURL;

  void setImageURL(String value){
    _imageURL = value;
    notifyListeners();
  }

  String? get getImageURL => _imageURL;

}