// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/User.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_management_app/validators/validators.dart';

class UserBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _oldPasswordController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _repeatPasswordController = BehaviorSubject<String>();
  final _documentController = BehaviorSubject<String>();
  final _distritoController = BehaviorSubject<String>();
  final _usernameController = BehaviorSubject<String>();

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeOldPassword => _oldPasswordController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRepeatPassword =>
      _repeatPasswordController.sink.add;
  Function(String) get changeDocument => _documentController.sink.add;
  Function(String) get changeDistrito => _distritoController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;

  Stream<String> get nameStream =>
      _nameController.stream.transform(simpleValidation);
  Stream<String> get lastnameStream =>
      _lastnameController.stream.transform(simpleValidation);
  Stream<String> get phoneStream =>
      _phoneController.stream.transform(simplePhoneValidation);
  Stream<String> get emailStream =>
      _emailController.stream.transform(simpleValidation);
  Stream<String> get oldPasswordStream =>
      _oldPasswordController.stream.transform(validatePassword);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);
  Stream<String> get repeatPasswordStream => _repeatPasswordController.stream
          .transform(validatePassword)
          .doOnData((String c) {
        if (0 != _passwordController.value.compareTo(c)) {
          _repeatPasswordController.addError("No Match");
        }
      });

  Stream<String> get documentStream =>
      _documentController.stream.transform(simpleDocumentValidation);
  Stream<String> get distritoStream =>
      _distritoController.stream.transform(simpleValidation);
  Stream<String> get usernameStream =>
      _usernameController.stream.transform(simpleValidation);

  String? get name => _nameController.value;
  String? get lastname => _lastnameController.value;
  String? get phone => _phoneController.value;
  String? get email => _emailController.value;
  String? get oldPassword => _oldPasswordController.value;
  String? get password => _passwordController.value;
  String? get repeatPassword => _repeatPasswordController.value;
  String? get document => _documentController.value;
  String? get distrito => _distritoController.value;
  String? get username => _usernameController.value;

  Stream<bool> get verifyFullName =>
      CombineLatestStream.combine2(nameStream, lastnameStream, (a, b) {
        if ((a == _nameController.value) && (b == _lastnameController.value)) {
          return true;
        }
        return false;
      });

  Stream<bool> get verifyPasswordsEqual =>
      CombineLatestStream.combine2(oldPasswordStream, repeatPasswordStream,
          (a, b) {
        if ((b == _repeatPasswordController.value) &&
            (a == _oldPasswordController.value)) {
          return true;
        }
        return false;
      });

  Stream<bool> get verifyRegistrationData => CombineLatestStream([
        nameStream,
        lastnameStream,
        documentStream,
        usernameStream,
        passwordStream,
        distritoStream
      ], (_) => true);
  Stream<bool> get verifyPhone => phoneStream.map((phone) => true);
  Stream<bool> get verifyEmail => emailStream.map((email) => true);
  Stream<bool> get verifyDocument => documentStream.map((document) => true);
  Stream<bool> get verifyDistrict => distritoStream.map((distrito) => true);

  Future getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    try {
      var paymentJson = await http
          .get(Uri.parse('${authEndpoint}api/v1/user/profile'), headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $accessToken',
      });

      final leaseParsed = json.decode(paymentJson.body);
      //print(leaseParsed);
      final user = User.fromJson(leaseParsed);

      return user;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateUserInformation(context, infoType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    dynamic payload;

    if (infoType == 'name') {
      payload = {"name": name.toString(), "lastname": lastname.toString()};
    }

    if (infoType == 'phone') {
      payload = {"phone": phone.toString()};
    }

    if (infoType == 'email') {
      payload = {"email": email.toString()};
    }

    try {
      var userUpdateJson = await http.patch(
          Uri.parse('${authEndpoint}api/v1/user/update'),
          body: json.encode(payload),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'Se ha perdido la conexión a internet, por favor intente más tarde.');
      });

      Navigator.of(context).pop();

      if (userUpdateJson.statusCode > 400) {
        dynamic response = json.decode(userUpdateJson.body);
        CustomDialogs.fatalErrorDialog(context, response['message'].toString());
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content:
                    const Text("Datos han sido actualizados correctamente."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      }
    } catch (e) {
      Exception(e.toString());
    }
  }

  Future<void> updatePassword(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: LoadingAnimationWidget.inkDrop(
                color: BrandColors.arches, size: 38),
          );
        });
    try {
      var passwordUpdateJson = await http
          .post(Uri.parse('${authEndpoint}api/v1/user/change-password'),
              body: json.encode({
                "old_password": oldPassword.toString(),
                "password": password.toString(),
                "repeat_password": repeatPassword.toString()
              }),
              headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'Se ha perdido la conexión a internet, por favor intente más tarde.');
      });

      var status = passwordUpdateJson.statusCode.toString();

      Navigator.of(context).pop();
      if (status == "204") {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content:
                    const Text("Datos han sido actualizados correctamente."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      } else {
        var response = json.decode(passwordUpdateJson.body);
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(response['message'].toString()),
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
    } catch (e) {
      Exception(e.toString());
    }
  }

  Future<void> createNewUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = '';
    _emailController.stream.listen((email) {
      // You can access the email value here
    });
    if (_emailController.hasValue) {
      userEmail = email.toString();
    }

    CustomDialogs.loadingDialog(
        context, "Registrando datos, espere un momento por favor");

    try {
      var newUserJson =
          await http.post(Uri.parse('${authEndpoint}api/v1/user/registration'),
              body: json.encode({
                "name": name.toString(),
                "lastname": lastname.toString(),
                "username": username.toString(),
                "dui": document.toString(),
                "email": userEmail.toString(),
                "phone": phone.toString(),
                "password": password.toString(),
              }),
              headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'No se puede conectar, verifique su conexión a internet e intente más tarde.');
      });

      dynamic jsonBody = await json.decode(newUserJson.body);

      var status = newUserJson.statusCode.toString();
      Navigator.of(context).pop();
      if (status == '200') {
        prefs.setString("access_token", jsonBody["access_token"]);
        prefs.setString("first_name", jsonBody["user"]["first_name"]);
        prefs.setString("last_name", jsonBody["user"]["first_lastname"]);
        prefs.setString("role_name", jsonBody["user"]["rol_name"]);

        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content: const Text("Cuenta ha sido creada exitosamente."),
                actions: [
                  TextButton(
                      onPressed: () {
                        Route route =
                            MaterialPageRoute(builder: (context) => AppPage());

                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('home', (route) => false);
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content: Text(jsonBody['message'].toString()),
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
    } catch (e) {
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  Future<void> resendVerificationEmail(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    try {
      var sendEmailRequestJson = await http.post(
          Uri.parse('${authEndpoint}api/v1/user/resend-validation-email'),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'Se ha perdido la conexión a internet, por favor intente más tarde.');
      });

      Navigator.of(context).pop();

      if (sendEmailRequestJson.statusCode > 400) {
        dynamic response = json.decode(sendEmailRequestJson.body);
        CustomDialogs.fatalErrorDialog(context, response['message'].toString());
      } else {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content: const Text(
                    "Correo de validación de cuenta ha sido enviado correctamente"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        //Navigator.of(context).pop();
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      }
    } catch (e) {
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  Future<void> deleteAccount(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    try {
      var deleteRequestJson = await http.post(
          Uri.parse('${authEndpoint}api/v1/user/deactivate-account'),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'Se ha perdido la conexión a internet, por favor intente más tarde.');
      });

      Navigator.of(context).pop();

      if (deleteRequestJson.statusCode > 400) {
        dynamic response = json.decode(deleteRequestJson.body);
        CustomDialogs.fatalErrorDialog(context, response['message'].toString());
      } else {
        await prefs.clear();
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
                content: const Text("Su cuenta ha sido eliminada"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'welcome', (route) => false);
                      },
                      child: const Text("Aceptar"))
                ],
              );
            });
      }
    } catch (e) {
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }
}
