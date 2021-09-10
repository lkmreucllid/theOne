import 'package:flutter/services.dart';

import 'package:string_extensions/string_extensions.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theOne/api/resources/users_db_provider.dart';
import 'package:theOne/api/screens/profile/profile.dart';
import '../resources/shared_pref.dart';
import '../resources/users_api_provider.dart';

class HomeAPI extends StatefulWidget {
  HomeAPI();

  @override
  _HomeAPIState createState() => _HomeAPIState();
}

class _HomeAPIState extends State<HomeAPI> {
  late String? nameFilter, contactFilter;
  late ScaffoldMessengerState scaffoldMessenger;
  //bool showHideBar = false;
  UserApiProvider userApiProvider = UserApiProvider();
  UserDbProvider userDbProvider = UserDbProvider();

  TextEditingController _contactFilterController = new TextEditingController();
  bool _error = false;
  final _formkey = GlobalKey<FormState>();
  //bool isLoading = false;
  final double _heightVal = 200;

  TextEditingController _nameFilterController = new TextEditingController();
  GlobalKey<ScaffoldState> _scafflodKey = GlobalKey();
  bool _selected = false;

  Widget buildTile(BuildContext context, AsyncSnapshot snapshot) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black87,
            title: FutureBuilder(
              future: getNameFromPref(),
              builder: (context, snapshot) {
                return Text(
                  "In as: ${snapshot.data}",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: 18,
                    ),
                  ),
                );
              },
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await userApiProvider.fetchAllUsers(
                      _nameFilterController.text,
                      _contactFilterController.text,
                      context);
                  userDbProvider.fetchAllUsers(_nameFilterController.text,
                      _contactFilterController.text, context);
                  setState(() {
                    _selected = false;
                  });
                },
                icon: Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _selected = !_selected;
                  });
                },
                icon: Icon(Icons.filter_alt_outlined),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _error = false;
                  });
                  logout(_error, context);
                },
                icon: Icon(Icons.exit_to_app_sharp),
              ),
            ],
          ),
          body: SafeArea(
            bottom: false,
            child: Container(
              color: Colors.black,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                      height: _selected ? _heightVal : 0,
                      width: MediaQuery.of(context).size.width,
                      child: showFilters(),
                    ),
                  ),
                  Flexible(
                    child: (!snapshot.hasData)
                        ? Center(
                            child: Container(
                              height: 26,
                              width: 26,
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          )
                        : RefreshIndicator(
                            onRefresh: () async {
                              await userApiProvider.fetchAllUsers(
                                  _nameFilterController.text,
                                  _contactFilterController.text,
                                  context);
                              await userDbProvider.fetchAllUsers(
                                  _nameFilterController.text,
                                  _contactFilterController.text,
                                  context);
                              setState(() {
                                _selected = false;
                              });
                            },
                            child: ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, int index) {
                                return Column(
                                  children: [
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.0,
                                          vertical: 10.0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: InkWell(
                                          splashColor:
                                              Colors.blue.withAlpha(30),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => ProfileEditor(
                                                        "${snapshot.data[index].email.toString().capitalize()}")));
                                            /*  if (showHideBar) {
                                                SystemChrome
                                                    .setEnabledSystemUIOverlays(
                                                        [SystemUiOverlay.top]);
                                              } else {
                                                SystemChrome
                                                    .setEnabledSystemUIOverlays(
                                                        SystemUiOverlay.values);
                                              }*/
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  buildInnerRow(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Flexible(
            child: Text(value,
                maxLines: 3,
                softWrap: true,
                style: TextStyle(
                  color: Colors.white,
                ))),
      ],
    );
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
                decoration: BoxDecoration(
                  color: Colors.black87,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                              onChanged: (val) {
                                setState(() {
                                  //  isLoading = true;
                                });
                                userDbProvider.fetchAllUsers(
                                    _nameFilterController.text,
                                    _contactFilterController.text,
                                    context);
                              },
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
                              onChanged: (val) {
                                nameFilter = val;
                                setState(() {
                                  //  isLoading = true;
                                });
                                userDbProvider.fetchAllUsers(
                                    _nameFilterController.text,
                                    _contactFilterController.text,
                                    context);
                              },
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

  @override
  Widget build(context) {
    final userStream = userDbProvider
        .fetchAllUsers(
            _nameFilterController.text, _contactFilterController.text, context)
        .asStream();

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            userApiProvider.checkLogin(context);
          }
          return buildTile(context, snapshot);
        });
  }
}
