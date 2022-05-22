
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bonus/views/User_chat/component/locationMaps.dart';
import 'package:bonus/views/User_chat/states/locationState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../const/shared_helper.dart';
import '../../homescreen/models/models.dart';
import '../../homescreen/states/states.dart';
import 'firebase_realtime_helper.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';

class MessageController extends Cubit<LocationState>{
  MessageController( ) : super(LocationIntial());
  static MessageController of(context)=>BlocProvider.of(context) ;
  List<HomeModelsMessage> Message = [];
  var z;
 late final String? s;
  Location location = new Location();
  PermissionStatus? permissions;
  LocationData? locationData;
  LocationData? locationData2;
  LocationData? currentlocation2;
  List<Marker> m = [

  ];
  var zaz;

  void PostToFirbaseFireStore(String sender ,String message) async {

    emit(LocationLoading());
     await FirebaseFirestore.instance
          .collection('message')

          .add({
        'sender': sender,
        'message': message,
        'time': FieldValue.serverTimestamp(),
      });

     emit(LocationIntial());
    }
  Future <void> getMessageFromFirestore()async {

   print("q1q1q1q1q1q1q1q1q1q1q1q1q1q11111111111111111111111");
   await FirebaseFirestore.instance.collection("message").get().then((querySnapshot) {
      querySnapshot.docChanges.forEach((result) {
        print("ssasasassssssssssssssssssssssssssssssssssssssssssssssssss");

        print('123456789');
        Message.add(HomeModelsMessage.fromJson(result.doc.data() as Map<dynamic, dynamic>));
        print(result.doc.data());
        print(Message);
      });
    });
//    CollectionReference reference = FirebaseFirestore.instance.collection('planets');
//    reference.snapshots().listen((querySnapshot) {
//      querySnapshot.docChanges.forEach((change) {
//
// change.doc.get();     });
//    });

  }




  PostMessageToRealTime(String sender ,String message) async {

    // emit(SenderLoading());

     await FirebaseDatabase.instance.reference().child('message').child(sender).set({
       'sender': sender,
       'message': message,
     });
        

     // emit(SenderIntial());
    }
     GetStatus(String x )async{
   emit(LocationLoading());
   print('1111111111111111222222222222222222222222222222222221111111111111111111');
      z  =await FirebaseFirestore.instance.collection('users').doc(x).get() ;
      emit(LocationIntial());
      s=z['status'];
      print(s);
      print("12345678901234567890");
      print("000000000000000000000222222222222222222222000000000000000");

    }

  // void getMessageFromRealTime()
  //

  checkGps() async {
 m.clear();
    emit(LocationLoading());


    permissions = await location.hasPermission();
          if(permissions==PermissionStatus.granted){
            locationData = await location.getLocation();
            await  location.onLocationChanged.listen((LocationData currentlocation) {
              }

            );
            m.add(
                Marker(
                  infoWindow: InfoWindow( //popup info
                    title: 'My Custom Title ',
                    snippet: 'My Custom Subtitle',
                  ),
                  markerId: MarkerId(
                      " element.doc.id"
                  ),
                  position: LatLng(locationData!.latitude!,
                      locationData!.longitude!),
                ));


            emit(LocationIntial());

          }else{

            permissions = await location.requestPermission();
            if(permissions==PermissionStatus.granted) {
              locationData = await location.getLocation();
              await  location.onLocationChanged.listen((LocationData currentlocation) {



              }


              );

              m.add(
                  Marker(
                    infoWindow: InfoWindow( //popup info
                      title: 'My Custom Title ',
                      snippet: 'My Custom Subtitle',
                    ),
                    markerId: MarkerId(
                        " element.doc.id"
                    ),
                    position: LatLng(locationData!.latitude!,
                        locationData!.longitude!),
                  )
              );
              emit(LocationIntial());



            }else {
              await  Fluttertoast.showToast(

                    msg: "go to Setting and make ChatApp to acess your Location",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 12,
                    backgroundColor: Color(0xFF2556BF),
                    textColor: Colors.white,
                    fontSize: 18.0
                );

            }


          }


}

}
