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


  late bool isUser;
  //local data
  File? licenseDocumentFile;




  //vehicle

  String? brand;
  String? year;
  String? vehicle;

  //rate
  String? amount;


  File? vehiclePhotoFile;
  File? vehicleDocumentFile;
  File? vehicleLicenseFile;
  File? vehicleInsuranceFile;
  File? leaseAgreementFile;


  String? vehiclePhoto;
  String? vehicleDocument;
  String? vehicleLicense;
  String? vehicleInsurance;
  String? leaseAgreement;

  String? carType;

  bool? isDualCommand;


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

    this.brand,
    this.year,
    this.vehicle,

    this.amount,

    this.carType,
    this.isDualCommand,


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

    bank = data["bank"];
    agency = data["agency"];
    account = data["account"];
    brand = data["brand"];
    year = data["year"];
    vehicle = data["vehicle"];
    amount = data["amount"];
    carType = data["carType"];
    isDualCommand = data["isDualCommand"];
    vehiclePhoto = data["vehiclePhoto"];
    vehicleDocument = data["vehicleDocument"];
    vehicleLicense = data["vehicleLicense"];
    vehicleInsurance = data["vehicleInsurance"];
    leaseAgreement = data["leaseAgreement"];
  }

  Map<String, dynamic> toMapInstructorCreate(){
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
      "isUser" : isUser,
      "neighbourhood" : neighbourhood,
      "number" : number,
      "complement" : complement,
      "bank" : bank,
      "agency" : agency,
      "account" : account,
      "brand" : brand,
      "year" : year,
      "vehicle" : vehicle,
      "amount" : amount,
      "carType" : carType,
      "isDualCommand" : isDualCommand,
      "vehiclePhoto" : vehiclePhoto,
      "vehicleDocument" : vehicleDocument,
      "vehicleLicense" : vehicleLicense,
      "vehicleInsurance" : vehicleInsurance,
      "leaseAgreement" : leaseAgreement,
    };
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
      "isUser" : isUser,
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
