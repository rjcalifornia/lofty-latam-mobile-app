import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static SharedPreferences? _preferences;
  static const _keyDisplayName = 'first_name';
  static const _keyLastName = 'last_name';
  static const _keyRolType = 'role_name';
  static const _keyAccessToken = 'access_token';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setDisplayName(String displayName) async =>
      await _preferences!.setString(_keyDisplayName, displayName);

  static Future setLastName(String lastName) async =>
      await _preferences!.setString(_keyLastName, lastName);

  static Future setRolType(String rolType) async =>
      await _preferences!.setString(_keyRolType, rolType);

  static Future setAccessToken(String accessToken) async =>
      await _preferences!.setString(_keyAccessToken, accessToken);

  static String? getDisplayName() => _preferences!.getString(_keyDisplayName);

  static String? getFullName() =>
      "${_preferences!.getString(_keyDisplayName)}  ${_preferences!.getString(_keyLastName)}";

  static String? getRolType() => _preferences!.getString(_keyRolType);

  static String? getAccessToken() => _preferences!.getString(_keyAccessToken);
}
