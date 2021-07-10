import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: (TextTheme(
      headline1: GoogleFonts.bungeeShade(fontWeight: FontWeight.bold, fontSize: 100, color: Colors.white),
      headline2: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 60, color: Colors.white),
      headline3: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white),
      bodyText1: GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 14),
      bodyText2: GoogleFonts.openSans(fontWeight: FontWeight.normal, fontSize: 12),
    )));
