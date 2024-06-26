import 'package:Medaran/widget/sparator.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:Medaran/theme/theme.dart';
import 'package:Medaran/widget/bio.dart';

class aboutUs extends StatelessWidget {
  const aboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 53,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: secondary, width: 1),
                  color: white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back_ios)),
                  Gap(90),
                  Text(
                    'Tentang Kami',
                    style: TextStyle(
                        fontSize: 18, fontWeight: semiBold, color: primary),
                  )
                ],
              ),
            ),
            Gap(20),
            Builder(builder: (context) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                        ),
                        child: Text(
                          'Selamat datang di Medaran solusi terbaik untuk manajemen penjualan dan inventaris toko Anda',
                          style: TextStyle(
                              fontWeight: semiBold,
                              fontSize: 21,
                              color: primary),
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
                        'Tim Kami',
                        style: TextStyle(
                            fontWeight: medium, fontSize: 10, color: secondary),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Katakan Halo Kepada para developer Medaran App',
                          style: TextStyle(
                              fontWeight: semiBold,
                              fontSize: 21,
                              color: primary),
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
                                Foto: 'assets/profile/rafi.jpg',
                                nama: 'Rafi',
                                role: 'Designer',
                                desk:
                                    'Founder Of Design For UI/UX, flow system'),
                            Gap(5),
                            Bio(
                                Foto: 'assets/profile/zamri.jpg',
                                nama: 'Zamri',
                                role: 'Frontend',
                                desk:
                                    'Founder of frontend, design app, code writing, UI/UX'),
                            Gap(5),
                            Bio(
                                Foto: 'assets/profile/tama.jpg',
                                nama: 'Tama',
                                role: 'Designer',
                                desk:
                                    'Founder Of Design For UI/UX, flow system'),
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
                                Foto: 'assets/profile/krisna .jpeg',
                                nama: 'Krisna',
                                role: 'System Analytic',
                                desk:
                                    'Founder of system analytic, testing app, add feature'),
                            Gap(5),
                            Bio(
                                Foto: 'assets/profile/danu.jpg',
                                nama: 'Danu',
                                role: 'Backend',
                                desk:
                                    'Founder of backend, create database, make RestAPI'),
                            Gap(5),
                            Bio(
                                Foto: 'assets/profile/Aril.jpg',
                                nama: 'Sarifudien',
                                role: 'Bug tester',
                                desk: 'Find Bug and Report'),
                          ],
                        ),
                      ),
                      Gap(60),
                      Separator(
                        color: primary,
                      ),
                      Gap(5),
                      Text(
                        'Tentang Aplikasi',
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
                      Separator(
                        color: primary,
                      ),
                      Gap(5),
                      Text(
                        'Visi',
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
                      Separator(
                        color: primary,
                      ),
                      Gap(5),
                      Text(
                        'Fitur',
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
                      Separator(
                        color: primary3,
                      ),
                      Gap(10),
                      Separator(
                        color: primary2,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 1,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 2,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 3,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 4,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 5,
                      ),
                      Gap(10),
                      Separator(
                        color: primary,
                        height: 6,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(color: primary),
                        child: Column(
                          children: [
                            Text(
                              'Contact Us',
                              style: TextStyle(
                                  color: white,
                                  fontSize: 14,
                                  fontWeight: semiBold),
                            ),
                            Gap(30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Email : support@medarancashier.com ',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: semiBold),
                                ),
                                Gap(10),
                                Text(
                                  'Telpon : 082340017349',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: semiBold),
                                ),
                                Gap(10),
                                Text(
                                  'Alamat : JL. Pemuda No. 1, Mataram, NTB',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 14,
                                      fontWeight: semiBold),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
