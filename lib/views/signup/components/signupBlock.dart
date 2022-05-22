import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:bonus/const/shared_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../home/view.dart';
import '../../login/widgets/signButton.dart';
import '../cubits/signUpController.dart';
import '../models/models.dart';
import '../states/states.dart';
import '../widgets/textNameFiled.dart';

class SignUpBlock extends StatefulWidget {

  @override
  _SignUpBlockState createState() => _SignUpBlockState();
}

class _SignUpBlockState extends State<SignUpBlock> {
  final formKey2 = GlobalKey<FormState>();
  TextEditingController _Emailcontroller = TextEditingController();
  TextEditingController _Passcontroller = TextEditingController();
  TextEditingController _ConfirmPasscontroller = TextEditingController();
  bool isPasswordShow = false;
  final TextEditingController _nameController=TextEditingController();
String? tokens;
  @override
  Widget build(BuildContext context) {
    // final signUp = SignUpController.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: formKey2,
            child: Container(
              height: MediaQuery.of(context).size.height/3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  TextNameField("", TextInputType.name,_nameController,formKey2),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                    ],

                    controller: _Emailcontroller,
                    validator: (value) {
                      if (!value!.isEmpty &&
                          !value.contains('@')) {
                        return 'Email is not correct';
                      }else if (value.isEmpty){
                        return 'Email is empty';
                      }
                      else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),

                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(6.0),
                        borderSide: new BorderSide(),

                      ),

                      hintStyle: TextStyle(color: Colors.black26),
                      hintText: ("Email"),
                    ),
                  ),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                    ],


                    controller: _Passcontroller,
                    validator: (value) {
                      if (value!.isEmpty|| value.length < 7) {
                        return 'Password is short';
                      } else {
                        return null;
                      }
                    },
                    obscureText: isPasswordShow,

                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),

                      border: new OutlineInputBorder(

                        borderRadius: new BorderRadius.circular(6.0),
                        borderSide: new BorderSide(),
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
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(new RegExp(r"\s\b|\b\s"))
                    ],


                    controller: _ConfirmPasscontroller,
                    validator: (value) {
                      if (value != _Passcontroller.text) {
                        return 'Password is not the same';
                      } else {
                        return null;
                      }
                    },
                    obscureText: isPasswordShow,

                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),

                      border: new OutlineInputBorder(

                        borderRadius: new BorderRadius.circular(6.0),
                        borderSide: new BorderSide(),
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
                      hintText: ("Password agin"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder(
            bloc: SignUpController.of(context),
            builder: (context, state) =>state is SignUpLoading
                ? CircularProgressIndicator()

                : InkWell(
              onTap: () async {
                String? specie;

                var named= await FirebaseFirestore.instance.collection('users').get();
                print(named.docs.any((element) => element['name']==_nameController.text));
                bool IsNameExist;
                IsNameExist=named.docs.any((element) => element['name']==_nameController.text);

                print(named);

              print('12345568888888888888888888888');
                if (!formKey2.currentState!.validate()||
                    IsNameExist ) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('name already exists')));
                         return ;

                };
           String x=_Emailcontroller.text;
           String y=_Passcontroller.text;
           print("000000000000000");
           print(x);
           print(y);
                final message = await SignUpController.of(context).signUp(
                    x, y,

                    // _nameController.text,_phoneController.text
                );
                print(message);
                print("0000000000000000000000000000000000000");
                print("11111111");
                print(x);
                print(y);






                if (message == 'ok') {
                  HomeModel homeModel= new HomeModel(
                    name: _nameController.text,
                    email: _Emailcontroller.text,
                    pass: _Passcontroller.text,
                  );
                  // SharedHelper.setName(_Emailcontroller.text);
                  // String c=FirebaseAuth.instance.currentUser!.uid;
                  // await FirebaseDatabase.instance.ref().child('people sign').
                  // child(_nameController.text).
                  // set(<dynamic,dynamic>{
                  //   'name':homeModel.name,
                  //   'email':homeModel.email,
                  //   'pass':homeModel.pass,
                  // }
                  // );
                  await FirebaseMessaging.instance.getToken().then((token){
                    setState(() {
                       tokens=token;
                    });;
                  });
                  await FirebaseFirestore.instance.collection('users').doc(homeModel.email).set({
                    'name':homeModel.name,
                    'email':homeModel.email,
                    'pass':homeModel.pass,
                    'token':tokens,

                  });
                  SharedHelper.setTokenOFNot(tokens);

                  SharedHelper.setName(homeModel.name!);
                  SharedHelper.setEmail(homeModel.email!);
                  // SharedHelper.setName(homeModel.name!);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeView(),
                      ));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message!)));

                }
              },
              child:    Padding(
                padding: const EdgeInsets.only(top: 25.0),
                child: SignButton(name:"new registration" ,
                c: Color(0xff0267b4)),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
