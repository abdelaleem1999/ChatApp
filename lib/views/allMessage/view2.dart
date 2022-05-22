import 'package:bonus/views/User_chat/cubits/cubits.dart';
import 'package:bonus/views/allMessage/widgets/allUserComponent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../const/shared_helper.dart';
import '../../widgets/userComponent.dart';
import '../User_chat/view.dart';

class AllUsers extends StatefulWidget {

  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(

        stream: FirebaseFirestore.instance.collection('users').doc(
            SharedHelper.getEmail).snapshots(),
        builder: (context, snapshot) {
          return StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),

            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length < 1) {
                  return Center(child: const Text('No Users Sign'));
                } else {
                  return ListView.builder(

                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      // scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return AllUserComponent(
                          name: snapshot.data.docs[index]['name'],
                          message: snapshot.data.docs[index]['email'],


                          Navigator: UserChat(
                            Token: snapshot.data.docs[index]['token'],
                            friendRecive: snapshot.data.docs[index].id,
                            friendName: snapshot.data.docs[index]['name'],
                            status: index,

                          ),
                        );
                      }


                  );
                }
              }
              return const Center(child: CircularProgressIndicator(),);
            },);
        }
    );
  }
}
