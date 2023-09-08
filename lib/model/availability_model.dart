import 'package:flutter/material.dart';

class AvailabilityModel {
  late String day;

  var startTime = TextEditingController();
  var endTime = TextEditingController();
  var breakStart = TextEditingController();
  var breakEnd = TextEditingController();

  AvailabilityModel({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.breakStart,
    required this.breakEnd,
  });

  AvailabilityModel.fromMap(Map<String, dynamic> data){
    day = data["day"];
    startTime.text = data["startTime"];
    endTime.text = data["endTime"];
    breakStart.text = data["breakStart"];
    breakEnd.text = data["breakEnd"];
  }
  Map<String, dynamic> toMap(){
    return {
      "day" : day,
      "startTime" : startTime.text,
      "endTime" : endTime.text,
      "breakStart" : breakStart.text,
      "breakEnd" : breakEnd.text,
    };
  }
}
