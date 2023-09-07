import 'dart:io';

class CarModel {
  late String id;
  late String uid;
  late String brand;
  late String year;
  late String vehicle;

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

  bool? vehiclePhotoApproved;
  bool? vehicleDocumentApproved;
  bool? vehicleLicenseApproved;
  bool? vehicleInsuranceApproved;
  bool? leaseAgreementApproved;

  String carType = "own";
  var isDualCommand = false;

  bool isPrimary = false;
  CarModel({
     required this.brand,
    required this.year,
    required this.vehicle,
    required this.carType,
    required this.isDualCommand,
    this.vehiclePhoto,
    this.vehicleDocument,
    this.vehicleLicense,
    this.vehicleInsurance,
    required this.isPrimary,
  });

  CarModel.fromMap(Map<String, dynamic> data){
    print(data);
    id = data["id"];
    uid = data["uid"];
    brand = data["brand"];
    year = data["year"];
    vehicle = data["vehicle"];
    vehiclePhoto = data["vehiclePhoto"];
    vehicleDocument = data["vehicleDocument"];
    vehicleLicense = data["vehicleLicense"];
    vehicleInsurance = data["vehicleInsurance"];
    leaseAgreement = data["leaseAgreement"];
    carType = data["carType"];
    isDualCommand = data["isDualCommand"];
    isPrimary = data["isPrimary"];



    vehiclePhotoApproved = data["vehiclePhotoApproved"];
    vehicleDocumentApproved = data["vehicleDocumentApproved"];
    vehicleLicenseApproved = data["vehicleLicenseApproved"];
    vehicleInsuranceApproved = data["vehicleInsuranceApproved"];
    leaseAgreementApproved = data["leaseAgreementApproved"];

  }

  Map<String, dynamic> toMap(){
    return {
      "id" : id,
      "uid" : uid,
      "brand" : brand,
      "year" : year,
      "vehicle" : vehicle,
      "isPrimary" : isPrimary,
      "vehiclePhoto" : vehiclePhoto,
      "vehicleDocument" : vehicleDocument,
      "vehicleLicense" : vehicleLicense,
      "vehicleInsurance" : vehicleInsurance,
      "leaseAgreement" : leaseAgreement,
      "carType" : carType,
      "isDualCommand" : isDualCommand,
    };
  }
}
