import 'package:bonus/views/messageUnread/view.dart';
import 'package:bonus/views/tapBar/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../allMessage/view.dart';
import '../allMessage/view2.dart';
import '../home/view.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(HomeLayoutInit());

  static HomeLayoutCubit of(context) => BlocProvider.of(context);

  int currentIndex = 0;
  int Conter=0;

  final List<List<dynamic>> screens = [
    [Icons.home, AllUsers(),"home"],
    // [Icons.category, bb(),"ca"],
    [Icons.favorite, MessageUnReadView(),"fa"],
    // [Icons.settings, AllMessage(),"setting"],

  ];

  void changeIndex(int value) {
    if (currentIndex == value) return;
    currentIndex = value;
    emit(HomeLayoutInit());
  }

  Widget get getCurrentView => screens[currentIndex][1];
}
