// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/models/RentClass.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'dart:io';

import 'package:home_management_app/validators/validators.dart';
import 'package:uuid/uuid.dart';

class LeaseBloc with Validators {
  final _rentClassController = BehaviorSubject<String>();
  final _contractDateController = BehaviorSubject<String>();
  final _paymentDateController = BehaviorSubject<String>();
  final _expirationDateController = BehaviorSubject<String>();
  final _priceController = BehaviorSubject<String>();
  final _depositController = BehaviorSubject<String>();
  final _tenantNameController = BehaviorSubject<String>();
  final _tenantLastnameController = BehaviorSubject<String>();
  final _tenantUsernameController = BehaviorSubject<String>();
  final _tenantPhoneController = BehaviorSubject<String>();
  final _tenantEmailController = BehaviorSubject<String>();

  Function(String) get changeRentClass => _rentClassController.sink.add;
  Function(String) get changeContractDate => _contractDateController.sink.add;
  Function(String) get changePaymentDate => _paymentDateController.sink.add;
  Function(String) get changeExpirationDate =>
      _expirationDateController.sink.add;
  Function(String) get changePrice => _priceController.sink.add;
  Function(String) get changeDeposit => _depositController.sink.add;
  Function(String) get changeTenantName => _tenantNameController.sink.add;
  Function(String) get changeTenantLastname =>
      _tenantLastnameController.sink.add;
  Function(String) get changeTenantUsername =>
      _tenantUsernameController.sink.add;
  Function(String) get changeTenantPhone => _tenantPhoneController.sink.add;
  Function(String) get changeTenantEmail => _tenantEmailController.sink.add;

  Stream<String> get rentClassStream =>
      _rentClassController.stream.transform(validateLeaseFields);
  Stream<String> get contractDateStream =>
      _contractDateController.stream.transform(validateLeaseFields);
  Stream<String> get paymentDateStream =>
      _paymentDateController.stream.transform(validateLeaseFields);
  Stream<String> get expirationDateStream =>
      _expirationDateController.stream.transform(validateLeaseFields);
  Stream<String> get priceStream =>
      _priceController.stream.transform(validateLeaseFields);
  Stream<String> get depositStream =>
      _depositController.stream.transform(validateLeaseFields);
  Stream<String> get tenantNameStream =>
      _tenantNameController.stream.transform(validateLeaseFields);
  Stream<String> get tenantLastnameStream =>
      _tenantLastnameController.stream.transform(validateLeaseFields);
  Stream<String> get tenantUsernameStream =>
      _tenantLastnameController.stream.transform(validateLeaseFields);
  Stream<String> get tenantPhoneStream =>
      _tenantPhoneController.stream.transform(validateLeaseFields);
  Stream<String> get tenantEmailStream =>
      _tenantEmailController.stream.transform(validateLeaseFields);

  String? get rentClass => _rentClassController.value;
  String? get contractDate => _contractDateController.value;
  String? get paymentDate => _paymentDateController.value;
  String? get expirationDate => _expirationDateController.value;
  String? get price => _priceController.value;
  String? get deposit => _depositController.value;
  String? get tenantName => _tenantNameController.value;
  String? get tenantLastname => _tenantLastnameController.value;
  String? get tenantUsername => _tenantUsernameController.value;
  String? get tenantPhone => _tenantPhoneController.value;
  String? get tenantEmail => _tenantEmailController.value;

  // Stream<bool> get verifyLeaseData => CombineLatestStream.combine5(
  //     rentClassStream,
  //     contractDateStream,
  //     paymentDateStream,
  //     expirationDateStream,
  //     priceStream,
  //     (a, b, c, d, e) {});

  Stream<bool> get verifyLeaseData => CombineLatestStream([
        rentClassStream,
        contractDateStream,
        paymentDateStream,
        expirationDateStream,
        priceStream,
        depositStream,
        tenantNameStream,
        tenantLastnameStream,
        tenantUsernameStream,
        tenantPhoneStream,
        // tenantEmailStream
      ], (_) => true);

  Future getRentClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    var rentTypeJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/catalogs/rent-type/list'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final rentTypeParsed =
        json.decode(rentTypeJson.body).cast<Map<String, dynamic>>();

    return rentTypeParsed
        .map<RentClass>((json) => RentClass.fromJson(json))
        .toList();
  }

  Future<void> storeLease(var context, propertyId) async {
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
      var leaseJson = await http.post(
          Uri.parse(
              '${authEndpoint}api/v1/dashboard/properties/create-new-lease'),
          body: json.encode({
            "property_id": propertyId.toString(),
            "rent_type_id": rentClass,
            "contract_date": contractDate.toString(),
            "payment_date": paymentDate.toString(),
            "expiration_date": expirationDate.toString(),
            "price": price.toString(),
            "deposit": deposit.toString(),
            "tenant_name": tenantName.toString(),
            "tenant_lastname": tenantLastname.toString(),
            "tenant_username": tenantUsername.toString(),
            "tenant_phone": tenantPhone.toString(),
            "tenant_email": tenantEmail.toString(),
          }),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5),
          onTimeout: () => throw TimeoutException(
              'No se puede conectar, intente más tarde.'));
      Navigator.of(context).pop();

      if (leaseJson.statusCode > 400) {
        dynamic response = json.decode(leaseJson.body);
        return showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Atención"),
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
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text("Contrato ha sido guardado correctamente."),
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
    } catch (e) {
      Navigator.of(context).pop();
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

  dispose() {
    _contractDateController.close();
    _paymentDateController.close();
    _expirationDateController.close();
    _priceController.close();
  }
}
