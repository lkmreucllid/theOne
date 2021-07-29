import 'package:flutter/material.dart';
import 'package:theOne/pages/SignIn.dart';
import 'package:theOne/pages/SignUp.dart';

class OptionsPage extends StatefulWidget {
  @override
  _OptionsPageState createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/signup.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black38,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignUpPage()));
                },
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12.0),
                        child: Text(
                          'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .button
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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => SignInPage()));
                },
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 12.0),
                        child: Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .button
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
              )
            ],
          ),
        ],
      ),
    );
  }
}
