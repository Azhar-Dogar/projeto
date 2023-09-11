import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/constants.dart';
import 'package:projeto/model/availability_model.dart';
import 'package:projeto/model/booking.dart';
import 'package:projeto/model/car_model.dart';
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

  callFunctions() {
    getProfile();
    callOthers();
  }

  callOthers() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      if (userModel == null) {
        callOthers();
      } else {
        getCars();
        getUsers();
        getMessages();
        getAvailability();
        getBookings();
        getReviews();
      }
    });
  }

  reset() {
    userModel = null;
    cars = [];
    users = [];
    chats = [];
    bookings = [];
    reviews = [];
  }

  cancelStreams() {
    profileStream?.cancel();
    carsStream?.cancel();
    usersStream?.cancel();
    chatsStream?.cancel();
    bookingStream?.cancel();
    reviewStream?.cancel();
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? bookingStream;

  List<BookingModel> bookings = [];

  getBookings() {
    bookingStream = Constants.bookings
        .where("userID", isEqualTo: Constants.uid())
        .snapshots()
        .listen((snapshot) {
      var docs = snapshot.docs.where((element) => element.exists).toList();
      bookings = List.generate(
          docs.length, (index) => BookingModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  StreamSubscription<DocumentSnapshot<Map<String, dynamic>>>? profileStream;

  UserModel? userModel;

  getProfile() {
    profileStream = Constants.users.doc(Constants.uid()).snapshots().listen(
      (snapshot) {
        if (snapshot.exists) {
          userModel = UserModel.fromMap(snapshot.data()!);
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

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? reviewStream;

  List<ReviewModel> reviews = [];

  getReviews() {
    var query = Constants.reviews.where("userID", isEqualTo: Constants.uid());

    if (!userModel!.isUser) {
      query =
          Constants.reviews.where("instructorID", isEqualTo: Constants.uid());
    }

    reviewStream = query.snapshots().listen((snapshot) {
      var docs = snapshot.docs.where((element) => element.exists).toList();
      reviews = List.generate(
          docs.length, (index) => ReviewModel.fromMap(docs[index].data()));
      notifyListeners();
    });
  }

  UserModel? getUserById(String id) {
    UserModel? userModel;

    userModel = users.where((element) => element.uid == id).firstOrNull;

    return userModel;
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
                    breakEnd: TextEditingController())
                .toMap(),
          );
    }
  }
}
