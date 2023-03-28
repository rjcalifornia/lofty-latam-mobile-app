// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:home_management_app/Http/validators/validators.dart';

class LoginController with Validators {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _formKey = GlobalKey<FormState>();
  final _usernameErrorController = BehaviorSubject<String>();
  final _passwordErrorController = BehaviorSubject<String>();

  // Getters for the streams
  Stream<String> get username =>
      _usernameController.stream.transform(validateUsername);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  GlobalKey<FormState> get formKey => _formKey;
  Stream<String> get usernameError => _usernameErrorController.stream;
  Stream<String> get passwordError => _passwordErrorController.stream;

  // Stream transformers
  Stream<bool> get submitCheck =>
      CombineLatestStream.combine2(username, password, (a, b) {
        if ((a == _usernameController.value) &&
            (b == _passwordController.value)) {
          return true;
        }
        return false;
      });

  Function(String) get usernameChanged => _usernameController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  // Event handlers

  String? get getUsername => _usernameController.value;
  String? get getPassword => _passwordController.value;

  //Clear login form
  void destroyLogin() {
    passwordChanged('');
    usernameChanged('');
  }

  // Submit function
  submit(var context) async {
    try {
      print(getPassword);
      print(getUsername);
      // Perform login logic here using username and password
      var appAuthJson = await http.post(
          Uri.parse("authEndpoint " + 'v1/representantes/authentication'),
          body: json.encode(
              {"username": "$getUsername", "password": password.toString()}),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          });

      var auth = json.decode(appAuthJson.body);

      //print(appAuthJson.statusCode.toString());
      var status = appAuthJson.statusCode.toString();
    } catch (e) {}
  }

  // Clean up
  dispose() {
    _usernameController.close();
    _passwordController.close();
    _usernameErrorController.close();
    _passwordErrorController.close();
  }

  removeLocal(var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    destroyLogin();
  }
}
