import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import 'colors.dart';

class Constants {
  static List<BoxShadow> shadow() {
    return [
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

  static List<int> years() {


    int year = DateTime
        .now()
        .year - 7;
    List<int> list = [];
    for (int i = 0; i < 8; i++) {
      list.add(year + i);
    }
    return list;
  }




  static List<String> drivingLicenseCategoriesPortugal = [
    'Categoria A1 - Motociclos até 125cc',
    'Categoria A2 - Motociclos até 35kW',
    'Categoria A - Motociclos de cilindrada ilimitada',
    'Categoria B - Automóveis ligeiros (ligeiros de passageiros e ligeiros mistos)',
    'Categoria B1 - Triciclos e quadriciclos ligeiros',
    'Categoria BE - Automóveis ligeiros com reboque',
    'Categoria C1 - Veículos de mercadorias até 7.5 toneladas',
    'Categoria C - Veículos de mercadorias acima de 7.5 toneladas',
    'Categoria D1 - Transporte coletivo de crianças até 16 lugares',
    'Categoria D - Transporte coletivo de passageiros acima de 16 lugares',
    'Categoria CE - Veículos de mercadorias com reboque',
    'Categoria DE - Veículos de mercadorias com reboque',
    'Categoria D1E - Transporte coletivo de crianças com reboque',
    'Categoria DE - Transporte coletivo de passageiros com reboque',
    'Categoria G - Tratores agrícolas',
  ];

  static List<String> banksInPortugal = [
    "Banco do Brasil",
    "Caixa Econômica Federal",
    "Banco Bradesco",
    "Itaú Unibanco",
    "Santander Brasil",
    "Banco BTG Pactual",
    "Banco Votorantim",
    "Banco Safra",
    "Banco Original",
    "Banco Inter",
    "Central Bank of Brazil",
    "Nubank",
    "Daycoval",
    "Banco do Nordeste",
    "Citibank",
  ];


  static List<String> portugueseVehicleBrands = [
    "Renault",
    "Peugeot",
    "Citroën",
    "Volkswagen",
    "Mercedes-Benz",
    "BMW",
    "Audi",
    "Ford",
    "Fiat",
    "Opel",
    "Nissan",
    "Toyota",
    "Hyundai",
    "Kia",
    "Mitsubishi",
    "Mazda",
    "Volvo",
    "Skoda",
    "Seat",
    "Jeep",
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


  static FirebaseDatabase database =
  FirebaseDatabase(app: null,databaseURL: "https://mazzi-b3641-default-rtdb.europe-west1.firebasedatabase.app/");
  static var databaseReference = database.reference();
  //coleections
  static var firestore = FirebaseFirestore.instance;
  static var users = firestore.collection("users");
  static var reviews = firestore.collection("ratings");
  static var messages = firestore.collection("messages");
  static var cars = firestore.collection("cars");
  static var bookings = firestore.collection("bookings");

}