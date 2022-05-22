
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:bonus/views/User_chat/cubits/bottomBarCubit.dart';
import 'package:bonus/views/User_chat/cubits/cubits.dart';
import 'package:bonus/views/home/view.dart';
import 'package:bonus/views/login/cubits/LoginController.dart';
import 'package:bonus/views/login/view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bonus/views/messageUnread/cubits/Cubits.dart';
import 'package:bonus/views/splash/splashView.dart';

import 'const/shared_helper.dart';
import 'views/homescreen/cubits/cubits.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Firebase.initializeApp(
  );
  runApp(Main());
}
class Main extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider(
        //   create: (context) => LoginController(),
        //
        // ),
        BlocProvider(
          create: (context) => SenderController()..gets(),

        ),
        BlocProvider(
          create: (context) => SenderController()..gets(),

        ),
        BlocProvider(
          create: (context) => MessageController()..checkGps()
            // ..checkGps()
          ,

        ),
        BlocProvider(
          create: (context) => BottomBarController()..isInternet()
            // ..checkGps()
          ,

        ),
        BlocProvider(
          create: (context) => ConterController(),

        ),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashView()
      ),
    );
  }
}
