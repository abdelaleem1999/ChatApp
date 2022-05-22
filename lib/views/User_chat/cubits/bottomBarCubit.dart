
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bonus/const/shared_helper.dart';
import 'package:bonus/views/User_chat/states/bottomBarStates.dart';

class BottomBarController extends Cubit<BottomBarStates> {
  BottomBarController() : super(BottomBarIntial());
  static BottomBarController of(context)=>BlocProvider.of(context) ;

  late File file;


  Future  SendPhotoFromGallery(String nameRecive ,String friendName)async{

      final pickedFile = await ImagePicker()
          .pickImage(source: ImageSource.gallery);
      if (pickedFile == null) return;


      file = await File(pickedFile.path);
      print(file.path);

    try{
      emit(BottomBarLoading());

      // شوف ازاي تخزن صوره ف الفايربيز ستوردج
      await FirebaseStorage.instance
          .ref('phots')
          .child(SharedHelper.getEmail.toString())
          .child(nameRecive)
          .child(file.hashCode.toString())
          .putFile(file);

      var qq = await FirebaseStorage.instance
          .ref('phots')
          .child(SharedHelper.getEmail.toString())
          .child(nameRecive)
          .child(file.hashCode.toString())
          .getDownloadURL();

      print('111111111111111111111221');
      await FirebaseFirestore.instance
          .collection('users')
          .doc(SharedHelper.getEmail)
          .collection('messages')
          .doc(nameRecive)
          .collection('chats')
          .add({
        "sender": SharedHelper.getEmail,
        "receiver": nameRecive,
        "message": qq,
        "l": GeoPoint(0.0, 0.0),
        "type": "image",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(SharedHelper.getEmail)
            .collection('messages')
            .doc(nameRecive)
            .set({
          'last_msg': qq,
          'date': DateTime.now(),
          'name': friendName,
          'sender': SharedHelper.getEmail,
          "type": "image",
        });
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(nameRecive)
          .collection('messages')
          .doc(SharedHelper.getEmail)
          .collection('chats')
          .add({
        "sender": SharedHelper.getEmail,
        "receiver": nameRecive,
        "message": qq,
        "l": GeoPoint(0.0, 0.0),
        "type": "image",
        "date": DateTime.now(),
      }).then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(nameRecive)
            .collection('messages')
            .doc(SharedHelper.getEmail)
            .set({
          "last_msg": qq,
          "date": DateTime.now(),
          'name': SharedHelper.getName!,
          'sender': SharedHelper.getEmail,
          "type": "image",
        });
      });


      print(qq.toString() +
          "aaaaaaaaaaaaaaaaaaaaaaaaaaaqqqqqqqqq");
      print("12121212121212121212121212");
      print("12121212121212121212121212");
      // print(qq.toString());
      // await Fluttertoast.cancel();
    } catch (e){
      emit(BottomBarIntial());
      return e.toString()+'aaaaaaaaaaaaaaaaaaaaaeeeeeeeerrrrrrrrrrrrrrrrvvvvvvvvvvvvvvvcccc65555555566666666';

    }

      emit(BottomBarIntial());






  }
  Future<String?> isInternet() async {
    print("099999999999999999999999999999999999999999999999999999999999999999999");
    print("099999999999999999999999999999999999999999999999999999999999999999999");
    print("099999999999999999999999999999999999999999999999999999999999999999999");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("3444444444444444444444444444444444444444444444444444444444444444444");

      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return 'true';
      } else {
        // Mobile data detected but no internet connection found.
        return 'no Internet';
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("88888888888888888888888888888888888888888888888888888888888888");

      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await InternetConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return 'true';
      } else {
        // Wifi detected but no internet connection found.
        return 'no Internet';
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return 'no Internet';
    }
  }

}