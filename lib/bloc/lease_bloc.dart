// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/models/PaymentClass.dart';
import 'package:home_management_app/modules/property/models/RentClass.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:home_management_app/modules/property/screens/property_details.dart';
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
  final _paymentClassController = BehaviorSubject<String>();
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
  final _leaseTerminationCommentsController = BehaviorSubject<String>();

  Function(String) get changeRentClass => _rentClassController.sink.add;
  Function(String) get changePaymentClass => _paymentClassController.sink.add;
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
  Function(String) get changeLeaseTerminationComments =>
      _leaseTerminationCommentsController.sink.add;

  Stream<String> get rentClassStream =>
      _rentClassController.stream.transform(validateLeaseFields);
  Stream<String> get paymentClassStream =>
      _paymentClassController.stream.transform(validateLeaseFields);
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
  Stream<String> get leaseTerminationCommentsStream =>
      _leaseTerminationCommentsController.stream.transform(validateLeaseFields);

  String? get rentClass => _rentClassController.value;
  String? get paymentClass => _paymentClassController.value;
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
  String? get leaseTerminationComments =>
      _leaseTerminationCommentsController.value;

  Stream<bool> get verifyEditLeaseFields => CombineLatestStream([
        rentClassStream,
        //  paymentClassStream,
        contractDateStream,
        paymentDateStream,
        expirationDateStream,
        //  priceStream,
      ], (_) => true);

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
        paymentClassStream,
        // tenantEmailStream
      ], (_) => true);

  Stream<bool> get verifyLeaseComments =>
      leaseTerminationCommentsStream.map((comments) => true);

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

  Future getPaymentClass() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    var paymentClassJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/catalogs/payment-class/list'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final paymentClassParsed =
        json.decode(paymentClassJson.body).cast<Map<String, dynamic>>();

    return paymentClassParsed
        .map<PaymentClass>((json) => PaymentClass.fromJson(json))
        .toList();
  }

  Future<void> storeLease(var context, propertyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userEmail = '';
    _tenantEmailController.stream.listen((tenantEmail) {
      // You can access the email value here
    });
    if (_tenantEmailController.hasValue) {
      userEmail = tenantEmail.toString();
    }
    final accessToken = prefs.getString("access_token");
    CustomDialogs.loadingDialog(
        context, "Almacenando contrato, espere un momento por favor");
    try {
      var leaseJson = await http.post(
          Uri.parse(
              '${authEndpoint}api/v1/dashboard/properties/create-new-lease'),
          body: json.encode({
            "property_id": propertyId.toString(),
            "rent_type_id": rentClass,
            "payment_class_id": paymentClass,
            "contract_date": contractDate.toString(),
            "payment_date": paymentDate.toString(),
            "expiration_date": expirationDate.toString(),
            "price": price.toString(),
            "deposit": deposit.toString(),
            "tenant_name": tenantName.toString(),
            "tenant_lastname": tenantLastname.toString(),
            "tenant_username": tenantUsername.toString(),
            "tenant_phone": tenantPhone.toString(),
            "tenant_email": userEmail,
          }),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'No se puede conectar, verifique su conexión a internet e intente más tarde.');
      });
      Navigator.of(context).pop();

      if (leaseJson.statusCode > 400) {
        dynamic response = json.decode(leaseJson.body);
        CustomDialogs.fatalErrorDialog(context, response['message']);
      }
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              surfaceTintColor: Colors.white,
              content: Text("Contrato ha sido guardado correctamente."),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            );
          });
    } catch (e) {
      Navigator.of(context).pop();
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  Future<void> downloadLeaseContract(context, leaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    final dio = Dio();

    CustomDialogs.loadingDialog(
        context, "Descargando contrato, espere un momento por favor");

    try {
      Directory dir = Directory('/storage/emulated/0/Download');
      var savePath = dir.path;

      var uuid = Uuid();

      var fileName = "lofty_contrato_alquiler_${uuid.v1().toString()}.pdf";
      var response = await dio.download(
        '${authEndpoint}api/v1/property/lease/$leaseId/print',
        savePath + '/${fileName}',
        //  data: {"payment_id": receiptId.toString()},
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
          method: 'POST',
        ),
      );

      Navigator.of(context).pop();

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text("Contrato ha sido descargado correctamente."),
              surfaceTintColor: Colors.white,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Aceptar",
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            );
          });
    } catch (e) {
      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
      });

      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  Future<void> endLease(leaseId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    try {
      var leaseJson = await http.delete(
          Uri.parse(
              '${authEndpoint}api/v1/property/lease/$leaseId/termination'),
          body: json.encode({'comments': leaseTerminationComments.toString()}),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'No se puede conectar, verifique su conexión a internet e intente más tarde.');
      });
      Navigator.of(context).pop();
      if (leaseJson.statusCode > 400) {
        dynamic response = json.decode(leaseJson.body);
        Exception(Text(response['message'].toString()));
      }

      CustomDialogs.infoDialog(
          context, "Atención", "Contrato ha sido marcado como finalizado");
    } catch (e) {
      Navigator.of(context).pop();
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  Future<void> updateLease(leaseId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    CustomDialogs.loadingDialog(
        context, "Procesando, espere un momento por favor");
    try {
      var leaseJson = await http.patch(
          Uri.parse('${authEndpoint}api/v1/property/lease/${leaseId}/details'),
          body: json.encode({
            "rent_type_id": rentClass.toString(),
            "payment_class_id": paymentClass.toString(),
            "contract_date": contractDate.toString(),
            //    "payment_date": paymentDate.toString(),
            "expiration_date": expirationDate.toString(),
            //    "price": price.toString(),
          }),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5), onTimeout: () {
        Navigator.of(context).pop();
        throw TimeoutException(
            'No se puede conectar, verifique su conexión a internet e intente más tarde.');
      });
      Navigator.of(context).pop();

      if (leaseJson.statusCode > 400) {
        dynamic response = json.decode(leaseJson.body);

        throw Exception(Text(response['message'].toString()));
      }
      Navigator.of(context).pop();
      CustomDialogs.infoDialog(
          context, "Atención", "Contrato actualizado correctamente");
    } catch (e) {
      Navigator.of(context).pop();
      CustomDialogs.fatalErrorDialog(context, e);
    }
  }

  dispose() {
    _rentClassController.close();
    _paymentClassController.close();
    _contractDateController.close();
    _paymentDateController.close();
    _expirationDateController.close();
    _priceController.close();
    _depositController.close();
    _tenantNameController.close();
    _tenantLastnameController.close();
    _tenantUsernameController.close();
    _tenantPhoneController.close();
    _tenantEmailController.close();
    _leaseTerminationCommentsController.close();
  }
}
