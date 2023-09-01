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

  static List<String> months = [
    "Jan",
    "Fev",
    "Mar",
    "Abr",
    "Mai",
    "Jun",
    "Jul",
    "Ago",
    "Set",
    "Out",
    "Nov",
    "Dez",
  ];
}