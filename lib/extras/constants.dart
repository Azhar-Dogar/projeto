import 'package:cloud_firestore/cloud_firestore.dart';
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
    'Banco Comercial Português (BCP)',
    'Caixa Geral de Depósitos (CGD)',
    'Novo Banco',
    'Banco Santander Totta',
    'Banco BPI',
    'Crédito Agrícola',
    'Banco Popular Portugal',
    'Bankinter Portugal',
    'Montepio Geral',
    'EuroBic',
    'Caixa Económica Montepio Geral',
    'Banif - Banco Internacional do Funchal (Note: Banif was dissolved in 2015, and its assets were transferred to Santander Totta and Oitante)',
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

  //coleections
  static var firestore = FirebaseFirestore.instance;
  static var users = firestore.collection("users");
  static var messages = firestore.collection("messages");
  static var cars = firestore.collection("cars");
}