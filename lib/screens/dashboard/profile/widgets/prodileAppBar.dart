import 'package:flutter/material.dart';
import 'package:projeto/screens/dashboard/profile/widgets/profile_header_widget.dart';
import '../../../../extras/app_textstyles.dart';

AppBar profileAppBar() {
  return AppBar(
    title: Text(
      "Pagamento",
      style: AppTextStyles.captionMedium(),
    ),
    actions: const [
      ProfileHeaderWidget(),
    ],
  );
}