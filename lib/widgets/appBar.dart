import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBar(txt){
  return AppBar(
    elevation: 0,
    title: Text(
      '$txt',

    ),
    iconTheme: IconThemeData(color: Colors.black),
  );
}
