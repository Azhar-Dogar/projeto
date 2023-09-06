import 'dart:io';

import 'package:projeto/model/card_model.dart';

class UserModel {
  late String name;
  late String email;
  late String phone;

  String? image;

  late String uid;
  //license
  late String rgCpf;
  late String licenceNumber;
  late String licenseCategory;
  late String licenseDocument;

  //address
  late String zipCode;
  late String road;
  late String neighbourhood;
  late String number;
  late String complement;

  //card
  List<CardModel> cardsList = [];
  double? credits;


  //bank
  String? bank;
  String? agency;
  String? account;

  late bool isUser;

  //local data
  File? licenseDocumentFile;


  //rate
  String? amount;



  UserModel({

    required this.name,
    required this.email,
    required this.phone,
    required this.rgCpf,
    required this.licenceNumber,
    required this.licenseCategory,
    required this.zipCode,
    required this.road,
    required this.neighbourhood,
    required this.number,
    required this.complement,
    required this.isUser,
    this.bank,
    this.agency,
    this.account,
    this.amount,
    this.credits,
  });

  UserModel.fromMap(Map<String, dynamic> data) {
    uid = data["uid"];
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    image = data["image"];
    rgCpf = data["rgCpf"];
    licenceNumber = data["licenceNumber"];
    licenseCategory = data["licenseCategory"];
    licenseDocument = data["licenseDocument"];
    zipCode = data["zipCode"];
    road = data["road"];
    neighbourhood = data["neighbourhood"];
    number = data["number"];
    complement = data["complement"];

    credits = data["credits"] ?? 0;


    isUser = data["isUser"];

    bank = data["bank"];
    agency = data["agency"];
    account = data["account"];
    amount = data["amount"];
    List cardsList = data["cardsList"] ?? [];
    this.cardsList = cardsList.map((e) => CardModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toMapInstructorCreate() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "rgCpf": rgCpf,
      "licenceNumber": licenceNumber,
      "licenseCategory": licenseCategory,
      "licenseDocument": licenseDocument,
      "zipCode": zipCode,
      "road": road,
      "isUser": isUser,
      "neighbourhood": neighbourhood,
      "number": number,
      "complement": complement,
      "bank": bank,
      "agency": agency,
      "account": account,
      "amount": amount,
      "cardsList": cardsList.map((e) => e.toMap()).toList(),
    };
  }

  Map<String, dynamic> toMapUserCreate() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "phone": phone,
      "rgCpf": rgCpf,
      "licenceNumber": licenceNumber,
      "licenseCategory": licenseCategory,
      "licenseDocument": licenseDocument,
      "zipCode": zipCode,
      "road": road,
      "isUser": isUser,
      "neighbourhood": neighbourhood,
      "number": number,
      "complement": complement,
    };
  }


  Map<String, dynamic> toMapInstructorUpdate() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "rgCpf": rgCpf,
      "licenceNumber": licenceNumber,
      "licenseCategory": licenseCategory,
      "zipCode": zipCode,
      "road": road,
      "isUser": isUser,
      "neighbourhood": neighbourhood,
      "number": number,
      "complement": complement,
      "bank": bank,
      "agency": agency,
      "account": account,
      "amount": amount,
    };
  }
  Map<String, dynamic> toMapUserUpdate() {
    return {
      "name": name,
      "email": email,
      "phone": phone,
      "rgCpf": rgCpf,
      "licenceNumber": licenceNumber,
      "licenseCategory": licenseCategory,
      "zipCode": zipCode,
      "road": road,
      "neighbourhood": neighbourhood,
      "number": number,
      "complement": complement,
    };
  }
}
