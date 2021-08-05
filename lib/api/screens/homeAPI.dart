import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/screens/singinAPI.dart';

class HomeAPI extends StatefulWidget {
  const HomeAPI({Key? key}) : super(key: key);

  @override
  _HomeAPIState createState() => _HomeAPIState();
}

class _HomeAPIState extends State<HomeAPI> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getName(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Scaffold(
            body: Center(
              child: Container(
                color: Colors.white,
                child: Text(
                  "${snapshot.data}",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          );
        });
  }

  Future<String> getName() async {
    final SharedPreferences prefs = await _prefs;
    final name = prefs.getString('name');

    return name!;
  }

  Widget buildTile() {
    return Column(
      children: [
        ListTile(
          onTap: () {},
          title: Text("Text to be added Here"),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => SignInAPI()));
          },
          borderRadius: BorderRadius.circular(25.0),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
            height: 50.0,
            width: 180.0,
            decoration: BoxDecoration(boxShadow: [
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
            ], color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
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
    );
  }
}
