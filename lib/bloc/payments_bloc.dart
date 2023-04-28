// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:home_management_app/validators/validators.dart';

class PaymentsBloc with Validators {
  final _paymentController = BehaviorSubject<String>();
  final _paymentTypeController = BehaviorSubject<String>();
  final _monthCancelledController = BehaviorSubject<String>();

  Function(String) get changePayment => _paymentController.sink.add;
  Function(String) get changePaymentType => _paymentTypeController.sink.add;
  Function(String) get changeMonthCancelled =>
      _monthCancelledController.sink.add;

  Stream<String> get paymentStream =>
      _paymentController.stream.transform(validatePayment);

  Stream<String> get paymentType =>
      _paymentTypeController.stream.transform(validatePaymentFields);

  Stream<String> get monthCancelled =>
      _monthCancelledController.stream.transform(validatePaymentFields);

  String? get getPayment => _paymentController.value;
  String? get getPaymentType => _paymentTypeController.value;
  String? get getMonthCancelled => _monthCancelledController.value;

  // Stream transformers
  Stream<bool> get verifyPaymentData =>
      CombineLatestStream.combine3(paymentStream, paymentType, monthCancelled,
          (a, b, c) {
        if ((a == _paymentController.value) &&
            (b == _paymentTypeController.value) &&
            (c == _monthCancelledController.value)) {
          return true;
        }
        return false;
      });

  Future obtenerMeses() async {
    List monthsList = [];
    for (int i = 1; i <= 12; i++) {
      String monthName = DateFormat('MMMM').format(DateTime(2022, i));
      monthsList.add({'id': i, 'label': monthName});
    }
    // print(monthsList);
    return monthsList;
  }

  Future getReceiptType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");

    var receiptTypeJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/catalogs/payment-type/list'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final receiptTypeParsed =
        json.decode(receiptTypeJson.body).cast<Map<String, dynamic>>();

    return receiptTypeParsed
        .map<PaymentType>((json) => PaymentType.fromJson(json))
        .toList();
  }

  dispose() {
    _paymentController.close();
    _paymentTypeController.close();
    _monthCancelledController.close();
  }

  paymentFieldsDispose() {
    changePayment('');
  }
}
