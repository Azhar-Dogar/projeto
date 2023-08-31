import 'package:flutter/material.dart';

class CColors {
  static var primary = const Color(0xff00A847);
  static var borderBlue = const Color(0xff5B9FE5);
  static var dashboard = const Color(0xffF7F7F7);
  static var textBlue = const Color(0xff399BFF);
  static var textFieldBorder = const Color(0xffACACAC);
  static var textBlue2 = const Color(0xff3842B6);
  static var buttonBlue = const Color(0xff5260FF);
  static var purple = const Color(0xff7F11ED);
  static var stoke = const Color(0xffeeeff6);
  static var ice = const Color(0xffCED6FF);
  static var red = const Color(0xffC50101);
  static var textRed = const Color(0xffFF6C75);
  static var textGreen = const Color(0xff50B748);
  static var textFieldHintColor = const Color(0xff5b5b5b);
  static var textColor = const Color(0xff4F4F4F);
  static var blue = const Color(0xff3880FF);
  static var lightBlue = const Color(0xff99D8FF);

  static var lightGrey = const Color(0xff5B5B5B);
  static var white = const Color(0xffFFFFFF);
  static var greyWhite = const Color(0xff979797);
  static var divider = const Color(0xffEFEFF4);
  static var paymentContainer = const Color(0xffF1F2F6);





  static var labelColor = const Color(0xff393939);

  static var dark = const Color(0xff222428);
  static var gray = const Color(0xff515466);
  static var lightGray = const Color(0xff6F7072);
  static var lightGray2 = const Color(0xffF1F0F0);
  static var backGroundColor = const Color(0xffEEEFF7);
  static var videoButton = const Color(0xff3980FF).withOpacity(0.06);
  static var dividerColor = const Color(0xffD4DBDF);
  static var creamColor = const Color(0xffE7E7E7);
  static var contactBlack = const Color(0xff161E20);
  static var black = const Color(0xff000000);
  static var searchColor = const Color(0xff92949C);
  static var logoutColor = const Color(0xffFF5479);
  static var promoColor = const Color(0xff536468);
  static var viewProfileColor = const Color(0xffFF5479);
  static var contactGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xff5B9FE5).withOpacity(0.85),
        const Color(0xffC8B5FF).withOpacity(0.85),
      ]);
  static var blueGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xff60A9FF),
        Color(0xff399BFF),
        Color(0xff7B61FF),
      ]);
  static var textLight = const Color(0xff737879).withOpacity(
    0.76,
  );

  static MaterialColor getMaterialColor(Color color) {
    return MaterialColor(color.value, CColors.getSwatch(color));
  }

  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    const lowDivisor = 6;
    const highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;
    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
