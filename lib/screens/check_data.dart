import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/provider/data_provider.dart';
import 'package:projeto/screens/dashboard_screen.dart';
import 'package:projeto/screens/instructor/instructor_dashboard.dart';
import 'package:provider/provider.dart';

class CheckData extends StatelessWidget {
  const CheckData({super.key});

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
