import 'package:home_management_app/models/Lease.dart';
import 'package:home_management_app/models/PaymentsDetails.dart';
import 'package:home_management_app/models/Property.dart';
import 'package:home_management_app/config/env.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PropertiesBloc {
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
