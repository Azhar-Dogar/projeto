class BookingModel {
  late String id;
  late String instructorID;
  late String userID;
  late DateTime date;
  late String time;
  late int totalClasses;
  late double amount;
  late String status;
  late bool studentRating;
  late bool instructorRating;

  BookingModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.instructorID,
    required this.time,
    required this.totalClasses,
    required this.userID,
    this.status = "pending",
    this.studentRating = false,
    this.instructorRating = false,

  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "instructorID": instructorID,
      "userID": userID,
      "date": date.millisecondsSinceEpoch,
      "time": time,
      "totalClasses": totalClasses,
      "amount": amount,
      "status": status,
      "studentRating": studentRating,
      "instructorRating": instructorRating,

    };
  }

  BookingModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    instructorID = data["instructorID"];
    userID = data["userID"];
    date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    time = data["time"];
    totalClasses = data["totalClasses"];
    amount = data["amount"];
    status = data["status"];
    studentRating = data["studentRating"] ?? false;
    instructorRating = data["instructorRating"] ?? false;

  }
}
