import 'package:bonus/const/shared_helper.dart';
import 'package:bonus/views/User_chat/cubits/firebase_realtime_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bonus/views/messageUnread/cubits/Cubits.dart';
import 'package:bonus/views/tapBar/cubit.dart';

import '../../widgets/userComponent.dart';
import '../User_chat/view.dart';

class MessageUnReadView extends StatefulWidget {

  @override
  _MessageUnReadViewState createState() => _MessageUnReadViewState();
}

class _MessageUnReadViewState extends State<MessageUnReadView> {
  var xxx;
  // num m=0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').doc(SharedHelper.getEmail).collection('messages').snapshots(),

        builder:(context,AsyncSnapshot snapshot)  {


          if(snapshot.hasData){
          if(snapshot.data.docs.length<1){
            return Center(child: const Text('No Message Unread'));

          }else{

            return ListView.builder(

                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  // m=0;
                  var friendId = snapshot.data.docs[index].id;
                  var lastMsg = snapshot.data.docs[index]['last_msg'];



                  // var m =  FirebaseFirestore.instance.collection('users').get();
              // for(var i=0; i<=index; i++){
              //   var AllMessageUnread=snapshot.data.docs[i]['seen'];
              //
              //   m=m+AllMessageUnread;
              //
              // }
              //     ConterController.of(context)..conterMethod(m.toInt());
              //
              //     SharedHelper.setConter(m.toInt());
              // print('qqqqqqqqqqqqqqqqqqqqqqqqwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
              // print('qqqqqqqqqqqqqqqqqqqqqqqqwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
              // print(SharedHelper.getConter.toString());
              //     print('qqqqqqqqqqqqqqqqqqqqqqqqwwwwwwwwwwwwwwwwwwwwwwwwwwwww');
              //     print('qqqqqqqqqqqqqqqqqqqqqqqqwwwwwwwwwwwwwwwwwwwwwwwwwwwww');

// image From Firebase FireStore and Storage
//https://firebasestorage.googleapis.com/v0/b/chatss-97012.appspot.com/o/photo%2F522445494?alt=media&token=010ad33d-ddbd-49b2-beba-e82710dbfe77
                  return  UserComponent(
                    numberOgMessageUnread: snapshot.data.docs.length,
                    seen: snapshot.data.docs[index]['seen'],
                    ISLocation: snapshot.data.docs[index]['type']
                   ,
                    IsString: lastMsg.contains('https')==false,
                    image:'assets/red-mailbox-with-yellow-letter-in-envelope-mail-and-message-cartoon-flat-illustration-work-post-office-communication-between-people-400-199160611.jpg',
                    name: snapshot.data.docs[index]['name'],
                    IsMe: snapshot.data.docs[index]['sender']==SharedHelper.getEmail,
                    message: lastMsg,
                    numberOfMessage:'' ,
                    time: DateFormat('hh:mm a').
                    format(DateTime.fromMillisecondsSinceEpoch(
                      snapshot.data.docs[index]['date'].seconds*1000
                    )),
                    Navigator: UserChat(
                      Token:snapshot.data.docs[index]['token'] ,
                      friendRecive: friendId,
                      friendName: snapshot.data.docs[index]['name'],
                      status:index,
                      // status: FirebaseFirestore.instance.,

                    ),
                  );
                }



            );

          }
        }
          return const Center(child: CircularProgressIndicator(),);

        }, );
  }
}
