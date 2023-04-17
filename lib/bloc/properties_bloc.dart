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
