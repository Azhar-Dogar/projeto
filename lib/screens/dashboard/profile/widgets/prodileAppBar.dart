import 'package:flutter/material.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import '../../../../extras/app_textstyles.dart';

AppBar profileAppBar(String str) {
  return AppBar(
    title: Text(
      str,
      style: AppTextStyles.captionMedium(),
    ),
    actions: const [
      ProfileHeaderWidget(),
    ],
  );
}