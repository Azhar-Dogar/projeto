import 'package:flutter/cupertino.dart';

import 'colors.dart';

class Constants{
  static List<BoxShadow> shadow() {
    return  [
      const BoxShadow(
        color: CColors.shadowColor,
        blurRadius: 10,
        offset: Offset(0, 3), // Shadow position
      ),
    ];
  }
}