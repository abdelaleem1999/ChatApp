import 'package:bonus/views/User_chat/view.dart';
import 'package:bonus/views/homescreen/states/states.dart';
import 'package:bonus/widgets/userComponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../homescreen/cubits/cubits.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';



class AllMessage extends StatefulWidget {

  @override
  _AllMessageState createState() => _AllMessageState();
}
final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
GlobalKey<LiquidPullToRefreshState>();


class _AllMessageState extends State<AllMessage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: SenderController.of(context),

      builder: (context, state) => state is SenderLoading ?CircularProgressIndicator()

        : LiquidPullToRefresh(
        onRefresh: SenderController.of(context).gets,
          child: ListView.builder(
scrollDirection:  Axis.vertical,
              itemCount: SenderController.of(context).Model.length,
              shrinkWrap: true,
              primary: false,
              physics:const BouncingScrollPhysics(),
              //ClampingScrollPhysics(),
              // scrollDirection: Axis.vertical,
              itemBuilder: (context, index) =>
                  UserComponent(
                    image: "https://sb.kaleidousercontent.com/67418/800x533/c5b0716f3d/animals-0b6addc448f4ace0792ba4023cf06ede8efa67b15e748796ef7765ddeb45a6fb.jpg",
                    name: SenderController.of(context).Model[index].name,
                    message: SenderController.of(context).Model[index].email,
                    numberOfMessage: "7",
                    time: '',
                     IsMe: true,
                    Navigator: UserChat(
                      friendRecive: SenderController.of(context).Model[index].email,
                      friendName: SenderController.of(context).Model[index].name,
                    ),
                  )


          ),
        ),

    );
  }
}
