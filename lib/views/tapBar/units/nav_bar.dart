import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

import '../cubit.dart';



class NavBar extends StatelessWidget {
  @override
  final  List<String> q=["home","ass","aaaa","aaa"];
  Widget build(BuildContext context) {
    final cubit = HomeLayoutCubit.of(context);
     return ContainedTabBarView(
       tabs: cubit.screens[1][0]
           ,
       views: cubit.screens
           .map((e) => Icon(e[1], size: 25, color: Colors.grey))
           .toList(),
       onChange:  cubit.changeIndex,
       initialIndex: cubit.currentIndex,

    );


    // selectedIndex:  cubit.currentIndex,
    // onTabChange: cubit.changeIndex,



    // CurvedNavigationBar(
    //   index: cubit.currentIndex,
    //   height: 45,
    //   backgroundColor: Colors.cyan,
    //   items: cubit.screens
    //       .map((e) => Icon(e[0], size: 25, color: Colors.grey))
    //       .toList(),
    //   onTap: cubit.changeIndex,
    // );
  }
}
