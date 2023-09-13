import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard_screen.dart';
import 'package:projeto/screens/instructor/instructor_dashboard.dart';
import 'package:provider/provider.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;


class CheckData extends StatefulWidget {
  const CheckData({super.key});

  @override
  State<CheckData> createState() => _CheckDataState();
}

class _CheckDataState extends State<CheckData> {
  @override
  void initState() {
    super.initState();
  }

  listenLocation() async {
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      saveData(location);
    });
    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  saveData(bg.Location location) async {
    if(Constants.user() != null){
      FirebaseDatabase _database =
      FirebaseDatabase(app: null,databaseURL: "https://mazzi-b3641-default-rtdb.europe-west1.firebasedatabase.app/");
      final databaseReference = _database.reference();
      await databaseReference.child("location")
          .child(Constants.uid()).set({
        "latitude": location.coords.latitude,
        "longitude": location.coords.longitude,
      });

    }
  }

  late DataProvider provider;
  @override
  Widget build(BuildContext context) {

    // Constants.auth().signOut();
    return Consumer<DataProvider>(
      builder: (context, data, child) {
        provider = data;
        if(data.userModel != null){
          if(data.userModel!.isUser){
            return DashBoard();
          }else{
            listenLocation();
            return InstructorDashboard();
          }
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    );
  }
}
