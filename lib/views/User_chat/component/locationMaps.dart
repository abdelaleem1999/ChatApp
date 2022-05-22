import 'package:location/location.dart';
import 'package:bonus/views/User_chat/cubits/cubits.dart';
import 'package:bonus/views/User_chat/states/locationState.dart';
import 'package:bonus/views/permission_location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../const/shared_helper.dart';


class LocationMap extends StatefulWidget {
  LocationMap({
    this.message,
    this.nameRecive,
    this.friendName,
    this.testName,
    this.ma1,
    this.mar2,
    this.Token

  });
  late final String? testName;
  late final String? Token;
  late final String? friendName;
  late final String? nameRecive;
  final TextEditingController? message;
  GeoPoint? la;
  double? lat;
  double? long;
  double? ma1;
  double? mar2;


  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
@override
var zzzz;
num m=0;

List<Marker> markers = [

];
List<Marker> markers2 = [

];

@override
  void initState() {
    // TODO: implement initState
    // MessageController.of(context)..checkGps();
    // MessageController.of(context).m.clear();

}

@override




@override

  Widget build(BuildContext context,) {
    return  Scaffold(
            body: BlocBuilder(
                        bloc: MessageController.of(context),

              builder: (context, state) => state is LocationLoading ? Center(child: CircularProgressIndicator())
              : SafeArea(
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,

                            children: [
                              GoogleMap(
                                  zoomControlsEnabled: false,

                                  // onMapCreated: _onMapCreated,

                                  initialCameraPosition: CameraPosition(
                                      // bearing: 192.8334901395799,
                                      target: MessageController.of(context).locationData!=null ? LatLng(
                                         MessageController.of(context).locationData!.latitude!,
                                        MessageController.of(context).locationData!.longitude!
                                      ) :LatLng(0, 0),
                                      // tilt: 59.440717697143555,
                                      zoom: 17),
                                markers: markers.length<1 ?
                                MessageController.of(context).m.toSet()
                                :markers.toSet(),
                                onTap: (newLatLng){
                                  setState(() {
                                    markers.clear();

                                  });

                                 markers.add(Marker(
                                      markerId: MarkerId('New'), position: LatLng(newLatLng.latitude,newLatLng.longitude)));
                                  widget.la=GeoPoint(newLatLng.latitude,newLatLng.longitude);



                                },
                              ),
                              InkWell(
                                onTap: ()async{
                                  print(MessageController.of(context).locationData);
                                  print(MessageController.of(context).locationData.toString());
                                  Fluttertoast.showToast(

                                      msg: "Location sending... ",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 12,
                                      backgroundColor: Color(0xFF2556BF),
                                      textColor: Colors.white,
                                      fontSize: 18.0
                                  );
                                  print('111111111111111111111221');
                                  print(widget.nameRecive);
                                  print(widget.message);


                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.nameRecive)
                                      .collection('messages')
                                      .doc(SharedHelper.getEmail)
                                      .collection('chats')
                                      .add({
                                    "sender": SharedHelper.getEmail,
                                    "receiver": widget.nameRecive,
                                    "message": MessageController.of(context).locationData.toString(),
                                    "l": GeoPoint(MessageController.of(context).locationData!.latitude!,
                                        MessageController.of(context).locationData!.longitude!) ,
                                    "type": "location",
                                    "date": DateTime.now(),
                                    "seen":1,

                                  }).then((value) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(widget.nameRecive)
                                        .collection('messages')
                                        .doc(SharedHelper.getEmail)
                                        .set({
                                      "last_msg": MessageController.of(context).locationData.toString(),
                                      "date": DateTime.now(),
                                      'name': SharedHelper.getName!,
                                      'sender': SharedHelper.getEmail,
                                      "type": "location",
                                      "seen":0,
                                      'token':widget.Token,



                                    });
                                  });



                                  var z=  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.nameRecive)
                                      .collection('messages')
                                      .doc(SharedHelper.getEmail).collection('chats').get();
                                  for (var doc in z.docs) {
                                    zzzz=  await doc['seen'];
                                    m=m+zzzz;
                                    print(m.toString());
                                    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
                                    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
                                    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
                                    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
                                  };





                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(SharedHelper.getEmail)
                                      .collection('messages')
                                      .doc(widget.nameRecive)
                                      .collection('chats')
                                      .add({
                                    "sender": SharedHelper.getEmail,
                                    "receiver": widget.nameRecive,
                                    "message": MessageController.of(context).locationData.toString(),
                                    "l": widget.la==null ? GeoPoint(
                                      MessageController.of(context).locationData!.latitude!,
                                        MessageController.of(context).locationData!.longitude!)
                                    :widget.la,
                                    "type": "location",
                                    "date": DateTime.now(),
                                    "seen":0,

                                  }).then((value) {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(SharedHelper.getEmail)
                                        .collection('messages')
                                        .doc(widget.nameRecive)
                                        .set({
                                      'last_msg':widget.la==null ? MessageController.of(context).locationData.toString()
                                          :widget.la.toString(),
                                      'date': DateTime.now(),
                                      'name': widget.friendName!,
                                      'sender': SharedHelper.getEmail,
                                      "type": "location",
                                      "seen":0,
                                      'token':widget.Token,



                                    });
                                  });
                                await  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.nameRecive)
                                      .collection('messages')
                                      .doc(SharedHelper.getEmail).update({'seen':
                                  m
                                  });


                                  Navigator.pop(context);
                                  print("12121212121212121212121212");

                                  print("12121212121212121212121212");
                                  print("12121212121212121212121212");
                                  print("12121212121212121212121212");

                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 30,right: 50,
                                  bottom: 60),
                                  child: IconButton(onPressed:()async{


                                  }, icon:  Icon(CommunityMaterialIcons.send_circle,
                                    size: 80,color: Color(0xFF01050E)
                                    ,),),
                                ),
                              )

                            ],
                          )
                      ),

)


    );
  }
}
//AIzaSyAYUFPXRJ7yuAMrxJ9k_Nacbjz88qSl4DM
