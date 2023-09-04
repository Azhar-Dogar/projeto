import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:utility_extensions/utility_extensions.dart';

import '../extras/app_textstyles.dart';
import '../extras/colors.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key,required this.name,required this.onPressed});
String name;
void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
   double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width,
      height: height * 0.06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              backgroundColor: CColors.primary),
          onPressed: onPressed,
          child: Text(
            name,
            style: AppTextStyles.poppins(
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          )),
    );
  }
}
