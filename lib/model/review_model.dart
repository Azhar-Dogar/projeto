class ReviewModel {
  late String id;
  late String userID;
  late String instructorID;
  late DateTime date;
  late String time;
  late double instructorR;
  late double vehicleR;
  late double courseR;
  late double totalR;
  late String opinion;

  ReviewModel(
      {
        required this.id,
        required this.userID,
      required this.date,
      required this.time,
      required this.instructorR,
      required this.vehicleR,
      required this.courseR,
        required this.totalR,
        required this.opinion,
      required this.instructorID});

  Map<String, dynamic> toMap() {
    return {
      "id" : id,
      "userID": userID,
      "instructorID": instructorID,
      "date": date.millisecondsSinceEpoch,
      "time": time,
      "instructorR": instructorR,
      "vehicleR": vehicleR,
      "courseR": courseR,
      "totalR": totalR,
      "opinion": opinion,
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
    totalR = data["totalR"];
    opinion = data["opinion"];
  }
}
