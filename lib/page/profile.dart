import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/page/aboutUs.dart';
import 'package:tester/page/home.dart';
import 'package:tester/page/autentification/login.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:get/get.dart';
import 'package:tester/widget/popDialog.dart';

import '../controller/controller.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final UserController userController = Get.find();
  var currentIndex = 3;
  @override
  Widget build(BuildContext context) {
    final cController = Get.put(MyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 60),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: secondary, width: 1),
              color: white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30, top: 100)),
                      Icon(
                        Icons.account_circle_outlined,
                        size: 60,
                        color: secondarytext,
                      ),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userController.userData['username']}',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: semiBold,
                                color: primary),
                          ),
                          Text(
                            '${userController.userData['email']}',
                          )
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    color: secondary,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30, top: 50)),
                      Icon(
                        Icons.account_circle_outlined,
                        size: 30,
                        color: primary,
                      ),
                      Gap(20),
                      Text('Profile')
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(aboutUs()),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30, top: 50)),
                        Icon(
                          Icons.error_outline,
                          size: 30,
                          color: primary,
                        ),
                        Gap(20),
                        Text('Tentang Kami')
                      ],
                    ),
                  ),
                  Divider(
                    color: secondary,
                    thickness: 1,
                  ),
                  GestureDetector(
                    onTap: () => Get.off(Login()),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30, top: 50)),
                        Icon(Icons.exit_to_app_rounded,
                            size: 30, color: Colors.red[700]),
                        Gap(20),
                        GestureDetector(
                            onTap: () => _outDialog(context),
                            child: Text('Log Out')),
                      ],
                    ),
                  ),
                ],
              ),
              Image(image: AssetImage('assets/textL.png'))
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: cController.index,
          onItemTapped: (index) {
            cController.index.value = index;
          }),
    );
  }

//dialog log out
  void _outDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialoguu(
            alert: 'Log Out',
            pesan: 'Yakin Ingin Logout',
            btn: 'Log Out',
            onPressed: () {
              Get.offAll(Login());
            });
      },
    );
  }
}
