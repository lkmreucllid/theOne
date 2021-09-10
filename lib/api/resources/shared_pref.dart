import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/screens/logoutAPI.dart';
import 'package:theOne/api/screens/singinAPI.dart';

Future<String?> getNameFromPref() async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  final name = prefs.getString('name');
  return name;
}

logout(error, BuildContext context) async {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final SharedPreferences prefs = await _prefs;
  prefs.clear();
  if (error) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => LogoutLoad()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => SignInAPI()));
  }
}

savePref(int value, String name, String email, String bearer, String id) async {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  final SharedPreferences preferences = await _preferences;
  final now = DateTime.now();

  preferences.setInt("value", value);
  preferences.setString("name", name);
  preferences.setString("email", email);
  preferences.setString("bearer", bearer);
  preferences.setString("id", id.toString()).then((value) => null);
  preferences.setString("loginTime", now.toString());
}
