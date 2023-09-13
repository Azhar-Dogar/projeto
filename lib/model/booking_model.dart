class BookingModel {
  late String id;
  late String instructorID;
  late String userID;
  late DateTime date;
  late int totalClasses;
  late double amount;
  late String status;
  late bool studentRating;
  late bool instructorRating;
  late String location;

  BookingModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.instructorID,
    required this.totalClasses,
    required this.userID,
    this.status = "pending",
    this.studentRating = false,
    this.instructorRating = false,
    required this.location,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "instructorID": instructorID,
      "userID": userID,
      "date": date.millisecondsSinceEpoch,
      "totalClasses": totalClasses,
      "amount": amount,
      "status": status,
      "studentRating": studentRating,
      "instructorRating": instructorRating,
      "location" : location,
    };
  }

  BookingModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    instructorID = data["instructorID"];
    userID = data["userID"];
    date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    totalClasses = data["totalClasses"];
    amount = data["amount"];
    status = data["status"];
    studentRating = data["studentRating"] ?? false;
    instructorRating = data["instructorRating"] ?? false;
    location = data["location"] ?? "";
  }
}
