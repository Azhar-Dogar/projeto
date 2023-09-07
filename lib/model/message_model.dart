


class MessageModel {
  late String senderId;
  late String message;

  late String type;
  String? link;
  late bool read = false;
  late int time;
  late String id;

  MessageModel({
    required this.senderId,
    required this.message,
    required this.type,
    required this.link,
    required this.time,
  });

  MessageModel.fromMap(Map<String, dynamic> data){
    senderId = data["senderId"];
    message = data["message"];
    type = data["type"];
    link = data["link"];
    read = data["read"];
    time = data["time"];
    id = data["id"];
  }

  Map<String, dynamic> toMap(){
    return {
      "senderId" : senderId,
      "message" : message ,
      "type" : type,
      "link" : link,
      "read" : false,
      "time" : time,
      "id" : id,
    };
  }
}
