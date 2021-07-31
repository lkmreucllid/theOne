import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'Options.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:external_app_launcher/external_app_launcher.dart';

class IntroductionScreenPage extends StatefulWidget {
  @override
  _IntroductionScreenPageState createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  List<PageViewModel> listPagesViewModel = [
    PageViewModel(
      title: "Medium",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
          child: Image.network(
        "https://miro.medium.com/max/1200/1*jfdwtvU6V6g99q3G7gq7dQ.png",
        height: 175.0,
      )),
      decoration: const PageDecoration(pageColor: Color(0xffF3F4F4)),
      footer: ElevatedButton(
        onPressed: () async {
          await LaunchApp.openApp(
            androidPackageName: 'com.medium.reader',
            iosUrlScheme: 'pulsesecure://',
            appStoreLink:
                'https://play.google.com/store/apps/details?id=com.medium.reader',
            // openStore: false
          );
          // Enter thr package name of the App you  want to open and for iOS add the URLscheme to the Info.plist file.
          // The second arguments decide wether the app redirects PlayStore or AppStore.
          // For testing purpose you can enter com. instagram.android
        },
        child: const Text("Open Medium App"),
      ),
    ),
    PageViewModel(
      title: "Youtube",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
        child: Image.network(
            "https://cdn.mos.cms.futurecdn.net/8gzcr6RpGStvZFA2qRt4v6-1200-80.jpg",
            height: 175.0),
      ),
      decoration: const PageDecoration(pageColor: Color(0xFFFEFEFE)),
    ),
    PageViewModel(
      title: "Firebase",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
          child: Image.network(
              "https://firebase.google.com/downloads/brand-guidelines/PNG/logo-vertical.png",
              height: 175.0)),
      decoration: const PageDecoration(pageColor: Color(0xffF58411)),
    ),
    PageViewModel(
      title: "Stackoverflow",
      body:
          "Here you can write the description of the page, to explain someting...",
      image: Center(
          child: Image.network(
              "https://download.logo.wine/logo/Stack_Overflow/Stack_Overflow-Logo.wine.png",
              height: 175.0)),
      decoration: const PageDecoration(
        titleTextStyle: TextStyle(color: Colors.orange),
        bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
      ),
    ),
    PageViewModel(
        title: "Flutter",
        bodyWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Click on "),
            Icon(Icons.edit),
            Text(" to edit a post"),
          ],
        ),
        image: Center(
            child: Image.network(
                "https://flutter.dev/assets/flutter-lockup-1caf6476beed76adec3c477586da54de6b552b2f42108ec5bc68dc63bae2df75.png",
                height: 175.0)),
        decoration: const PageDecoration(pageColor: Color(0xFFE6E6E6)))
  ];

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: listPagesViewModel,
      onDone: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => OptionsPage()));
      },
      onSkip: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => OptionsPage()));
      },
      showSkipButton: true,
      skip: new IconTheme(
          data: new IconThemeData(color: Colors.black),
          child: new Icon(Icons.skip_next)),
      next: const Icon(Icons.forward_outlined),
      done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(5.0),
          activeSize: const Size(10.0, 5.0),
          activeColor: Colors.red.shade300,
          color: Colors.black26,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
  }
}
