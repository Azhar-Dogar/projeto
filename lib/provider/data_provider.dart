import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/user_model.dart';

class DataProvider with ChangeNotifier {
  DataProvider() {
    authStream();
  }

  authStream() {
    Constants.auth().userChanges().listen((user) {
      if (user == null) {
        cancelStreams();
      } else {
        callFunctions();
      }
    });
  }

  callFunctions() {
    getProfile();
  }

  cancelStreams() {
    profileStream?.cancel();
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? profileStream;

  UserModel? userModel;
  getProfile() {
    profileStream =
        Constants.users.doc(Constants.uid()).snapshots().listen((snapshot) {
          if(snapshot.exists){
            userModel = UserModel.fromMap(snapshot.data()!);
          }else{
            userModel = null;
          }

          notifyListeners();
        });
  }
}
