// ignore_for_file: unused_local_variable, prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<void> submit(var context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              insetPadding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: LoadingAnimationWidget.inkDrop(
                          color: BrandColors.arches, size: 38),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      "Validando, espere un momento por favor",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: BrandColors.foggy),
                    )
                  ],
                ),
              ));
        });

    try {
      // Perform login logic here using username and password
      var appAuthJson = await http.post(
          Uri.parse('${authEndpoint}api/v1/security/authenticate'),
          body: json.encode(
              {"username": "$getUsername", "password": getPassword.toString()}),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
          }).timeout(const Duration(seconds: 5),
          onTimeout: () => throw TimeoutException(
              'No se puede conectar, intente más tarde.'));

      var auth = await json.decode(appAuthJson.body);

      var status = appAuthJson.statusCode.toString();
      Navigator.of(context).pop();

      if (status == "200") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String firstName = auth["user"]["name"].split(' ')[0];
        String lastName = auth["user"]["lastname"].split(' ')[0];
        String rolType = auth["user"]["rol"]["name"];
        prefs.setString("access_token", auth["access_token"]);
        prefs.setString("first_name", firstName);
        prefs.setString("last_name", lastName);
        prefs.setString("role_name", rolType);
        Route route = MaterialPageRoute(builder: (context) => AppPage());
        //Navigator.pushReplacement(context, route);
        Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content: Text(auth['message'].toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      }
    } on TimeoutException catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar"))
              ],
            );
          });
    }
  }

  Future<bool> checkAccessTokenValidity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    if (token != null) {
      final response =
          await http.get(Uri.parse('${authEndpoint}api/v1/user/'), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      });
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        // Token is valid
        return true;
      } else {
        // Token is not valid
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        return false;
      }
    } else {
      // No token found, so it is not valid
      return false;
    }
  }

  Future<void> logout(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    try {
      var appAuthJson = await http
          .post(Uri.parse('${authEndpoint}api/v1/security/logout'), headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Accept": "application/json"
      }).timeout(const Duration(seconds: 5),
              onTimeout: () => throw TimeoutException(
                  'No se puede conectar, intente más tarde.'));

      await prefs.clear();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('welcome', (route) => false);
    } catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar"))
              ],
            );
          });
    }
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
