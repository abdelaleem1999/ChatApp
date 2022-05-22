import 'package:bonus/views/tapBar/cubit.dart';
import 'package:bonus/views/tapBar/states.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: BlocProvider(
        create: (context) => HomeLayoutCubit(),
        child: BlocBuilder<HomeLayoutCubit, HomeLayoutStates>(
          builder: (context, state) => Scaffold(

            // bottomNavigationBar: NavBar(),
            body: ContainedTabBarView(
              tabs: [
                Text('First', style: TextStyle(color: Colors.black)),
                Text('Second', style: TextStyle(color: Colors.black))
              ],
              views: [
                Container(color: Colors.red),
                Container(color: Colors.green),
              ],
              // onChange:HomeLayoutCubit.of(context).changeIndex,
            ),

          ),
        ),
      ),
    );
  }
}

