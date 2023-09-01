import 'package:flutter/material.dart';
import '../extras/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key, this.thickness = 1}) : super(key: key);

  final double thickness;

  @override
  Widget build(BuildContext context) {
   return Divider(
      color: CColors.divider,
      thickness: thickness,
    );
  }
}
