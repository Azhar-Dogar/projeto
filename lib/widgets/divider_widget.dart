import 'package:flutter/material.dart';
import '../extras/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Divider(
      color: CColors.divider,
      height: 1,
    );
  }
}
