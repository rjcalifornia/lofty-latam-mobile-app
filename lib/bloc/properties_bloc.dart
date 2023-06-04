// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/models/Property.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/validators/validators.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';

class PropertiesBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _addressController = BehaviorSubject<String>();
  final _bedroomsController = BehaviorSubject<String>();
  final _bedsController = BehaviorSubject<String>();
  final _bathroomsController = BehaviorSubject<String>();
  final _airConditionerController = BehaviorSubject<String>();
  final _kitchenController = BehaviorSubject<String>();
  final _dinningController = BehaviorSubject<String>();
  final _dishSinkController = BehaviorSubject<String>();
  final _fridgeController = BehaviorSubject<String>();
  final _tvController = BehaviorSubject<String>();
  final _furnitureController = BehaviorSubject<String>();
  final _garageController = BehaviorSubject<String>();

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changeBedrooms => _bedroomsController.sink.add;
  Function(String) get changeBeds => _bedsController.sink.add;
  Function(String) get changeBathrooms => _bathroomsController.sink.add;
  Function(String) get changeAirConditioner =>
      _airConditionerController.sink.add;
  Function(String) get changeKitchen => _kitchenController.sink.add;
  Function(String) get changeDinning => _dinningController.sink.add;
  Function(String) get changeDishSink => _dishSinkController.sink.add;
  Function(String) get changeFridge => _fridgeController.sink.add;
  Function(String) get changeTv => _tvController.sink.add;
  Function(String) get changeFurniture => _furnitureController.sink.add;
  Function(String) get changeGarage => _garageController.sink.add;

  Stream<String> get nameStream =>
      _nameController.stream.transform(validatePropertyFields);
  Stream<String> get addressStream =>
      _addressController.stream.transform(validatePropertyFields);
  Stream<String> get bedroomsStream =>
      _bedroomsController.stream.transform(validatePropertyFields);
  Stream<String> get bedsStream =>
      _bedsController.stream.transform(validatePropertyFields);
  Stream<String> get bathroomsStream =>
      _bathroomsController.stream.transform(validatePropertyFields);
  Stream<String> get airConditionerStream =>
      _airConditionerController.stream.transform(validatePropertyFields);
  Stream<String> get kitchenStream =>
      _kitchenController.stream.transform(validatePropertyFields);
  Stream<String> get dinningStream =>
      _dinningController.stream.transform(validatePropertyFields);
  Stream<String> get dishSinkStream =>
      _dishSinkController.stream.transform(validatePropertyFields);
  Stream<String> get fridgeStream =>
      _fridgeController.stream.transform(validatePropertyFields);
  Stream<String> get tvStream =>
      _tvController.stream.transform(validatePropertyFields);
  Stream<String> get garageStream =>
      _garageController.stream.transform(validatePropertyFields);
  Stream<String> get furnitureStream =>
      _furnitureController.stream.transform(validatePropertyFields);

  String? get name => _nameController.value;
  String? get address => _addressController.value;
  String? get bedrooms => _bedroomsController.value;
  String? get beds => _bedsController.value;
  String? get bathrooms => _bathroomsController.value;
  String? get airConditioner => _airConditionerController.value;
  String? get kitchen => _kitchenController.value;
  String? get dinning => _dinningController.value;
  String? get dishSink => _dishSinkController.value;
  String? get fridge => _fridgeController.value;
  String? get tv => _tvController.value;
  String? get garage => _garageController.value;
  String? get furniture => _furnitureController.value;

  Stream<bool> get verifyPropertyData => CombineLatestStream.combine5(
          nameStream,
          addressStream,
          bedroomsStream,
          bedsStream,
          bathroomsStream, (a, b, c, d, e) {
        if ((a == _nameController.value) &&
            (b == _addressController.value) &&
            (c == _bedroomsController.value) &&
            (d == _bedsController.value) &&
            (e == _bathroomsController.value)) {
          return true;
        }
        return false;
      });

  Future getPropertiesList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    var propertiesJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/dashboard/properties/list'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final propertiesList = json.decode(propertiesJson.body);
    return propertiesList;
  }

  Future getPropertyDetails(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    var propertyJson = await http
        .get(Uri.parse('${authEndpoint}api/v1/property/$id/view'), headers: {
      "Accept": "application/json",
      'Authorization': 'Bearer $accessToken',
    });

    final propertyMap = json.decode(propertyJson.body);
    final property = Property.fromJson(propertyMap);
    return property;
  }

  Future getPayments(leaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    var paymentsJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/payments/$leaseId/history'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final paymentsParsed =
        json.decode(paymentsJson.body).cast<Map<String, dynamic>>();

    return paymentsParsed
        .map<PaymentsDetails>((json) => PaymentsDetails.fromJson(json))
        .toList();

    //print(paymentsMap);
    //final payments = Payments.fromJson(paymentsMap);

    // return payments;
  }

  Future getLeaseDetails(leaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    var leaseJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/property/lease/$leaseId/details'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });
    final leaseParsed = json.decode(leaseJson.body);

    final lease = Lease.fromJson(leaseParsed);

    return lease;
  }

  Future<void> createProperty(var context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    try {
      var propertyJson = await http
          .post(Uri.parse('${authEndpoint}api/v1/dashboard/properties/add-new'),
              body: json.encode({
                "name": name.toString(),
                "address": address.toString(),
                "bedrooms": bedrooms.toString(),
                "beds": beds.toString(),
                "bathrooms": bathrooms.toString(),
                "has_ac": airConditioner.toString(),
                "has_kitchen": kitchen.toString(),
                "has_dinning_room": dinning.toString(),
                "has_sink": dishSink.toString(),
                "has_fridge": fridge.toString(),
                "has_tv": tv.toString(),
                "has_furniture": furniture.toString(),
                "has_garage": garage.toString(),
                "active": true,
                "property_type_id": 1,
              }),
              headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5),
              onTimeout: () => throw TimeoutException(
                  'No se puede conectar, intente más tarde.'));

      var auth = await json.decode(propertyJson.body);

      var status = propertyJson.statusCode.toString();
      print(auth);

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text("Datos almacenados correctamente."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Aceptar"))
              ],
            );
          });
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

  Future getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: prefer_typing_uninitialized_variables
    Map<String, dynamic> user = {};

    user['firstName'] = prefs.getString('first_name');
    user['lastName'] = prefs.getString('last_name');
    user['rolName'] = prefs.getString('role_name');

    return user;
    //return '${prefs.getString("first_name")} ${prefs.getString("last_name")}';
  }
}
