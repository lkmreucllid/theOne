import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:theOne/authentication_service.dart';
import 'package:theOne/pages/SignUp.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: TextField(
                  controller: emailController,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.person,
                      color: Colors.red,
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'email',
                    fillColor: Color(0xFFC71632),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                padding: EdgeInsets.only(left: 25.0, right: 25.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(
                      Icons.lock,
                      color: Colors.red,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility),
                      color: Colors.red,
                      onPressed: () {
                        CupertinoAlertDialog(content: Text('Coming Soon!'));
                      },
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'password',
                    fillColor: Color(0xFFC71632),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<AuthenticationService>().signIn(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      context);
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t Have and Account? ',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpPage())),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
