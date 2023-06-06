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
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'dart:io';

import 'package:home_management_app/validators/validators.dart';
import 'package:uuid/uuid.dart';

class LeaseBloc with Validators {
  final _rentTypeIdController = BehaviorSubject<String>();
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

  Function(String) get changeRentTypeId => _rentTypeIdController.sink.add;
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
}
