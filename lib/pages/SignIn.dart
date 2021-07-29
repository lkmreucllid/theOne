import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:theOne/authentication_service.dart';

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
                  borderRadius: BorderRadius.circular(22.0),
                ),
                child: TextField(
                  controller: emailController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'email',
                    fillColor: Color(0xFFC71632),
                  ),
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'password',
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // ignore: unnecessary_statements
                  context.read<AuthenticationService>().signIn(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                      context);
                },
                child: Text('Sign In'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
