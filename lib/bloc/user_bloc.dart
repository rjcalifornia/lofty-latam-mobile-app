import 'package:home_management_app/config/env.dart';
import 'package:home_management_app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:home_management_app/validators/validators.dart';

class UserBloc with Validators {
  Future getUserInformation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
    try {
      var paymentJson = await http.get(
          Uri.parse('${authEndpoint}api/v1/administration/user/profile'),
          headers: {
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
}
