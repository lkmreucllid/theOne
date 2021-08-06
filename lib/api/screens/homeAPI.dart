import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/apiCall.dart';
import 'package:theOne/api/screens/singinAPI.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeAPI extends StatefulWidget {
  const HomeAPI({Key? key}) : super(key: key);

  @override
  _HomeAPIState createState() => _HomeAPIState();
}

class _HomeAPIState extends State<HomeAPI> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<dynamic> getName() async {
    final SharedPreferences prefs = await _prefs;
    final bearer = prefs.getString('bearer');
    final name = "";
    final contact = "";
    final userData = fetchAllUsers(bearer, " ", " ");
    // print("printing User Data");
    // print(userData.toString());
    return userData!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: getName(),
        builder: (BuildContext context, AsyncSnapshot itemSnapshot) {
          return Scaffold(
            body: buildTile(context, itemSnapshot),
          );
        });
  }

  fetchAllUsers(bearer, name, contact) async {
    final response = await http.get(
      Uri.parse('$ROOT?name= &contact= '),
      headers: {'Authorization': 'Bearer $bearer'},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      if (responseBody['sucess'] != null) {
        print('hello');
        return responseBody['data'];
      }
    }
  }

  logout() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    Navigator.push(context, MaterialPageRoute(builder: (_) => SignInAPI()));
  }

  Widget buildTile(BuildContext context, AsyncSnapshot snapshot) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            onTap: () {},
            title: Text("${snapshot.data[0]}"),
          ),
          Divider(
            height: 8.0,
          ),
          InkWell(
            onTap: logout,
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
              height: 50.0,
              width: 180.0,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(4.0, 4.0),
                      blurRadius: 15.0,
                      color: Colors.black12,
                      spreadRadius: 1.0,
                    ),
                    BoxShadow(
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      color: Colors.white,
                      spreadRadius: 1.0,
                    )
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22.0)),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 50.0,
                    width: 150.0,
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
                    child: Text(
                      'Sign Out',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .apply(color: Colors.white),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22.0),
                        topLeft: Radius.circular(22.0),
                        bottomRight: Radius.circular(200.0),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.login_outlined,
                    size: 20.0,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
