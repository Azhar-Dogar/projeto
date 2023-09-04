import 'package:firebase_auth/firebase_auth.dart';
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


  //auth

  static FirebaseAuth auth() {
    return FirebaseAuth.instance;
  }

  static User? user() {
    return auth().currentUser;
  }

  static String uid() {
    return auth().currentUser!.uid;
  }
}