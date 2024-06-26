import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:Medaran/page/aboutUs.dart';
import 'package:Medaran/page/home.dart';
import 'package:Medaran/page/autentification/login.dart';
import 'package:Medaran/theme/theme.dart';
import 'package:Medaran/widget/bottomNav.dart';
import 'package:get/get.dart';
import 'package:Medaran/widget/popDialog.dart';

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
                        color: primary,
                      ),
                      Gap(20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userController.userData['username']}',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: semiBold,
                                color: primary),
                          ),
                          Text(
                            '${userController.userData['email']}',
                            style: TextStyle(
                                color: primary,
                                fontSize: 16,
                                fontStyle: FontStyle.italic),
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
                      Text(
                        'Profile',
                        style: TextStyle(
                            color: primary, fontSize: 16, fontWeight: semiBold),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () => Get.to(aboutUs()),
                    child: Row(
                      children: [
                        Padding(padding: EdgeInsets.only(left: 30, top: 50)),
                        Icon(
                          Icons.error_outline,
                          size: 29,
                          color: primary,
                        ),
                        Gap(20),
                        Text(
                          'Tentang Kami',
                          style: TextStyle(
                              color: primary,
                              fontSize: 16,
                              fontWeight: semiBold),
                        )
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
                            size: 28, color: Colors.red[700]),
                        Gap(20),
                        GestureDetector(
                            onTap: () => _outDialog(context),
                            child: Text(
                              'Log Out',
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 16,
                                  fontWeight: semiBold),
                            )),
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
