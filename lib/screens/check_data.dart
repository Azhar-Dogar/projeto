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

    listenLocation();
    super.initState();
  }

  listenLocation() async {

    // await bg.BackgroundGeolocation.stopBackgroundTask(0);
    ////
    // 1.  Listen to events (See docs for all 12 available events).
    //

    // Fired whenever a location is recorded
    bg.BackgroundGeolocation.onLocation((bg.Location location) {
      print("object1");
      saveData(location);
    });

    // Fired whenever the plugin changes motion-state (stationary->moving and vice-versa)


    ////
    // 2.  Configure the plugin
    //

    // bg.BackgroundGeolocation.stop();

    bg.BackgroundGeolocation.ready(bg.Config(
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 10.0,
        stopOnTerminate: false,
        startOnBoot: true,
        debug: true,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE
    )).then((bg.State state) {
      if (!state.enabled) {
        ////
        // 3.  Start the plugin.
        //
        bg.BackgroundGeolocation.start();
      }
    });
  }

  saveData(bg.Location location){
    if(Constants.user() != null){
      print("object1111");

      FirebaseFirestore.instance.collection("location").doc(Constants.uid()).set({
        "latitude": location.coords.latitude,
        "longitude": location.coords.longitude,
      });
      // FirebaseDatabase.instance.ref("location").child(Constants.uid()).set({
      //   "latitude": location.coords.latitude,
      //   "longitude": location.coords.longitude,
      // }).then((value){
      //   print("hogya");
      // }).catchError((error){
      //   print("11111");
      //   print(error);
      // });
    }
  }
  @override
  Widget build(BuildContext context) {

    // Constants.auth().signOut();
    return Consumer<DataProvider>(
      builder: (context, data, child) {

        if(data.userModel != null){
          if(data.userModel!.isUser){
            return DashBoard();
          }else{
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
