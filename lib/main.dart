import 'package:flutter/material.dart';
import 'package:tester/page/home.dart';
import 'package:tester/page/library.dart';
import 'package:tester/page/profile.dart';
import 'package:tester/page/shop.dart';
import 'package:tester/page/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashPage(),
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
