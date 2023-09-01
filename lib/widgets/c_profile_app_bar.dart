import 'package:flutter/material.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import '../extras/app_textstyles.dart';

AppBar CustomAppBar(String str, {bool? isInstructor}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Colors.black),
    title: Text(
      str,
      style: AppTextStyles.captionMedium(),
    ),
    actions: [
      if (isInstructor == true)
        ...[]
      else ...[
        const ProfileHeaderWidget(),
      ]
    ],
  );
}
