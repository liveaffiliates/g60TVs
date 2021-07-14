import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

Image blankImage (){
  Uint8List blankBytes = Base64Codec().decode("data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7");
  return Image.memory(blankBytes,height: 1,);
}
