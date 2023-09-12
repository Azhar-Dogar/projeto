import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto/extras/functions.dart';
import 'package:projeto/model/notification_model.dart';

import '../extras/constants.dart';
import '../model/chat_model.dart';
import '../model/message_model.dart';
import '../model/user_model.dart';

class ChatProvider with ChangeNotifier {
  UserModel sender, receiver;

  ChatProvider({required this.sender, required this.receiver}) {
    reference = Constants.messages
        .doc(sender.uid)
        .collection("chats")
        .doc(receiver.uid)
        .collection("messages");
    getChats();
  }

  var controller = ScrollController();
  late CollectionReference<Map<String, dynamic>> reference;
  var messageController = TextEditingController();


  Future<void> sendMessage(String type, String? mediaLink) async {
    var text = messageController.text;
    messageController.text = "";
    var time = DateTime.now();
    var forSenderChat = ChatModel(
      time: time.millisecondsSinceEpoch,
      lastMessage: text,
      to: receiver.uid,
      name:
          receiver.name,
      image: receiver.image,
      type: type,
    );

    var forReceiverChat = ChatModel(
      time: time.millisecondsSinceEpoch,

      lastMessage: text,
      to: sender.uid,
      name: sender.name,
      image: sender.image,
      type: type,
    );

    var message = MessageModel(
      senderId: sender.uid,
      message: text,
      type: type,
      link: mediaLink,
      time: time.millisecondsSinceEpoch,
    );

    var senderDoc = Constants.messages
        .doc(sender.uid)
        .collection("chats")
        .doc(receiver.uid);
    var receiverDoc = Constants.messages
        .doc(receiver.uid)
        .collection("chats")
        .doc(sender.uid);

    var senderMessageDoc = senderDoc.collection("messages").doc();

    var receiverMessageDoc =
        receiverDoc.collection("messages").doc(senderMessageDoc.id);

    message.id = senderMessageDoc.id;

    await senderDoc.set(
      forSenderChat.toMap(),
    );
    await receiverDoc.set(
      forReceiverChat.toMap(),
    );


    var notification = NotificationModel(text: "${sender.name} enviou uma mensagem.", type: "text", time: DateTime.now().millisecondsSinceEpoch);
    Functions.sendNotification(notification, receiver.uid);
    await senderMessageDoc.set(message.toMap());
    await receiverMessageDoc.set(message.toMap());

    mediaLink = null;
  }

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? chatStream;
  int state = 0;
  List<MessageModel> messages = [];

  getChats() {
    chatStream = reference
        .orderBy("time", descending: true)
        .snapshots()
        .listen((snapshots) {
      var docs = snapshots.docs.where((element) => element.exists).toList();
      messages = List.generate(
        docs.length,
        (index) => MessageModel.fromMap(
          docs[index].data(),
        ),
      );

      var unReadMessages = messages
          .where(
              (element) => element.senderId != Constants.uid() && !element.read)
          .toList();


      print(unReadMessages.length);
      for(var msg in unReadMessages){
        Constants.messages
            .doc(receiver.uid)
            .collection("chats")
            .doc(sender.uid )
            .collection("messages").doc(msg.id).update({
          "read" : true,
        });
        reference..doc(msg.id).update({
          "read" : true,
        });
      }

      controller.animateTo(0, duration: Duration(seconds: 1), curve: ElasticInCurve());
      state = 1;
      notifyListeners();
    });

    chatStream?.onError((error) {
      state = 2;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    chatStream?.cancel();
    super.dispose();
  }
}
