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

  static TextStyle captionMedium({Color color = Colors.black, double size = 12, FontWeight fontWeight = FontWeight.w500}){
    return GoogleFonts.poppins(
      fontWeight: fontWeight,
      fontSize: size,
      color: color,

    );
  }
  static TextStyle captionRegular({Color color = Colors.black,double size = 12}){
    return captionMedium( color: color, fontWeight: FontWeight.w400,size: size);
  }


  static TextStyle subTitleMedium({Color color = Colors.black,double size = 14}){
    return captionMedium(size:size, color: color);
  }
  static TextStyle subTitleRegular({Color color = Colors.black}){
    return captionMedium(size: 14, color: color, fontWeight: FontWeight.w400);
  }

  static TextStyle h4Medium({Color color = Colors.black}){
    return captionMedium(size: 28, color: color);
  }

  static TextStyle titleMedium({Color color = Colors.black, FontWeight weight = FontWeight.w500}){
    return captionMedium(size: 16, color: color, fontWeight: weight);
  }
  static TextStyle titleRegular({Color color = Colors.black, FontWeight weight = FontWeight.w400}){
    return captionMedium(size: 16, color: color, fontWeight: weight);
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
