import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:theOne/api/screens/homeAPI.dart';
import 'package:theOne/api/screens/singinAPI.dart';
import 'package:flutter/services.dart';

//This is the file to add Api authentications, else main_original is the main file
void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

var _loginStatus = 0;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text(
        'Ad Astra',
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      image: new Image.asset('assets/images/moon_img_jpg.jpg'),
      backgroundColor: Colors.black,
      // styleTextUnderTheLoader: new TextStyle(),
      photoSize: MediaQuery.of(context).size.width * 0.60,
      useLoader: true,
      loaderColor: Colors.white,
    );
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      final now = DateTime.now();
      final loginTime = preferences.getString("loginTime")!;
      if (now.difference(DateTime.parse(loginTime)).inHours <= 24) {
        _loginStatus = preferences.getInt("value")!;
      }
    });
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
          ),
          (_loginStatus == 1) ? HomeAPI() : SignInAPI(),
        ],
      ),
    );
  }
}
