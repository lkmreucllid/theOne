import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../resources/shared_pref.dart';
import 'package:theOne/api/apiCall.dart';
import 'homeAPI.dart';
import 'singUpAPI.dart';
import 'package:http/http.dart' as http;

class SignInAPI extends StatefulWidget {
  @override
  _SignInAPIState createState() => _SignInAPIState();
}

class _SignInAPIState extends State<SignInAPI> {
  final _formkey = GlobalKey<FormState>();
  late String email, password;
  bool isLoading = false;
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  GlobalKey<ScaffoldState> _scafflodKey = GlobalKey();
  late ScaffoldMessengerState scaffoldMessenger;

  @override
  Widget build(BuildContext context) {
    scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      key: _scafflodKey,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.black,
          child: Stack(
            children: [
              Container(
                child: Image.asset(
                  "assets/images/peaky_blinders.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white.withOpacity(0.10),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
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
                      "Sign In",
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
                      key: _formkey,
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 45,
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              onSaved: (val) {
                                email = val!;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              obscureText: true,
                              controller: _passwordController,
                              onSaved: (val) {
                                password = val!;
                              },
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                hintText: "Password",
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
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    if (isLoading) {
                                      return;
                                    }

                                    if (_emailController.text.isEmpty ||
                                        _passwordController.text.isEmpty) {
                                      scaffoldMessenger.showSnackBar(SnackBar(
                                          content: Text(
                                              "Please Fill ina ll fields")));
                                    } else {
                                      login(_emailController.text,
                                          _passwordController.text, context);
                                      setState(() {
                                        isLoading = true;
                                      });
                                    }
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
                                      "SUBMIT",
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
                                              backgroundColor: Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  right: 30,
                                  bottom: 0,
                                  top: 0,
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
                    Text(
                      "OR",
                      style: TextStyle(fontSize: 14, color: Colors.white60),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpAPI()));
                      },
                      child: Text(
                        "Don't have an account?",
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
    );
  }

  login(email, password, context) async {
    Map data = {"email": email, "password": password};

    final response = await http.post(Uri.parse(LOGIN), body: data);
    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      Map<String, dynamic> user = responseBody['data'];
      if (responseBody['sucess'] != null) {
        print("User Name ${user['name']}");
        savePref(1, user['name'], user['email'], user['token'], user['_id']);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeAPI()));
      } else {
        print("${responseBody['sucess']}");
        logout(1, context);
      }
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      Map<String, dynamic> responseBody = jsonDecode(response.body);
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("${responseBody['message']}")));
    } else
      scaffoldMessenger
          .showSnackBar(SnackBar(content: Text("Please try again!")));
  }
}
