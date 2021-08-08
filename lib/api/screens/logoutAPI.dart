import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theOne/api/screens/singinAPI.dart';

class LogoutLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoAlertDialog(
        title: Text("UnAuthorized User Detected!"),
        content: Text(
            "You will be logged out and redirected to Login Screen in 5 seconds"),
        actions: [
          TextButton(
              onPressed: () => {
                    Future.delayed(const Duration(milliseconds: 5000), () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignInAPI()));
                    })
                  },
              child: Text("Ok")),
        ],
      ),
    );
  }
}
