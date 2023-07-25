import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/models/User.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_management_app/validators/validators.dart';

class UserBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _lastnameController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;

  Stream<String> get nameStream =>
      _nameController.stream.transform(simpleValidation);
  Stream<String> get lastnameStream =>
      _lastnameController.stream.transform(simpleValidation);
  Stream<String> get phoneStream =>
      _phoneController.stream.transform(simpleValidation);

  String? get name => _nameController.value;
  String? get lastname => _lastnameController.value;
  String? get phone => _phoneController.value;

  Stream<bool> get verifyFullName =>
      CombineLatestStream.combine2(nameStream, lastnameStream, (a, b) {
        if ((a == _nameController.value) && (b == _lastnameController.value)) {
          return true;
        }
        return false;
      });

  Stream<bool> get verifyPhone => phoneStream.map((phoneStream) => true);

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

      print(userUpdateJson.statusCode);

      if (userUpdateJson.statusCode > 400) {
        dynamic response = json.decode(userUpdateJson.body);
        Exception(Text(response['message'].toString()));
      }

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: const Text("Datos han sido actualizados correctamente."),
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
    } catch (e) {
      Exception(e.toString());
    }
  }
}
