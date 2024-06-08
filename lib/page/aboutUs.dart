import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tester/page/profile.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/bio.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 30,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Gap(10),
                  GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(Icons.arrow_back_ios_new)),
                  Gap(140),
                  Text(
                    'About Us',
                    style: TextStyle(
                        fontWeight: semiBold, fontSize: 18, color: primary),
                  )
                ],
              ),
              Gap(60),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                ),
                child: Text(
                  'Selamat datang di Medaran solusi terbaik untuk manajemen penjualan dan inventaris toko Anda',
                  style: TextStyle(
                      fontWeight: semiBold, fontSize: 21, color: primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(40),
              CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
                radius: 40,
                backgroundColor: Colors.transparent,
              ),
              Container(
                height: 70,
                width: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/textL2.png'),
                      fit: BoxFit.cover,
                      alignment: Alignment.center),
                ),
              ),
              Gap(30),
              Text(
                'Our Team',
                style: TextStyle(
                    fontWeight: medium, fontSize: 10, color: secondary),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Say Hello to awesome Squad founder of medaran app',
                  style: TextStyle(
                      fontWeight: semiBold, fontSize: 21, color: primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: 'Rafi',
                        role: 'Designer',
                        desk: 'Founder Of Design For UI/UX, flow system'),
                    Gap(5),
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: 'Zamri',
                        role: 'Frontend',
                        desk:
                            'Founder of frontend, design app, code writing, UI/UX'),
                    Gap(5),
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: 'Tama',
                        role: 'Designer',
                        desk: 'Founder Of Design For UI/UX, flow system'),
                  ],
                ),
              ),
              Gap(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: 'Krisna',
                        role: 'System Analytic',
                        desk:
                            'Founder of system analytic, testing app, add feature'),
                    Gap(5),
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: 'Danu',
                        role: 'Backend',
                        desk:
                            'Founder of backend, create database, make RestAPI'),
                    Gap(5),
                    Bio(
                        Foto: 'assets/logo.png',
                        nama: '??',
                        role: '??',
                        desk: '??'),
                  ],
                ),
              ),
              Gap(60),
              Text(
                'About App',
                style: TextStyle(
                    fontWeight: semiBold, fontSize: 21, color: primary),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Selamat datang di Medaran Cashier, solusi terbaik untuk manajemen penjualan dan inventaris toko Anda. Kami adalah perusahaan teknologi yang berdedikasi untuk membantu bisnis kecil dan menengah meningkatkan efisiensi operasional dan pelayanan pelanggan mereka melalui teknologi kasir yang canggih dan mudah digunakan.',
                  style: TextStyle(
                      fontWeight: light, fontSize: 14, color: primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(30),
              Text(
                'Vision',
                style: TextStyle(
                    fontWeight: semiBold, fontSize: 21, color: primary),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Kami berkomitmen untuk menjadi mitra terpercaya bagi para pelaku usaha dengan menyediakan alat manajemen penjualan yang inovatif dan handal, yang dapat membantu mereka mengembangkan bisnis dan mencapai kesuksesan.',
                  style: TextStyle(
                      fontWeight: light, fontSize: 14, color: primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(30),
              Text(
                'Feature',
                style: TextStyle(
                    fontWeight: semiBold, fontSize: 21, color: primary),
              ),
              Gap(5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Kami berkomitmen untuk menjadi mitra terpercaya bagi para pelaku usaha dengan menyediakan alat manajemen penjualan yang inovatif dan handal, yang dapat membantu mereka mengembangkan bisnis dan mencapai kesuksesan.',
                  style: TextStyle(
                      fontWeight: light, fontSize: 14, color: primary),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(30),
              Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(color: primary),
                child: Column(
                  children: [
                    Text(
                      'Contact Us',
                      style: TextStyle(
                          color: white, fontSize: 14, fontWeight: semiBold),
                    ),
                    Gap(30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email : support@medarancashier.com ',
                          style: TextStyle(
                              color: white, fontSize: 14, fontWeight: semiBold),
                        ),
                        Gap(10),
                        Text(
                          'Telpon : 081234567891',
                          style: TextStyle(
                              color: white, fontSize: 14, fontWeight: semiBold),
                        ),
                        Gap(10),
                        Text(
                          'Alamat : JL. Pemuda No. 1, Mataram, NTB',
                          style: TextStyle(
                              color: white, fontSize: 14, fontWeight: semiBold),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
