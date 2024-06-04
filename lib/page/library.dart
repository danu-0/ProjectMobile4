import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/page/home.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tester/widget/list.dart';
import '../controller/controller.dart';
import '../widget/listFavorit.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  var currentIndex = 1;
  final UserController userController = Get.find<UserController>();
  List<Map<String, dynamic>> cardPesanan = [];

  @override
  void initState() {
    super.initState();
    fetchPesananData();
  }

  Future<void> fetchPesananData() async {
    try {
      final userId = userController.userData['id'];
      final response = await http.get(
        Uri.parse('http://10.0.2.2:3000/pesanan/user/$userId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          cardPesanan = data.cast<Map<String, dynamic>>();
          print(cardPesanan);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> deletePesanan(int pesananId) async {
    final url = Uri.parse('http://10.0.2.2:3000/pesanan/$pesananId');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        fetchPesananData();

        print('Pesanan berhasil dihapus');
      } else {
        print('Gagal menghapus pesanan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting pesanan: $error');
    }
  }

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
                  size: 56,
                )),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      '${userController.userData['email']}',
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
                    Gap(25),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Container(
                          //   width: double.infinity,
                          //   height: 450,
                          //   color: Colors.transparent,
                          //   child: ListView.builder(
                          //     scrollDirection: Axis.vertical,
                          //     itemCount: cardPesanan.length,
                          //     itemBuilder: (context, index) {
                          //       final pesanan = cardPesanan[index];

                          //       if (pesanan != null) {
                          //         // Periksa apakah properti yang mungkin null sebenarnya null sebelum mengaksesnya
                          //         final id = pesanan['id'];
                          //         final produkName = pesanan['ProdukName'];
                          //         final harga = pesanan['harga'];
                          //         final total = pesanan['total'];
                          //         final desk = pesanan['desk'];
                          //         final kategoris = pesanan['kategori'];
                          //         final createdAt = pesanan['createdAt'];

                          //         // Gunakan nilai default jika properti null
                          //         final produkNames = produkName ??
                          //             'Nama Produk Tidak Tersedia';

                          //         final totalPesanan = total ??
                          //             0; // Anda dapat mengatur nilai default sesuai kebutuhan

                          //         return Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             PesananCard(
                          //               id: id,
                          //               produkName: produkNames,
                          //               harga: harga,
                          //               qtt: totalPesanan,
                          //               desk: desk,
                          //               kategori: kategoris,
                          //               createdAt: createdAt,
                          //               onPressed: () => deletePesanan(id),
                          //               onpressedEdit: () {},
                          //               onSelect: (p0) {},
                          //             ),
                          //             Gap(20),
                          //           ],
                          //         );
                          //       } else {
                          //         // Tampilkan widget atau pesan kesalahan jika ada data yang null
                          //         return Text('Data pesanan tidak lengkap');
                          //       }
                          //     },
                          //   ),
                          // ),
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




// final List<Map<String, dynamic>> cardFavorite = [
//   {
//     'nama': 'Nasi Goreng',
//     'gambar': 'assets/makanan/pai.png',
//     'total': '20',
//     'nomer': '1',
//   },
//   {
//     'nama': 'Nasi Goreng',
//     'gambar': 'assets/makanan/pai.png',
//     'total': '20',
//     'nomer': '1',
//   },
//   {
//     'nama': 'Nasi Goreng',
//     'gambar': 'assets/makanan/pai.png',
//     'total': '20',
//     'nomer': '1',
//   },
//   {
//     'nama': 'Ayam Goreng',
//     'gambar': 'assets/makanan/lalapan.png',
//     'total': ' 20',
//     'nomer': '1',
//   },
//   {
//     'nama': 'Sate Ayam',
//     'gambar': 'assets/makanan/pai.png',
//     'total': '  30',
//     'nomer': '2',
//   },
//   {
//     'nama': 'Mie Goreng',
//     'gambar': 'assets/makanan/lalapan.png',
//     'total': '30',
//     'nomer': '3',
//   },
//   {
//     'nama': 'Mie Goreng',
//     'gambar': 'assets/makanan/lalapan.png',
//     'total': '30',
//     'nomer': '3',
//   },
//   {
//     'nama': 'Mie Goreng',
//     'gambar': 'assets/makanan/lalapan.png',
//     'total': '30',
//     'nomer': '3',
//   },
// ];


// Row(
//                       children: [
//                         Container(
//                           width: 154,
//                           height: 92,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                             color: Colors.white,
//                             border: Border.all(
//                               color: secondary,
//                               width: 1,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 20, left: 20),
//                             child: Row(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 60,
//                                       height: 41,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(6)),
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: secondary,
//                                           width: 1,
//                                         ),
//                                       ),
//                                       child: Icon(
//                                         Icons.shopping_cart_outlined,
//                                         size: 25,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Gap(4),
//                                     Text(
//                                       'Pemesanan',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: primarytext,
//                                           fontWeight: semiBold),
//                                     )
//                                   ],
//                                 ),
//                                 Gap(10),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 20),
//                                   child: Text(
//                                     '20',
//                                     style: TextStyle(
//                                         fontSize: 34, fontWeight: bold),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         Gap(26),
//                         Container(
//                           width: 154,
//                           height: 92,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(6)),
//                             color: Colors.white,
//                             border: Border.all(
//                               color: secondary,
//                               width: 1,
//                             ),
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 20, left: 20),
//                             child: Row(
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       width: 60,
//                                       height: 41,
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(6)),
//                                         color: Colors.white,
//                                         border: Border.all(
//                                           color: secondary,
//                                           width: 1,
//                                         ),
//                                       ),
//                                       child: Icon(
//                                         Icons.person_outline_outlined,
//                                         size: 25,
//                                         color: Colors.black,
//                                       ),
//                                     ),
//                                     Gap(4),
//                                     Text(
//                                       'Pelanggan',
//                                       style: TextStyle(
//                                           fontSize: 12,
//                                           color: primarytext,
//                                           fontWeight: semiBold),
//                                     )
//                                   ],
//                                 ),
//                                 Gap(12),
//                                 Padding(
//                                   padding: const EdgeInsets.only(bottom: 20),
//                                   child: Text(
//                                     '20',
//                                     style: TextStyle(
//                                         fontSize: 34, fontWeight: bold),
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),