import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseRealtimeHelper {
  // the parent reference in firebase realtime
  static final _ref = FirebaseDatabase.instance.reference().child('people sign');
  static final _refs = FirebaseFirestore.instance.collection('message');
  static final _ref2 = FirebaseDatabase.instance.reference().child('message');
  static final _ref3 = FirebaseDatabase.instance.reference().child('product3');
  static final _ref4 = FirebaseDatabase.instance.reference();



  static StreamSubscription<DatabaseEvent> getData() {
    final stream = _ref.onChildAdded;
    return stream.listen((event) {
      print(event.snapshot.value);
      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    });

  }
  static StreamSubscription<dynamic> getData2211() {
 final x=FirebaseFirestore.instance.collection('message').snapshots();

   return x.listen((snapshot) {

   });



  }
  // static StreamSubscription<DatabaseEvent> getDatas() {
  //   final stream = _refs.app;
  //   return stream.listen((event) {
  //     print(event.snapshot.value);
  //   });
  //
  //   /*
  //   // call this to open the stream
  //   // call it in the controller if you using the bloc
  //   // in the view if you are using Stateful Widget
  //
  //    FirebaseRealtimeHelper.getData().onData((data) {
  //     // print(data.snapshot.value);
  //     controller.models.add(Mahgar.fromJson(data.snapshot.value));
  //     setState(() {
  //     });
  //          });
  //    */
  // }
  static StreamSubscription<DatabaseEvent> getData2() {
    final stream = _ref2.onChildAdded;
    return stream.listen((event) {
      print(event.snapshot.value);
    });

    /*
    // call this to open the stream
    // call it in the controller if you using the bloc
    // in the view if you are using Stateful Widget

     FirebaseRealtimeHelper.getData().onData((data) {
      // print(data.snapshot.value);
      controller.models.add(Mahgar.fromJson(data.snapshot.value));
      setState(() {
      });
           });
     */
  }
  static StreamSubscription<DatabaseEvent> getData3() {
    final stream = _ref3.onChildAdded;
    return stream.listen((event) {
      print(event.snapshot.value);
    });

    /*
    // call this to open the stream
    // call it in the controller if you using the bloc
    // in the view if you are using Stateful Widget

     FirebaseRealtimeHelper.getData().onData((data) {
      // print(data.snapshot.value);
      controller.models.add(Mahgar.fromJson(data.snapshot.value));
      setState(() {
      });
           });
     */
  }

  static StreamSubscription<DatabaseEvent> deleteData() {
    final stream = _ref.onChildRemoved;
    return stream.listen((event) {
      print(event.snapshot.value);
    });

    /*
      // call this to open the stream
      // call it in the controller if you using the bloc
      // in the view if you are using Stateful Widget

      FirebaseRealtimeHelper.deleteData().onData((data) {
      print("item removed from database");
      var model =Mahgar.fromJson(data.snapshot.value);
      controller.models.removeWhere((element) => element.mahgarNumber==model.mahgarNumber);
      setState(() {
      });
             });
     */
  }
  static StreamSubscription<DatabaseEvent> addData() {
    final stream = _ref4.onChildAdded;
    return stream.listen((event) {
      print(event.snapshot.value);
    });

    /*
      // call this to open the stream
      // call it in the controller if you using the bloc
      // in the view if you are using Stateful Widget

      FirebaseRealtimeHelper.deleteData().onData((data) {
      print("item removed from database");
      var model =Mahgar.fromJson(data.snapshot.value);
      controller.models.removeWhere((element) => element.mahgarNumber==model.mahgarNumber);
      setState(() {
      });
             });
     */
  }

  static StreamSubscription<DatabaseEvent> updateData() {
    final stream = _ref.onChildChanged;
    return stream.listen((event) {
      print(event.snapshot.value);
    });

    /*
      // call this to open the stream
      // call it in the controller if you using the bloc
      // in the view if you are using Stateful Widget

       FirebaseRealtimeHelper.updateData().onData((data) {
      print("item updated from database");
      var model = Mahgar.fromJson(data.snapshot.value);
      var index = controller.models
          .indexWhere((element) => element.mahgarNumber == model.mahgarNumber);
      controller.models[index] = model;
      setState(() {});
    });
             });
     */
  }
}
