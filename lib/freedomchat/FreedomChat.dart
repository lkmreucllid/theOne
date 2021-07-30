import 'package:flutter/material.dart';
import 'package:theOne/freedomchat/screens/welcome/welcom_screen.dart';
import 'package:theOne/theme.dart';

class FreedomChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freedom Chat',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: WelcomeScreen(),
    );
  }
}
