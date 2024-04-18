import 'dart:async';

import 'package:flutter/material.dart';
import '../page/login.dart';
import '../theme/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Image(
            image: AssetImage('assets/logo.png'),
            height: 221,
            width: 235,
          ),
        ),
        decoration: BoxDecoration(
          color: primary,
        ),
      ),
    );
  }
}
