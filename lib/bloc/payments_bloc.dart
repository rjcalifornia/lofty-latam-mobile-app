// ignore_for_file: unused_local_variable, prefer_const_constructors, unused_import, unnecessary_brace_in_string_interps, prefer_interpolation_to_compose_strings
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/global.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/ui/screens/app.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'dart:io';
//import 'package:path_provider/path_provider.dart';

import 'package:home_management_app/validators/validators.dart';
import 'package:uuid/uuid.dart';

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

  Stream<String> get paymentTypeStream =>
      _paymentTypeController.stream.transform(validatePaymentFields);

  Stream<String> get monthCancelledStream =>
      _monthCancelledController.stream.transform(validatePaymentFields);

  String? get payment => _paymentController.value;
  String? get paymentType => _paymentTypeController.value;
  String? get monthCancelled => _monthCancelledController.value;

  // Stream transformers
  Stream<bool> get verifyPaymentData => CombineLatestStream.combine3(
          paymentStream, paymentTypeStream, monthCancelledStream, (a, b, c) {
        if ((a == _paymentController.value) &&
            (b == _paymentTypeController.value) &&
            (c == _monthCancelledController.value)) {
          return true;
        }
        return false;
      });

  Future obtenerMeses() async {
    await initializeDateFormatting('es');
    List monthsList = [];
    for (int i = 1; i <= 12; i++) {
      String monthName = DateFormat('MMMM', 'es').format(DateTime(2022, i));
      monthName = '${monthName[0].toUpperCase()}${monthName.substring(1)}';
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

  Future<void> generateReceipt(var context, leaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    try {
      var paymentJson = await http
          .post(Uri.parse('${authEndpoint}api/v1/payments/store-rent-payment'),
              body: json.encode({
                "payment_type_id": paymentType.toString(),
                "month_cancelled": monthCancelled.toString(),
                "payment": payment.toString(),
                "lease_id": leaseId.toString(),
              }),
              headers: {
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json",
            'Authorization': 'Bearer $accessToken',
          }).timeout(const Duration(seconds: 5),
              onTimeout: () => throw TimeoutException(
                  'No se puede conectar, intente más tarde.'));

      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Atención"),
              content: Text("Recibo ha sido generado correctamente."),
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

  Future<void> downloadReceipt(context, receiptId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    final dio = Dio();

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
      Directory dir = Directory('/storage/emulated/0/Download');
      var savePath = dir.path;

      var uuid = Uuid();

      var fileName = "lofty_recibo_${uuid.v1().toString()}.pdf";
      var response = await dio.download(
        '${authEndpoint}api/v1/payments/print-receipt',
        savePath + '/${fileName}',
        data: {"payment_id": receiptId.toString()},
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
              content: Text("Recibo ha sido descargado correctamente."),
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
      Future.delayed(Duration(seconds: 2)).then((_) {
        Navigator.of(context).pop();
      });
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
      //print('Error downloading receipt: $e');
    }
  }

  Future getPaymentNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    var notificationsJson = await http.get(
        Uri.parse('${authEndpoint}api/v1/notifications/payments/status'),
        headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $accessToken',
        });

    final notificationsList = json.decode(notificationsJson.body);
    return notificationsList;
  }

  dispose() {
    _paymentController.close();
    _paymentTypeController.close();
    _monthCancelledController.close();
  }

  paymentFieldsDispose() {
    changePayment('');
    changePaymentType('');
    changeMonthCancelled('');
  }
}
