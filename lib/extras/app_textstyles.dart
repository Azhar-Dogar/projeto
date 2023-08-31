import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle sanFransiscoDisplay(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "sf");
    return textStyle;
  }

  static TextStyle aktivGrotest(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "aktiv");
    return textStyle;
  }
  static TextStyle sansPro(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "Source Sans Pro");
    return textStyle;
  }

  static TextStyle apfelGrotezk(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "apfel");
    return textStyle  ;
  }

  static TextStyle captionMedium({Color color = Colors.black, double size = 12}){
    return GoogleFonts.poppins(
      fontWeight: FontWeight.w500,
      fontSize: size,
      color: color
    );
  }

  static TextStyle subTitleMedium({Color color = Colors.black}){
    return captionMedium(size: 14, color: color);
  }

  static TextStyle titleMedium({Color color = Colors.black}){
    return captionMedium(size: 16, color: color);
  }

  static TextStyle workSans({TextStyle? style}) {
    return GoogleFonts.workSans(textStyle: style);
  }
  static TextStyle poppins({TextStyle? style}) {
    return GoogleFonts.poppins(textStyle: style);
  }
  static TextStyle karla({TextStyle? style}) {
    return GoogleFonts.karla(textStyle: style);
  }

  static TextStyle aladin({TextStyle? style}) {
    return GoogleFonts.aladin(textStyle: style);
  }

  static TextStyle sourceSans({TextStyle? style}) {
    return GoogleFonts.sourceSansPro(textStyle: style);
  }

  static TextStyle homeMadeApple({TextStyle? style}) {
    return GoogleFonts.homemadeApple(textStyle: style);
  }
  static TextStyle inter(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    var textStyle = TextStyle(
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize,
        fontFamily: "Inter");
    return textStyle  ;
  }
}
