import 'dart:io';

class UserModel {
  late String name;
  late String email;
  late String phone;

  String? image;
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

  //bank
  String? bank;
  String? agency;
  String? account;


  bool? isUser;
  //local data
  File? licenseDocumentFile;
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

  });

  UserModel.fromMap(Map<String, dynamic> data){
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
    

    isUser = data["isUser"];
  }

  Map<String, dynamic> toMapUserCreate(){
    return {
      "name" : name,
      "email" : email,
      "phone" : phone,
      "rgCpf" : rgCpf,
      "licenceNumber" : licenceNumber,
      "licenseCategory" : licenseCategory,
      "licenseDocument" : licenseDocument,
      "zipCode" : zipCode,
      "road" : road,
      "isUser" : true,
      "neighbourhood" : neighbourhood,
      "number" : number,
      "complement" : complement,
    };
  }
  Map<String, dynamic> toMapUserUpdate(){
    return {
      "name" : name,
      "email" : email,
      "phone" : phone,
      "rgCpf" : rgCpf,
      "licenceNumber" : licenceNumber,
      "licenseCategory" : licenseCategory,
      "zipCode" : zipCode,
      "road" : road,
      "neighbourhood" : neighbourhood,
      "number" : number,
      "complement" : complement,
    };
  }
}
