import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:theOne/api/resources/users_db_provider.dart';

class ProfileEditor extends StatelessWidget {
  final String s;
  ProfileEditor(this.s);
  final UserDbProvider userDbProvider = new UserDbProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: userDbProvider.fetchUserDetail("$s"),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Container(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
            );
          }
          return Material(
            // type: MaterialType.transparency,
            child: SafeArea(
              child: Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 200,
                      ),
                      buildNamePlate("${snapshot.data.name}"),
                      additionalPlates("Email: ", "${snapshot.data.email}"),
                      additionalPlates("Country: ", "${snapshot.data.country}"),
                      additionalPlates("Address: ", "${snapshot.data.address}"),
                      additionalPlates("Contact: ", "${snapshot.data.contact}"),
                      additionalPlates("Gender: ", "${snapshot.data.gender}"),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildNamePlate(String name) {
    return Text(
      "$name",
      style: GoogleFonts.acme(
        textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: 1,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget additionalPlates(String label, String labelText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Colors.white,
              letterSpacing: 1,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: Text(
            "$labelText",
            maxLines: 3,
            softWrap: true,
            style: GoogleFonts.roboto(
              textStyle: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
