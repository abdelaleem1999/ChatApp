import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bonus/views/home/view.dart';
import 'package:bonus/views/login/view.dart';
import 'package:bonus/views/pageView/view.dart';

import '../../const/shared_helper.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SharedHelper.getEmail==null
                ?PageViewDemo()

            :  SharedHelper.getEmail!.isEmpty
              ? LoginView() :
            HomeView(),
          ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,
        body:
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/zxcxz.jpg",
              fit: BoxFit.fill),
            ),

        );








  }
}
