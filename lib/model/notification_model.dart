class NotificationModel {
  late String id;
  late String text;
  late String type;
  late int time;
  Map<String, dynamic>? metaData;

  NotificationModel(
      {required this.text,
      required this.type,
      required this.time,
      this.metaData});

  NotificationModel.fromMap(Map<String, dynamic> data) {
    id = data["id"];
    text = data["text"];
    type = data["type"];
    time = data["time"];
    metaData = data["metaData"];
  }

  Map<String, dynamic> toMap() {
    return {
      "metaData": metaData,
      "id": id,
      "text": text,
      "type": type,
      "time": time,
    };
  }
}
