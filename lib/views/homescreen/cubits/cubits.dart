
import 'package:bonus/views/User_chat/states/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../User_chat/cubits/firebase_realtime_helper.dart';
import '../../User_chat/models/models.dart';

class SenderController extends Cubit<SenderStates>{
  SenderController( ) : super(SenderIntial());
  static SenderController of(context)=>BlocProvider.of(context) ;
 List<HomeModels> Models = [];
 List<HomeModels> Model = [];
 String? x;

  void getFromRealTime()
async
  {
    print("1111111111111111111111111111111111111111111111111111111");
    FirebaseRealtimeHelper.getData().onData((data) {
      print(data.snapshot.value);
      print('aqaqaqaaaaaaaaaaaaqqqqqaa');
      Models.add(HomeModels.fromJson(data.snapshot.value as Map<dynamic, dynamic>));
      print(Models.toString());
      print("222222222222222222222222222222222222222222222222222222222222222222222222"+Models.toString());
      print(Models);


      // print(data.snapshot.value);
      // emit(ProductItemAddedState());
    });
    gets();
  }



Future <void> gets()async{
    emit(SenderLoading());
  FirebaseFirestore.instance.collection("users").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      print('123456789');
      // if(Model.any((List l) => l==x!) ){
      //
      //
      // }else{
      //
      // }
      Model.add(HomeModels.fromJson(result.data() as Map<dynamic, dynamic>));
      print(result.data());
      emit(SenderIntial());
    });
  });
  // QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("users").get();
  //
  // List<HomeModels> result=[];
  // querySnapshot.docs.forEach((doc) {
  //   print(doc["first_name"]);
  //   result.add(HomeModels.fromJson(doc.reference));
  // });
  //
  // Models.add(HomeModels.fromJson(snapshots as Map<dynamic, dynamic>));

//   if(!(Adds!.any((List l) => l[0]==x))){
//       Adds!.add([x,y,z,m]);
//       Get.find<Database>().storeListCarts(Adds!);
//
//     }else{
//
//     }
//
//     // Not.add([x,y,z,m]);
//
//    // total=int.parse(Adds[i][1]) ;
//    // print(total);
//
//     print(Adds);
//
//   }

}

}
