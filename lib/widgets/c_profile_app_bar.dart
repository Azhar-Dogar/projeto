import 'package:flutter/material.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import '../extras/app_textstyles.dart';

AppBar CustomAppBar(String str) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
    title: Text(
      str,
      style: AppTextStyles.captionMedium(),
    ),
    actions: const [
      ProfileHeaderWidget(),
    ],
  );
}
