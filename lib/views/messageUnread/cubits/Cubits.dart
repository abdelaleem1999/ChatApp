import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bonus/views/messageUnread/states/states.dart';

class ConterController extends Cubit <ConterState>{
  ConterController() : super(IntialConter());
  static ConterController of (context) =>BlocProvider.of(context);


   int Conter=0;
  void conterMethod(int conter){
    Conter=conter;
    // emit(RebuildConter());

  }


}
