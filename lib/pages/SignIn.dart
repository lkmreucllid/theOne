import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:theOne/authentication_service.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: 'email',
            ),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: 'password',
            ),
          ),
          RaisedButton(
            onPressed: () {
              // ignore: unnecessary_statements
              context.read<AuthenticationService>().signIn(
                  emailController.text.trim(), passwordController.text.trim());
            },
            child: Text('Sign In'),
          )
        ],
      ),
    );
  }
}
