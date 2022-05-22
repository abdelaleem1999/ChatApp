import 'package:bonus/const/shared_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'messageContainer.dart';

class MessageStreamBuider extends StatefulWidget {
  MessageStreamBuider({
    this.friendEmail
});
  final String? friendEmail;

  @override
  _MessageStreamBuiderState createState() => _MessageStreamBuiderState();
}

class _MessageStreamBuiderState extends State<MessageStreamBuider> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("users").doc(SharedHelper.getEmail).collection("messages").doc(widget.friendEmail).collection("chats").orderBy("date",descending: true).snapshots(),
      //FirebaseFirestore.instance.collection('message').orderBy('time').snapshots(),
      builder:(context,AsyncSnapshot snapshot) {
        List<MessageContainer> MessageWidgets=[];
        if(!snapshot.hasData ){
          return Center(child: Text("NO MESSAGE"));

        }else{
          final messages=snapshot.data!.docs;
          for(var message in messages ){
            final messageText=message.get('message');
            print('111111111122222222222222222222222222222222');
            print('111111111122222222222222222222222222222222');
            print('4444444444444444444444444455555555555555');
            final messageSender=message.get('sender');
            final messageWidget =MessageContainer(
              message:messageText ,
              sender:messageSender ,
              isMe: SharedHelper.getEmail==messageSender,

            );
            MessageWidgets.add(messageWidget);
            print('111111111111111111111111111111');
            print(SharedHelper.getEmail) ;
            print('222222222222222222222222');

          }
        }
        return Expanded(
          child: ListView(
              children:
              MessageWidgets

          ),
        );

      },

    );
  }
}
// MessageContainer(
// message:messageText ,
// sender:messageSender ,
// isMe: SharedHelper.getEmail==messageSender,
//
// );