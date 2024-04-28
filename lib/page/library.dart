import 'package:flutter/material.dart';
import 'package:tester/page/home.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:get/get.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var currentIndex = 1;

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
          children: [Text('KODING DI SINI UNTUK LIBRARY PAGE')],
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
