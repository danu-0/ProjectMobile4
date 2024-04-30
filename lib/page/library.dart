// import 'package:flutter/material.dart';
// import 'package:gap/gap.dart';
// import 'package:tester/page/home.dart';
// import 'package:tester/widget/bottomNav.dart';
// import 'package:get/get.dart';

// import '../theme/theme.dart';

// class Library extends StatefulWidget {
//   const Library({super.key});

//   @override
//   State<Library> createState() => _LibraryState();
// }

// class _LibraryState extends State<Library> {
//   var currentIndex = 1;

//   @override
//   Widget build(BuildContext context) {
//     final cController = Get.put(MyController());
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         padding: EdgeInsets.only(top: 60, left: 30, right: 30),
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/bg.png'), fit: BoxFit.cover)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Padding(padding: EdgeInsets.only(left: 30, top: 100)),
//                 Icon(
//                   Icons.account_circle_outlined,
//                   size: 60,
//                   color: secondarytext,
//                 ),
//                 Gap(20),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Kangkung Kuning',
//                       style: TextStyle(
//                           fontSize: 14, fontWeight: semiBold, color: primary),
//                     ),
//                     Text('Cashier')
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: CustomBottomNavigationBar(
//           currentIndex: cController.index,
//           onItemTapped: (index) {
//             cController.index.value = index;
//           }),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/page/home.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:get/get.dart';

import 'package:tester/widget/list.dart';
import 'package:tester/widget/listFavorit.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

final List<Map<String, dynamic>> cardFavorite = [
  {
    'nama': 'Nasi Goreng',
    'gambar': 'assets/makanan/pai.png',
    'total': '20',
    'nomer': '1',
  },
  {
    'nama': 'Nasi Goreng',
    'gambar': 'assets/makanan/pai.png',
    'total': '20',
    'nomer': '1',
  },
  {
    'nama': 'Nasi Goreng',
    'gambar': 'assets/makanan/pai.png',
    'total': '20',
    'nomer': '1',
  },
  {
    'nama': 'Ayam Goreng',
    'gambar': 'assets/makanan/lalapan.png',
    'total': ' 20',
    'nomer': '1',
  },
  {
    'nama': 'Sate Ayam',
    'gambar': 'assets/makanan/pai.png',
    'total': '  30',
    'nomer': '2',
  },
  {
    'nama': 'Mie Goreng',
    'gambar': 'assets/makanan/lalapan.png',
    'total': '30',
    'nomer': '3',
  },
  {
    'nama': 'Mie Goreng',
    'gambar': 'assets/makanan/lalapan.png',
    'total': '30',
    'nomer': '3',
  },
  {
    'nama': 'Mie Goreng',
    'gambar': 'assets/makanan/lalapan.png',
    'total': '30',
    'nomer': '3',
  },
];

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
                        fontSize: 16,
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
            Gap(20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(30),
                    ListMenu(text: 'History'),
                    Gap(25),
                    Row(
                      children: [
                        Container(
                          width: 154,
                          height: 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.white,
                            border: Border.all(
                              color: secondary,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: secondary,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.shopping_cart_outlined,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Gap(4),
                                    Text(
                                      'Pemesanan',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: primarytext,
                                          fontWeight: semiBold),
                                    )
                                  ],
                                ),
                                Gap(10),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    '20',
                                    style: TextStyle(
                                        fontSize: 34, fontWeight: bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Gap(26),
                        Container(
                          width: 154,
                          height: 92,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(6)),
                            color: Colors.white,
                            border: Border.all(
                              color: secondary,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 41,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6)),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: secondary,
                                          width: 1,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.person_outline_outlined,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Gap(4),
                                    Text(
                                      'Pelanggan',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: primarytext,
                                          fontWeight: semiBold),
                                    )
                                  ],
                                ),
                                Gap(12),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Text(
                                    '20',
                                    style: TextStyle(
                                        fontSize: 34, fontWeight: bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(25),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 450,
                            color: Colors.transparent,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cardFavorite.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 100,
                                      child: ListFavorite(
                                          nama: cardFavorite[index]['nama'],
                                          gambar: cardFavorite[index]['gambar'],
                                          total: cardFavorite[index]['total'],
                                          nomer: cardFavorite[index]['nomer']),
                                    ),
                                    Gap(20),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
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
