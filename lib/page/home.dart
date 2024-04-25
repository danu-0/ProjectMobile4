import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/page/bottom.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/cardMakanan.dart';
import 'package:tester/widget/list.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(); // Perbaiki di sini
}

class _HomeState extends State<Home> {
  final List<Map<String, dynamic>> cardMakanan = [
    {
      'nama': 'Nasi Goreng',
      'gambar': 'assets/makanan/pai.png',
      'harga': 15000,
    },
    {
      'nama': 'Ayam Goreng',
      'gambar': 'assets/makanan/lalapan.png',
      'harga': 20000,
    },
    {
      'nama': 'Sate Ayam',
      'gambar': 'assets/makanan/pai.png',
      'harga': 25000,
    },
    {
      'nama': 'Mie Goreng',
      'gambar': 'assets/makanan/lalapan.png',
      'harga': 12000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final cController = Get.put(MyController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 60, left: 30, right: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    child: Icon(
                  Icons.account_circle_outlined,
                  size: 46,
                )),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: semiBold,
                        color: primary,
                      ),
                    ),
                    Text(
                      'Job',
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
            Gap(30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 130,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image.asset(
                        'assets/baner.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    Gap(30),
                    ListMenu(text: 'Makanan'),
                    Gap(30),
                    Container(
                      height: 154,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardMakanan.length,
                        itemBuilder: (context, index) {
                          return MakananItem(
                            nama: cardMakanan[index]['nama'],
                            gambar: cardMakanan[index]['gambar'],
                            harga: cardMakanan[index]['harga'],
                          );
                        },
                      ),
                    ),
                    Gap(30),
                    ListMenu(text: 'Minuman'),
                    Gap(30),
                    Container(
                      height: 154,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardMakanan.length,
                        itemBuilder: (context, index) {
                          return MakananItem(
                            nama: cardMakanan[index]['nama'],
                            gambar: cardMakanan[index]['gambar'],
                            harga: cardMakanan[index]['harga'],
                          );
                        },
                      ),
                    ),
                    Gap(30),
                    ListMenu(text: 'Snack'),
                    Gap(30),
                    Container(
                      height: 154,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cardMakanan.length,
                        itemBuilder: (context, index) {
                          return MakananItem(
                            nama: cardMakanan[index]['nama'],
                            gambar: cardMakanan[index]['gambar'],
                            harga: cardMakanan[index]['harga'],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
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

class MyController extends GetxController {
  var index = 0.obs;

  void onItemTapped(int inx) {
    index.value = inx;
    update();
  }
}
