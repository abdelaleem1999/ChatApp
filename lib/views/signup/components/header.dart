import 'package:flutter/material.dart';
import 'package:bonus/views/signup/components/textSignUp.dart';

import '../../../widgets/loginText.dart';
import '../../login/view.dart';
class SignupHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12,bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextSignUp("Register a new user","You already have account ? ","Login",LoginView()),

          // SignImage(),
          // TextLogin("","","تسجيل الدخول",LoginView()),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height/3.75,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Image border

                child: Image.asset("assets/splash2.jpg",
                    fit: BoxFit.fill),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
