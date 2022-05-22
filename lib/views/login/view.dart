import 'package:bonus/views/login/components/header.dart';
import 'package:bonus/views/login/components/loginBlock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bonus/views/login/cubits/LoginController.dart';
import 'package:bonus/views/signup/view.dart';

import 'widgets/signButton.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  // final formKey = GlobalKey<FormState>();
  // TextEditingController _Emailcontroller = TextEditingController();
  // TextEditingController _Passcontroller = TextEditingController();
  // LoginController _loginController = LoginController();
  bool isPasswordShow = false;


  @override
  Widget build(BuildContext context) {
    // final login = LoginController.of(context);

    return BlocProvider(
      create: (context) =>LoginController() ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [


            LoginHeader(),
            LoginBlock(),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpView()));
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0,left: 10,top: 10),
                child: SignButton(name:"New User" ,
                  c: Color(0xffbf6475),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

