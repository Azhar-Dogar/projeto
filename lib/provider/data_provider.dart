import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/availability_model.dart';
import 'package:projeto/model/booking_model.dart';
import 'package:projeto/model/car_model.dart';
import 'package:projeto/model/notification_model.dart';
import 'package:projeto/model/review_model.dart';
import 'package:projeto/model/user_model.dart';
import '../model/chat_model.dart';

class DataProvider with ChangeNotifier {
  DataProvider() {
    authStream();
  }

  authStream() {
    Constants.auth().userChanges().listen((user) {
      if (user == null) {
        cancelStreams();
        reset();
      } else {
        callFunctions();
      }
    });
  }

  double? _latitude;
  double? _longitude;

  double? get latitude => _latitude;

  set latitude(double? value) {
    _latitude = value;
    notifyListeners();
  }

  double? get longitude => _longitude;

  set longitude(double? value) {
    _longitude = value;
    notifyListeners();
  }

  callFunctions() {
    getProfile();
    callOthers();
  }

  callOthers() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (userModel == null || _latitude == null) {
        callOthers();
      } else {
        getCars();
        getUsers();
        getMessages();
        getAvailability();
        getNotifications();
        getBookings();
        getLocations();
      }
    });
  }

  reset() {
    userModel = null;
    cars = [];
    users = [];
    chats = [];
    bookings = [];
    notifications = [];

    nearbyInstructors = [];
    instructorsLocation = [];
  }

  cancelStreams() {
    locationStream?.cancel();
    profileStream?.cancel();
    carsStream?.cancel();
    usersStream?.cancel();
    chatsStream?.cancel();
    bookingStream?.cancel();
    notificationStream?.cancel();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? bookingStream;

  List<BookingModel> bookings = [];

  getBookings() {
    print("objadsfcdsfect");
    var query = Constants.bookings.where("userID", isEqualTo: Constants.uid());
    if (!userModel!.isUser) {
      query =
          Constants.bookings.where("instructorID", isEqualTo: Constants.uid());
    }
    bookingStream = query.snapshots().listen((snapshot) {
      var docs = snapshot.docs.where((element) => element.exists).toList();
      print(docs.length);
      bookings = List.generate(
          docs.length, (index) => BookingModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? profileStream;

  UserModel? userModel;

  double totalRating = 0;

  getProfile() {
    profileStream = Constants.users.doc(Constants.uid()).snapshots().listen(
      (snapshot) {
        if (snapshot.exists) {
          userModel = UserModel.fromMap(snapshot.data()!);
          double totalRating = 0;
          for (var r in userModel!.reviews) {
            totalRating += r.totalR;
          }
          if (userModel!.reviews.isEmpty) {
            totalRating = 5;
          }  else{
            totalRating = (totalRating / userModel!.reviews.length);
            this.totalRating = totalRating;
          }
        } else {
          userModel = null;
        }
        notifyListeners();
      },
    );
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? carsStream;

  List<CarModel> cars = [];

  getCars() {
    var query = Constants.cars.where("uid", isEqualTo: Constants.uid());

    if (userModel!.isUser) {
      query = Constants.cars;
    }
    carsStream = query.snapshots().listen((snapshot) {
      var docs = snapshot.docs.where((element) => element.exists).toList();
      cars = List.generate(
          docs.length, (index) => CarModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? usersStream;

  List<UserModel> users = [];

  getUsers() {
    usersStream = Constants.users
        .where("isUser", isEqualTo: !userModel!.isUser)
        .snapshots()
        .listen((snapshot) {
      var docs = snapshot.docs.where((element) => element.exists).toList();
      users = List.generate(
          docs.length, (index) => UserModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  List<ReviewModel> reviews = [];

  UserModel? getUserById(String id) {
    UserModel? userModel;

    userModel = users.where((element) => element.uid == id).firstOrNull;

    return userModel;
  }

  BookingModel? getbookingById(String id) {
    BookingModel? bookingModel;

    bookingModel = bookings.where((element) => element.id == id).firstOrNull;

    return bookingModel;
  }

  CarModel? getCarById(String id) {
    CarModel? carModel;
    carModel = cars
        .where((element) => element.uid == id && element.isPrimary)
        .firstOrNull;

    return carModel;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? chatsStream;

  List<ChatModel> chats = [];
  int messageState = 0;

  getMessages() {
    chatsStream = Constants.messages
        .doc(Constants.uid())
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots()
        .listen((snapshots) {
      var docs = snapshots.docs.where((element) => element.exists).toList();
      chats = List.generate(
          docs.length, (index) => ChatModel.fromMap(docs[index].data()));
      messageState = 1;
      notifyListeners();
    });
    chatsStream?.onError((error) {
      messageState = 2;
      notifyListeners();
    });
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? availabilityStream;

  List<AvailabilityModel> availability = [];

  getAvailability() {
    if (userModel!.isUser) return;
    availabilityStream = Constants.users
        .doc(Constants.uid())
        .collection("availability")
        .snapshots()
        .listen((snapshots) {
      var docs = snapshots.docs.where((element) => element.exists).toList();
      if (docs.isEmpty) {
        setAvailability();
      } else {
        availability = List.generate(docs.length,
            (index) => AvailabilityModel.fromMap(docs[index].data()));
        notifyListeners();
      }
    });
  }

  setAvailability() {
    var days = [
      "Segundas-feiras",
      "Terças-feiras",
      "Quartas-feiras",
      "Quintas-feiras",
      "Sextas-feiras",
      "Sábados",
      "Domingos",
    ];

    for (int i = 0; i < days.length; i++) {
      Constants.users
          .doc(Constants.uid())
          .collection("availability")
          .doc("${i + 1}")
          .set(
            AvailabilityModel(
              day: days[i],
              startTime: TextEditingController(),
              endTime: TextEditingController(),
              breakStart: TextEditingController(),
              breakEnd: TextEditingController(),
            ).toMap(),
          );
    }
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? notificationStream;

  List<NotificationModel> notifications = [];

  getNotifications() {
    notificationStream = Constants.users
        .doc(Constants.uid())
        .collection("notifications")
        .snapshots()
        .listen((snapshots) {
      var docs = snapshots.docs.where((element) => element.exists).toList();
      notifications = List.generate(docs.length,
          (index) => NotificationModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  List<UserModel> nearbyInstructors = [];
  List<Map<String, dynamic>> instructorsLocation = [];

  StreamSubscription<DatabaseEvent>? locationStream;

  bool markersUpdate = false;
  getLocations() {
    locationStream = Constants.databaseReference.child("location").onValue.listen((event) {
      var children = event.snapshot.children.where((element) => element.exists);
      instructorsLocation = [];
      for (var child in children) {
        var c = child.value as Map<Object?, Object?>;
        var distance = Geolocator.distanceBetween(
            _latitude!, _longitude!, c["latitude"] as double, c["longitude"] as double);

        if(distance < 10000 || true){
          var user = users.where((element) => element.uid == child.key);
          if(user.isNotEmpty){
            nearbyInstructors.add(user.first);
            instructorsLocation.add({
              "user" : child.key,
              "latitude" : c["latitude"],
              "longitude" : c["longitude"],
            });
          }
        }
      }
      markersUpdate = true;
      notifyListeners();
    });
  }
}
