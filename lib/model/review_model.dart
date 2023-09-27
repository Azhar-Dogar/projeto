class ReviewModel {
  String? id;
  String? userID;
  String? instructorID;
  late DateTime date;
  late String time;
  double? instructorR;
  double? vehicleR;
  double? courseR;
  late double totalR;
  late String opinion;
  late String bookingID;

  ReviewModel(
      {this.id,
      this.userID,
      required this.date,
      required this.time,
      this.instructorR,
      this.vehicleR,
      this.courseR,
      required this.totalR,
      required this.opinion,
      this.instructorID,
        required this.bookingID,
      });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "userID": userID,
      "instructorID": instructorID,
      "date": date.millisecondsSinceEpoch,
      "time": time,
      "instructorR": instructorR,
      "vehicleR": vehicleR,
      "courseR": courseR,
      "totalR": totalR,
      "opinion": opinion,
      "bookingID": bookingID,

    };
  }

  ReviewModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    userID = data["userID"];
    instructorID = data["instructorID"];
    date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    time = data["time"];
    instructorR = data["instructorR"];
    courseR = data["courseR"];
    vehicleR = data["vehicleR"];
    totalR = data["totalR"].toDouble();
    opinion = data["opinion"];
    bookingID = data["bookingID"] ?? "";
  }

}
