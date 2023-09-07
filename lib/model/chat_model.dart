class ChatModel {
  late int time;
  late String lastMessage, to, name, type;
  String? image;
  late bool read, lastRead;

  ChatModel({
    required this.time,
    required this.lastMessage,
    required this.to,
    required this.name,
    required this.image,
    required this.type,
  });

  ChatModel.fromMap(Map<String, dynamic> data){
    time = data["time"];
    lastMessage = data["lastMessage"];
    to = data["to"];
    name = data["name"];
    image = data["image"];
    read = data["read"];
    type = data["type"] ?? "text";
    lastRead = data["lastRead"];
  }

  Map<String, dynamic> toMap(){
    return {
      "time" : time,
      "lastMessage" : lastMessage,
      "to" : to,
      "name" : name,
      "image" : image,
      "read" : false,
      "type": type,
      "lastRead" : false,
    };
  }
}