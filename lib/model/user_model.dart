import 'dart:io';

class UserModel {
  late String name;
  late String email;
  late String phone;

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
  late String bank;
  late String agency;
  late String account;

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
    required this.bank,
    required this.agency,
    required this.account,
  });

  UserModel.fromMap(Map<String, dynamic> data){
    name = data["name"];
    email = data["email"];
    phone = data["phone"];
    rgCpf = data["rgCpf"];
    licenceNumber = data["licenceNumber"];
    licenseCategory = data["licenseCategory"];
    licenseDocument = data["licenseDocument"];
    zipCode = data["zipCode"];
    road = data["road"];
    neighbourhood = data["neighbourhood"];
    number = data["number"];
    complement = data["complement"];
    bank = data["bank"];
    agency = data["agency"];
    account = data["account"];
  }

  Map<String, dynamic> toMap(){
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
      "bank" : bank,
      "agency" : agency,
      "account" : account,
    };
  }
}
