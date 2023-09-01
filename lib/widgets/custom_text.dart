import 'package:flutter/material.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textColor});

  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTextStyles.poppins(
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: textColor,
        ),
      ),
    );
  }
}
