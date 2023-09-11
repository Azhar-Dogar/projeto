class BookingModel {
  late String id;
  late String instructorID;
  late String userID;
  late DateTime date;
  late String time;
  late int totalClasses;
  late double amount;
  late String status;
  late bool ratingDone;

  BookingModel({
    required this.id,
    required this.date,
    required this.amount,
    required this.instructorID,
    required this.time,
    required this.totalClasses,
    required this.userID,
    this.status = "pending",
    this.ratingDone = false,
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
      "ratingDone": ratingDone,
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
    ratingDone = data["ratingDone"] ?? false;
  }
}
