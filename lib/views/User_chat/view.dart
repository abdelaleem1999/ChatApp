import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bonus/const/shared_helper.dart';
import 'package:bonus/views/User_chat/component/bottomBar.dart';
import 'package:bonus/views/User_chat/cubits/cubits.dart';
import 'package:bonus/views/login/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../homescreen/states/states.dart';
import 'component/messageContainer.dart';
import 'component/messgeStreamBuilder.dart';
import 'package:community_material_icon/community_material_icon.dart';

class UserChat extends StatefulWidget {
  final String? friendRecive;
  final String? friendName;
  final String? testName;
  late final int? status;
  final String? Token;


  UserChat({
    this.friendRecive,
    this.friendName,
    this.testName,
    this.status,
    this.Token,
  });

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> with WidgetsBindingObserver {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController? message = TextEditingController();
  late File file;
  late Timer timer;


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      updateUser("online");
      print('0000000000000000000000000000000000');
    } else {
      updateUser("offline");
      print('11111111111111111111111111111111111');
    }
  }

  updateUser(status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(SharedHelper.getEmail)
        .update({'status': status});

  }
  updateMessageUnread()async{
    var xz= await FirebaseFirestore.instance.collection('users').doc(SharedHelper.getEmail)
        .collection('messages')
        .doc(widget.friendRecive!).collection('chats').get();
    for (var doc in xz.docs) {
      await doc.reference.update({
        'seen': 0,
      });
    }
    var z=  await FirebaseFirestore.instance
        .collection('users')
        .doc(SharedHelper.getEmail)
        .collection('messages')
        .doc(widget.friendRecive!).update({'seen':0});

    }

  @override
  void initState() {
    updateMessageUnread();
    // timer= Timer.periodic(Duration(seconds: 10), (Timer t) => updateMessageUnread());









    // print(widget.status!);
    // print("1234567890111111111");
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    // print('222222222222222222222222222222222222');
  }
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,

      appBar: AppBar(
        leadingWidth: 22,
        title: Row(
          children: [
            Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), // Image border
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(22), // Image radius
                    child: Image.asset(
                        'assets/4d7297dad94265c0acbc3b677d418935.jpg',
                        fit: BoxFit.cover),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.friendName!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return CircularProgressIndicator();
                      }
                      return snapshot.data.docs[widget.status] == null
                          ? Text('offline')
                          : Center(
                              child: snapshot.data != null
                                  ? Text(
                                      snapshot.data.docs[widget.status]
                                          ['status'],
                                      style: TextStyle(
                                          color: Colors.black26,
                                          fontSize: 17),
                                    )
                                  : Text('aa'));
                    }),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,

        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

          },
          child: Icon(CommunityMaterialIcons.arrow_left_thick,
              color: Color(0xFF2556BF)),
        ),
        actions: [
          IconButton(
              onPressed: () {
                scaffoldKey.currentState?.openEndDrawer();
              },
              // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,

              icon: Icon(Icons.menu),
              color: Colors.black),
        ],
      ),
      endDrawer: Container(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/1.27,
            left: 140, right: 30, top: 50),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0),
              bottomRight: Radius.circular(35),
              bottomLeft: Radius.circular(35),
              topLeft: Radius.circular(35)),
          child: Drawer(
            elevation: 12,

            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black, blurRadius: 2)],
                color: Color(0xFF0E3589),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);

                        Fluttertoast.showToast(
                          msg: 'Call not Active yet ',
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Color(0xFF0E3589),
                          textColor: Colors.white,
                          toastLength: Toast.LENGTH_LONG,
                          fontSize: 17
                        );

                      },
                      child: Row(
                        children: [
                          Icon(CommunityMaterialIcons.phone, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Call",
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        print('qqwqwwqwqwqwwwwwwwwwwww');
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(SharedHelper.getEmail)
                            .collection('messages')
                            .doc(widget.friendRecive)
                            .delete();

                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(SharedHelper.getEmail)
                            .collection('messages')
                            .doc(widget.friendRecive)
                            .collection('chats')
                            .get()
                            .then((snapshot) {
                          for (DocumentSnapshot doc in snapshot.docs) {
                            doc.reference.delete();
                          }
                        });
                        // delet();
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: 'Chat deleted',
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Color(0xFF0E3589),
                            textColor: Colors.white,
                            toastLength: Toast.LENGTH_SHORT,
                            fontSize: 17
                        );


                        print('122222222211111111111222222222222111111111');
                      },
                      child: Row(
                        children: [
                          Icon(CommunityMaterialIcons.delete,
                              color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Delete chat history",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Icon(CommunityMaterialIcons.alert_circle,
                    //         color: Colors.white),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         "Mute notification",
                    //         style: TextStyle(color: Colors.white, fontSize: 15),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   children: [
                    //     Icon(CommunityMaterialIcons.search_web,
                    //         color: Colors.white),
                    //     Padding(
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Text(
                    //         "Search",
                    //         style: TextStyle(color: Colors.white, fontSize: 15),
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(SharedHelper.getEmail)
                    .collection("messages")
                    .doc(widget.friendRecive)
                    .collection("chats")
                    .orderBy("date", descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.docs.length < 1) {
                      return const Center(
                        child: Text("Say Hi"),
                      );
                    }
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        reverse: true,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return MessageContainer(
                            location: snapshot.data.docs[index]['l'],
                            // isLocation: snapshot.data.docs[index]['message']
                            //         .contains('LocationData') ==
                            //     true,
                            isStrig: snapshot.data.docs[index]['type']

                                ,
                            isMe: snapshot.data.docs[index]['sender'] ==
                                SharedHelper.getEmail,
                            message: snapshot.data.docs[index]['message'],
                            sender: snapshot.data.docs[index]['sender'],
                            time: DateFormat('hh:mm a').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    snapshot.data.docs[index]['date'].seconds *
                                        1000)),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          BottomBarView(
            Token: widget.Token,
            message: message!,
            nameRecive: widget.friendRecive,
            friendName: widget.friendName,
          ),
        ],
      ),
      // bottomNavigationBar: BottomBarView(
      //   message: message!,
      //   nameRecive: widget.friendRecive,
      //   friendName: widget.friendName,
      //
      // ),
    );
  }
}

class ListViewProducts extends StatefulWidget {
  ListViewProducts({this.name, this.des});

  final String? name;
  final String? des;

  late bool? fav;

  @override
  _ListViewProductsState createState() => _ListViewProductsState();
}

class _ListViewProductsState extends State<ListViewProducts> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: MessageController.of(context),
      builder: (context, state) {
        return Column(
          children: [
            Container(
                child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name!,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        widget.des!,
                        style: TextStyle(
                          color: Color(0xF8898B8E),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
            Divider(),
          ],
        );
      },
    );
  }
}
Future<void> delet() async {
  await  FirebaseStorage.instance.ref('phots').delete().catchError((val){
    print('[Errrrrrrrrrrrrrrrrrrror]' + val.toString());
  });
  // Rebuild the UI
}
