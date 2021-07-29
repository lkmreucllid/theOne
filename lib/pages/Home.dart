import 'package:flutter/material.dart';
import 'package:theOne/authentication_service.dart';
import 'package:provider/provider.dart';
import '../sms/MyInbox.dart';

class HomePage extends StatefulWidget {
  final String uid;
  HomePage(this.uid);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFFDCDCDC),
      backgroundColor: Color(0xFFC71632),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Card(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                color: Color(0xFFFEFEFE),
                child: Center(
                    child: Column(
                  children: [
                    Text(
                      widget.uid,
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: Colors.black),
                    ),
                    Text(
                        'I will add the links to the functionalities i will be adding in the future'),
                  ],
                )),
              ),
            ),
            ElevatedButton(
              onPressed: null,
              child: Text('Take me to REST API'),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => MyInbox()));
              },
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
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
                        'Read My Messages',
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
                      Icons.message,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
            /*IconButton(
                onPressed: () {}, icon: const Icon(Icons.phone_callback)),*/
            ElevatedButton(
              onPressed: null,
              child: Text('Fetch My Contact List'),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     context.read<AuthenticationService>().signOut(context);
            //   },
            //   child: Text('Sign Out'),
            // ),
            InkWell(
              onTap: () {
                context.read<AuthenticationService>().signOut(context);
              },
              borderRadius: BorderRadius.circular(25.0),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 12.0),
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
                        'Sign Out',
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
                      Icons.logout_rounded,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
