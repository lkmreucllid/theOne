import 'dart:convert';
import 'package:string_extensions/string_extensions.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/apiCall.dart';
import 'package:theOne/api/models/user_model.dart';
import 'package:theOne/api/screens/logoutAPI.dart';

import 'package:http/http.dart' as http;
import 'package:theOne/api/screens/singinAPI.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAPI extends StatefulWidget {
  HomeAPI();

  @override
  _HomeAPIState createState() => _HomeAPIState();
}

class _HomeAPIState extends State<HomeAPI> {
  bool _selected = false;
  bool _error = false;
  bool isLoading = false;
  final double _heightVal = 300;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formkey = GlobalKey<FormState>();
  late String? nameFilter, contactFilter;
  TextEditingController _nameFilterController = new TextEditingController();
  TextEditingController _contactFilterController = new TextEditingController();
  GlobalKey<ScaffoldState> _scafflodKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
        future: fetchAllUsers(
            _nameFilterController.text, _contactFilterController.text),
        builder: (BuildContext context, AsyncSnapshot userSnapshot) {
          return buildTile(context, userSnapshot);
        });
  }

  Future<List<User>?> fetchAllUsers(
      String? nameFilter, String? contactFilter) async {
    final SharedPreferences prefs = await _prefs;
    final bearer = prefs.getString('bearer');

    final response = await http.get(
      Uri.parse('$ROOT?name=$nameFilter&contact=$contactFilter'),
      headers: {'Authorization': 'Bearer $bearer'},
    );
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    if (responseBody['sucess'] == false) {
      setState(() {
        _error = true;
      });
      logout();
    }
    if (response.statusCode == 200) {
      isLoading = false;
      return allUsersFromAPI(jsonEncode(responseBody['data']));
    }
    return null;
  }

  logout() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    if (_error) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LogoutLoad()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (_) => SignInAPI()));
    }
  }

  Widget buildTile(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: FutureBuilder(
          future: getNameFromPref(),
          builder: (context, snapshot) {
            return Text("Logged in as: ${snapshot.data}");
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _error = false;
                });
                logout();
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFC71632),
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selected = !_selected;
                  });
                },
                child: AnimatedContainer(
                  color: Colors.blue,
                  duration: Duration(milliseconds: 500),
                  height: _selected ? _heightVal : 50,
                  width: MediaQuery.of(context).size.width,
                  child: showFilters(),
                ),
              ),
              Expanded(
                child: (isLoading)
                    ? Center(
                        child: Container(
                          height: 26,
                          width: 26,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, int index) {
                          return Column(
                            children: [
                              Card(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 12.0,
                                  ),
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
                                      borderRadius:
                                          BorderRadius.circular(22.0)),
                                  width: MediaQuery.of(context).size.width,
                                  child: InkWell(
                                    splashColor: Colors.blue.withAlpha(30),
                                    onTap: () {
                                      print("Tapped on Inkwell");
                                    },
                                    child: Column(
                                      children: [
                                        buildInnerRow("Name: ",
                                            "${snapshot.data[index].name}"),
                                        buildInnerRow("Email: ",
                                            "${snapshot.data[index].email.toString().capitalize()}"),
                                        buildInnerRow("Country: ",
                                            "${snapshot.data[index].country}"),
                                        buildInnerRow("Address: ",
                                            "${snapshot.data[index].address}"),
                                        buildInnerRow("Contact: ",
                                            "${snapshot.data[index].contact}"),
                                        buildInnerRow("Gender: ",
                                            "${snapshot.data[index].gender.toString().capitalize()}"),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 3.0,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buildInnerRow(String label, String value) {
    return Row(
      children: [
        Text(label),
        Text(value),
      ],
    );
  }

  Future<String?> getNameFromPref() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    final name = prefs.getString('name');
    return name;
  }

  Widget showFilters() {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scafflodKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: _heightVal,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.blueAccent,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Filter",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.filter_alt_outlined,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: _formkey,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 45,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameFilterController,
                              onSaved: (val) {
                                nameFilter = val!;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "name",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _contactFilterController,
                              onSaved: (val) {
                                contactFilter = val!;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "contact",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Stack(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }
                                    if (_nameFilterController.text.isNotEmpty ||
                                        _contactFilterController
                                            .text.isNotEmpty) {
                                      setState(() {
                                        _selected = false;
                                        isLoading = true;
                                        fetchAllUsers(
                                            _nameFilterController.text,
                                            _contactFilterController.text);
                                      });
                                    }
                                    setState(() {
                                      _selected = false;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Text(
                                      "Search",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              letterSpacing: 1)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
