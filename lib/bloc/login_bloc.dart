// ignore_for_file: unused_local_variable
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:home_management_app/validators/validators.dart';

class LoginBloc with Validators {
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

  // Event handlers

  Function(String) get usernameChanged => _usernameController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  // Submit function
  submit(var context) async {
    try {
      final username = _usernameController.value;
      final password = _passwordController.value;
      print(password);
      print(username);
      // Perform login logic here using username and password
    } catch (e) {}
  }

  // Clean up
  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _usernameErrorController.close();
    _passwordErrorController.close();
  }
}
