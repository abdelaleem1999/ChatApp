
import 'dart:convert';

import 'package:bonus/const/shared_helper.dart';
import 'package:bonus/views/login/states/states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginController extends Cubit<LoginState> {
  LoginController() : super(IntialLogin());


  static LoginController of (context) =>BlocProvider.of(context);
  late final TextEditingController emailController=TextEditingController();



  Future<String?> login(String email , String password)async {
    try {
      emit(LoodingLogin());
      final response = await Dio().post(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDf_ujUttyeOOn678-QrWbH9sKxhsmB30U',
          data: jsonEncode({'email': email, 'password': password,
            'returnSecureToken': true,

          }),
          options: Options(validateStatus: (status) {
            return status! < 500;
          })
      );
      if (response.statusCode! <= 500) {
        final DataOfLogin = response.data as Map;
        if (DataOfLogin.containsValue(true)) {
          emit(IntialLogin());
          await SharedHelper.setEmail(DataOfLogin['email']);

          return 'ok';
        } else if (DataOfLogin.toString().contains('EMAIL_NOT_FOUND')) {
          emit(IntialLogin());

          return 'Email is not exists';
        } else if (DataOfLogin.toString().contains('INVALID_PASSWORD')) {
          print('121212121223234');
          print(DataOfLogin.toString());
          emit(IntialLogin());


          return 'The password is incorrect';
        }
        else {
          print(DataOfLogin);
          emit(IntialLogin());

          return "There is a problem in registration";
        }

        // success
        // not found
      } else if (response == null) {
        emit(IntialLogin());

        // server not responding.
        return 'server not responding';
      } else {
        emit(IntialLogin());

        return 'some other error or might be CORS policy error.';

        // some other error or might be CORS policy error. you can add your url in CORS policy.
      }
    }
    catch (e, s) {
      emit(IntialLogin());

      return 'No Internet' ;

    }
  }

 }