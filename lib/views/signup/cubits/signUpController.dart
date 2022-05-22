import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../const/shared_helper.dart';
import '../states/states.dart';
class SignUpController extends Cubit<SignUpStates> {

  SignUpController() : super(SignUpIntial());
 static SignUpController of (context) =>BlocProvider.of(context);
   late final String? x;


  Future <String?> signUp(String email, String password ,
      // String name ,String phone
      )async{
    try {
    emit(SignUpLoading());
    final response= await Dio().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDf_ujUttyeOOn678-QrWbH9sKxhsmB30U',
        data:jsonEncode({'email':email ,'password':password,
          'returnSecureToken': true,

        }),
        options: Options(validateStatus: (status) {
          return status! < 500;
        })
    );
    if (response.statusCode! < 500) {
      final data =response.data as Map;
      print(data);
      print('78888888888888888888888');
      print(response.data);
      print('11111111111111111111111111111111111');
      if (data.containsKey('idToken')) {
        print(data);
        await SharedHelper.setEmail(data['email']);

        emit(SignUpIntial());
        print(data['refreshToken']+"999999999999999999999999999999999999");
        return 'ok';
      } else if (data.toString().contains('EMAIL_EXISTS')) {
        emit(SignUpIntial());

        return 'Email already exists';
      } else if (data.toString().contains('WEAK_PASSWORD')) {
        emit(SignUpIntial());

        return 'The password is weak. Try to write a password that contains letters and numbers';
      } else {
        emit(SignUpIntial());
        print(data);

        return 'Email is wrong';
      }

    }
      // not found
     else if (response == null) {
      // server not responding.
      return 'sorry , try agin The server may be damaged';
    } else {
      emit(SignUpIntial());

      return 'sorry , try agin ';

      // some other error or might be CORS policy error. you can add your url in CORS policy.
    }





  } catch (e,s){
      emit(SignUpIntial());
      return 'No Internet' ;
    }

    }
}