import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/page/home.dart';
import 'package:tester/widget/bottomNav.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  var currentIndex = 2;
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
          children: [Text('KODING DI SINI UNTUK SHOP PAGE')],
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
