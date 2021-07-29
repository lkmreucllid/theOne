import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theOne/authentication_service.dart';
import 'package:theOne/pages/SignIn.dart';
import 'pages/Home.dart';
import 'pages/IntroductionScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        home: AnimatedSplashScreen(
          splash: Container(
            height: 1200.0,
            width: 640.0,
            child: Image.asset('lib/assets/manu_trans.jpg'),
          ),
          duration: 1000,
          nextScreen: AuthenticationWrapper(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Color(0xFFC71632),
          pageTransitionType: PageTransitionType.bottomToTop,
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final User result = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      return HomePage(result.email);
    }
    return SignInPage();
  }
}
