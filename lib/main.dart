import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/firebase/firebase_options.dart';
import 'package:tester/page/home.dart';
import 'package:tester/page/library.dart';
import 'package:tester/page/profile.dart';
import 'package:tester/page/shop.dart';
import 'package:tester/page/splash.dart';
import 'package:tester/firebase/utils.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.appAttest,
  );
  await signInUserAnon();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashPage(),
        '/home': (context) => Home(),
        '/shop': (context) => ShopPage(),
        '/library': (context) => Library(),
        '/profil': (context) => Profile(),
      },
    );
  }
}
