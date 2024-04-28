import 'package:flutter/material.dart';
import 'package:tester/page/home.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:get/get.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    final cController = Get.put(MyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: Column(
          children: [Text('KODING DI SINI UNTUK PROFILE PAGE')],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: cController.index,
          onItemTapped: (index) {
            cController.index.value = index;
          }),
    );
  }
}
