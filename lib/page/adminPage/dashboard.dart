import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tester/page/adminPage/addProduct.dart';
import 'package:tester/page/login.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/dahsboardCard.dart';

import '../../controller/controller.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(top: 60, left: 30, right: 30),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                            child: Icon(
                          Icons.account_circle_outlined,
                          size: 56,
                        )),
                        Gap(16),
                        Column(
                          children: [
                            Text(
                              '${userController.userData['username']}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: semiBold,
                                color: primary,
                              ),
                            ),
                            Text(
                              '${userController.userData['role']}',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: regular,
                                color: secondarytext,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.off(Login());
                      },
                      child: Icon(
                        Icons.logout,
                        color: logout,
                      ),
                    )
                  ],
                ),
                Gap(10),
                Text(
                  'Dashboar ',
                  style: TextStyle(
                      fontSize: 21, fontWeight: semiBold, color: primary),
                ),
                Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashboardCard(
                        onTap: () {},
                        text: 'List \nProduct',
                        backgroundColor: primary,
                        icon: Icons.shop_2_outlined,
                        iconColor: selected),
                    Gap(10),
                    DashboardCard(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UploadProductPage()));
                        },
                        text: 'Upload Product',
                        backgroundColor: primary2,
                        icon: Icons.shop_2_outlined,
                        iconColor: icon),
                  ],
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DashboardCard(
                        onTap: () {},
                        text: 'Management Product',
                        backgroundColor: primary2,
                        icon: Icons.manage_search,
                        iconColor: icon),
                    Gap(10),
                    DashboardCard(
                        onTap: () {},
                        text: 'All Transaction',
                        backgroundColor: primary3,
                        icon: Icons.list_alt_rounded,
                        iconColor: selected),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primary4,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'About Us',
                            style: TextStyle(
                                fontSize: 21, color: white, fontWeight: bold),
                          ),
                          Gap(5),
                          CircleAvatar(
                            radius: 36,
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage('assets/logo.png'),
                          ),
                          Gap(10),
                          Text(
                            'Kami Medaran, menawarkan list produk makanan dengan cita rasa khas daerah, dan harga terjangkau',
                            style: TextStyle(
                              fontSize: 18,
                              color: white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Gap(21),
                          Text(
                            'Special Thanks',
                            style: TextStyle(
                                fontSize: 21, color: white, fontWeight: bold),
                          ),
                          Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 21,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/icon/milo.png'),
                              ),
                              Gap(21),
                              CircleAvatar(
                                radius: 21,
                                backgroundImage:
                                    AssetImage('assets/icon/mu.png'),
                              ),
                            ],
                          ),
                          Gap(10)
                        ],
                      ),
                    )
                  ],
                ),
                Gap(30)
              ],
            ),
          )),
    );
  }
}
