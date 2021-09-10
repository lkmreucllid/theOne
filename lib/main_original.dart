import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import 'package:theOne/pages/Options.dart';
import 'firebase/authentication_service.dart';
import 'pages/Home.dart';
import 'package:flutter/services.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

class Original extends StatelessWidget {
  Original() {
    init();
  }
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'theOne',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SafeArea(
          child: SplashScreen(
            seconds: 5,
            navigateAfterSeconds: new AuthenticationWrapper(),
            title: new Text('Welcome In SplashScreen'),
            image: new Image.asset('assets/images/moon_img_jpg.jpg'),
            backgroundColor: Colors.black,
            // styleTextUnderTheLoader: new TextStyle(),
            photoSize: MediaQuery.of(context).size.width * 0.60,
            useLoader: true,
            loaderColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final User? result = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return HomePage(result!.email);
    }
    return OptionsPage();
  }
}
