import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theOne/api/apiCall.dart';
import 'package:theOne/api/screens/homeAPI.dart';
import 'package:theOne/api/screens/singinAPI.dart';
import 'package:http/http.dart' as http;

class SignUpAPI extends StatefulWidget {
  @override
  _SignUpAPIState createState() => _SignUpAPIState();
}

class _SignUpAPIState extends State<SignUpAPI> {
  final _formKey = GlobalKey<FormState>();
  late String name, email, password, contact, gender = "Male", address;
  late String? country = "India";

  bool isLoading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  TextEditingController _addressController = new TextEditingController();
  TextEditingController _contactController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
            child: Stack(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/peaky_blinders.jpg",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white.withOpacity(0.10),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.black87,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontSize: 23,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 45),
                          child: Column(
                            children: [
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _nameController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  name = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _emailController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  email = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  password = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                keyboardType: TextInputType.phone,
                                maxLength: 10,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')),
                                ],
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _contactController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Contact No.",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  contact = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: CountryListPick(
                                  theme: CountryTheme(
                                    isShowFlag: false,
                                    isShowTitle: true,
                                    isShowCode: false,
                                    isDownIcon: true,
                                    showEnglishName: true,
                                    labelColor: Colors.black,
                                  ),
                                  initialSelection: '+91',
                                  onChanged: (CountryCode? code) {
                                    country = code!.name;
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: _addressController,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintText: "Address.",
                                  hintStyle: TextStyle(
                                      color: Colors.white70, fontSize: 15),
                                ),
                                onSaved: (val) {
                                  address = val!;
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: DropdownButton<String>(
                                    value: gender,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    iconSize: 16,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        gender = newValue!;
                                      });
                                    },
                                    items: <String>['Male', 'Female', 'Other']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 50,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        if (isLoading) {
                                          return;
                                        }
                                        if (_nameController.text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Please Enter Name")));
                                        } else if (!reg
                                            .hasMatch(_emailController.text)) {
                                          scaffoldMessenger.showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      "Enter Valid Email")));
                                          return;
                                        } else if (_passwordController
                                                .text.isEmpty ||
                                            _passwordController.text.length <
                                                6) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Password should be min 6 characters")));

                                          return;
                                        } else if (_contactController
                                                .text.isEmpty ||
                                            _contactController.text.length <
                                                10) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Contact should be min 10 numbers")));
                                        } else if (_addressController
                                            .text.isEmpty) {
                                          scaffoldMessenger.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please fill in address")));
                                        } else {
                                          signup(
                                              _nameController.text,
                                              country,
                                              _addressController.text,
                                              _passwordController.text,
                                              _contactController.text,
                                              gender,
                                              _emailController.text);
                                        }
                                      },
                                      child: Text(
                                        "CREATE ACCOUNT",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                letterSpacing: 1)),
                                      ),
                                    ),
                                  ),
                                  Positioned(
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
                                        : Container(),
                                    right: 30,
                                    top: 0,
                                    bottom: 0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => SignInAPI()),
                        ),
                        child: Text(
                          "Already have an account?",
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  decoration: TextDecoration.underline,
                                  letterSpacing: 0.5)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signup(name, country, address, password, contact, gender, email) async {
    setState(() {
      isLoading = true;
    });
    print("calling");
    Map data = {
      "name": name,
      "country": country,
      "address": address,
      "password": password,
      "contact": contact,
      "gender": gender.toString().toUpperCase(),
      "email": email
    };
    print(data.toString());
    final response = await http.post(Uri.parse(ROOT), body: data);
    if (response.statusCode == 201) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      if (!responseBody["error"]) {
        Map<String, dynamic> user = responseBody['data'];
        print(" User name ${user['data']}");
        savePref(1, user['name'], user['email'], user['id']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeAPI()));
      } else {
        print(" ${responseBody['message']}");
      }
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text(" ${responseBody['message']}")));
    } else
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Please Try Again")));
  }

  savePref(int value, String name, String email, int id) async {
    Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
    final SharedPreferences preferences = await _preferences;

    preferences.setInt("key", value);
    preferences.setString("key", name);
    preferences.setString("key", email);
    preferences.setString("key", id.toString()).then((bool success) => null);
  }
}
