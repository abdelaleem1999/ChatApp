import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:bonus/views/login/cubits/LoginController.dart';
import 'package:bonus/views/login/states/states.dart';
import 'package:bonus/views/login/widgets/signButton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../const/shared_helper.dart';
import '../../home/view.dart';


class LoginBlock extends StatefulWidget {

  @override
  _LoginBlockState createState() => _LoginBlockState();
}

class _LoginBlockState extends State<LoginBlock> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _Passcontroller = TextEditingController();
  bool isPasswordShow = true;

  @override
  Widget build(BuildContext context) {
    String? Tokens;
    // final login = LoginController.of(context);

    return Padding(
      padding: const EdgeInsets.only(right: 10.0,left: 10),
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                  ],

                  controller: _Emailcontroller,
                  validator: (value) {
                    if (!value!.isEmpty &&
                        !value.contains('@')) {
                      return ' البريد الالكتروني غير صحيح ';
                    }else if (value.isEmpty){
                      return 'البريد الالكتروني فارغ';
                    }
                    else {
                      return null;
                    }
                  },
                  textAlign: TextAlign.left,


                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),



                    border: new OutlineInputBorder(

                      borderRadius: new BorderRadius.circular(8.0),
                      borderSide: new BorderSide(),

                    ),

                    hintStyle: TextStyle(color: Colors.black26),
                    hintText: ("Email"),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 70,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                    ],

                    controller: _Passcontroller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'كلمه المرور فارغه!';
                      } else {
                        return null;
                      }
                    },
                    textAlign: TextAlign.left,
                    obscureText: isPasswordShow,

                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),


                      border: new OutlineInputBorder(

                        borderRadius: new BorderRadius.circular(8.0),
                        borderSide: new BorderSide(

                        ),
                      ),

                    suffixIcon: IconButton(
                        icon: isPasswordShow
                            ? Icon(Icons.visibility_sharp,)
                            : Icon(Icons.visibility_off,),
                        onPressed: () {
                          setState(() {
                            isPasswordShow = !isPasswordShow;
                          });
                        },
                      ),


                      hintStyle: TextStyle(color: Colors.black26),
                      hintText: ("Password"),
                    ),
                  ),
                ),
              ],
            ),
          ),

          BlocBuilder(
            bloc: LoginController.of(context),
            builder: (context, state) =>state is LoodingLogin
                ?  CircularProgressIndicator()



           : InkWell(

              onTap: () async {
                if (!formKey.currentState!.validate()) return;

                final message = await LoginController.of(context).login(
                    _Emailcontroller.text, _Passcontroller.text);
                if ( message != 'ok') {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message!)));
                } else {
                     await FirebaseMessaging.instance.getToken().then((token){
                     setState(() {
                      Tokens=token;
                        });
                     });

                     var x= await FirebaseFirestore.instance.collection('users').doc(_Emailcontroller.text).get();
                 print('00000000000000000000');
                 print(x['name']);
                 if(x['token']==SharedHelper.getTokenOfNot){

                 }else{
                  await FirebaseFirestore.instance.collection('users').doc(_Emailcontroller.text).update({
                     'token':Tokens,
                   });
                  SharedHelper.setTokenOFNot(Tokens);

                 }
                 print(Tokens);
                 print('111111111111111111111111111111');
                  SharedHelper.setName(x['name']);
                  SharedHelper.setEmail(_Emailcontroller.text);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),

                      ));
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SignButton(name:"Login" ,
                c: Color(0xff0267b4),),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

