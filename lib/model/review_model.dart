class ReviewModel {
  late String userID;
  late DateTime date;
  late String time;
  late double rating;
  late String opinion;

  ReviewModel(
      {required this.userID,
      required this.date,
      required this.time,
      required this.rating,
      required this.opinion});

  Map<String, dynamic> toMap() {
    return {
      "userID": userID,
      "date": date.millisecondsSinceEpoch,
      "time": time,
      "rating": rating,
      "opinion": opinion,
    };
  }

  ReviewModel.fromMap(Map<String, dynamic> data) {
    userID = data["userID"];
    date = DateTime.fromMillisecondsSinceEpoch(data["date"]);
    time = data["time"];
    rating = data["rating"];
    opinion = data["opinion"];
  }
}
