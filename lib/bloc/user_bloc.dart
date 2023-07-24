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

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeLastname => _lastnameController.sink.add;

  Stream<String> get nameStream =>
      _nameController.stream.transform(simpleValidation);
  Stream<String> get lastnameStream =>
      _lastnameController.stream.transform(simpleValidation);

  String? get name => _nameController.value;
  String? get lastname => _lastnameController.value;

  Stream<bool> get verifyFullName =>
      CombineLatestStream.combine2(nameStream, lastnameStream, (a, b) {
        if ((a == _nameController.value) && (b == _lastnameController.value)) {
          return true;
        }
        return false;
      });

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

  Future<void> updateName(var context, leaseId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("access_token");
  }
}
