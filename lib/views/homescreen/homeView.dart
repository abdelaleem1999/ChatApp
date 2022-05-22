import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../User_chat/cubits/cubits.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder(
        bloc: MessageController.of(context),
        builder: (context, state) {
          return Column(
            children: [
              TextButton(onPressed: () {
                // SenderController.of(context).PostToRealTime("sender", "message");
              }, child: Text("ook"))
            ],
          );
        },
      ),
    );
  }
}
