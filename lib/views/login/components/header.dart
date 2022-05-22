import 'package:flutter/material.dart';

import '../../../widgets/loginText.dart';
import '../../signup/view.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LoginImage(),
            TextLogin("Login to your account","","تسجيل جديد",SignUpView()
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0,right: 12,bottom: 12,top: 30),
              child: Container(
                height: MediaQuery.of(context).size.height/4,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15), // Image border

                  child: Image.asset("assets/love.jpg",
                      fit: BoxFit.fill),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
