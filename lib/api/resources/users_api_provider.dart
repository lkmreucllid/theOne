import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/resources/shared_pref.dart';
import 'dart:convert';
import '../models/user_model.dart';
import '../apiCall.dart';
import 'users_db_provider.dart';

class UserApiProvider {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  UserDbProvider userDbProvider = new UserDbProvider();
  Future<List<User>?> fetchAllUsers(
      String? _nameFilter, String? _contactFilter, BuildContext context) async {
    print('Called API');
    final SharedPreferences prefs = await _prefs;
    final bearer = prefs.getString("bearer");
    final response = await http.get(
      Uri.parse('$ROOT'),
      headers: {'Authorization': 'Bearer $bearer'},
    );
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['sucess'] == false) {
      logout(true, context);
    }
    if (response.statusCode == 200) {
      userDbProvider.clear();

      allUsersFromAPI(jsonEncode(responseBody['data'])).forEach(
        (element) {
          userDbProvider.addIntoDb(element);
        },
      );
    }
    return userDbProvider.fetchAllUsers(_nameFilter, _contactFilter, context);
  }

  checkLogin(context) async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final bearer = prefs.getString("bearer");
    final response = await http.get(
      Uri.parse('$ROOT'),
      headers: {'Authorization': 'Bearer $bearer'},
    );
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['sucess'] == false) {
      logout(true, context);
    }
  }
}
