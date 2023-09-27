import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/provider/dashboard_provider.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard_screen.dart';
import 'package:projeto/screens/instructor/instructor_dashboard.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
//     as bg;
import 'package:utility_extensions/utility_extensions.dart';

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

    Geolocator.getPositionStream().listen((event) {

      saveData(event);

    });

    // bg.BackgroundGeolocation.onLocation((bg.Location location) {
    //   saveData(location);
    // });

    // bg.BackgroundGeolocation.ready(bg.Config(
    //         desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
    //         distanceFilter: 10.0,
    //         stopOnTerminate: false,
    //         startOnBoot: true,
    //         debug: true,
    //         logLevel: bg.Config.LOG_LEVEL_VERBOSE))
    //     .then((bg.State state) {
    //   if (!state.enabled) {
    //     bg.BackgroundGeolocation.start();
    //   }
    // });
  }

  saveData(Position location) async {
    if (Constants.user() != null) {
      await Constants.databaseReference
          .child("location")
          .child(Constants.uid())
          .set({
        "latitude": location.latitude,
        "longitude": location.longitude,
      });
    }
  }

  late DataProvider provider;

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(milliseconds: 10),(){
      context.read<DashboardProvider>().selectedIndex = 2;
    });
    // Constants.auth().signOut();
    return Consumer<DataProvider>(builder: (context, data, child) {
      provider = data;
      if (data.userModel != null) {

        if (data.userModel!.isUser) {
          if (provider.latitude == null) {
            determinePosition();
            return loading();
          }
          return DashBoard();
        } else {
          listenLocation();
          return InstructorDashboard();
        }
      }

      return loading();
    });
  }

  Widget loading() {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showError('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (permission == LocationPermission.deniedForever) {
          showError('Location permissions are denied');
        }
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showError('Location permissions are permanently denied, we cannot request permissions. Turn these on from settings');
    }

    var position = await Geolocator.getCurrentPosition();

    provider.longitude = position.longitude;
    provider.latitude = position.latitude;
  }

  showError(String message) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            content: Text(
              message,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop(rootNavigator: true);
                  determinePosition();
                },
                child: Text("Retry"),
              ),
            ],
          );
        });
  }
}
