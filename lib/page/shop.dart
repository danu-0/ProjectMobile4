import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tester/page/home.dart';
import 'package:tester/page/pembayaran.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:tester/widget/buton.dart';
import 'package:http/http.dart' as http;
import 'package:tester/widget/popDialog.dart';
import '../controller/controller.dart';
import '../theme/theme.dart';
import '../widget/list.dart';
import '../widget/listFavorit.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  var currentIndex = 2;
  final UserController userController = Get.find<UserController>();
  List<Map<String, dynamic>> selectedItems = [];
  List<Map<String, dynamic>> cardPesanan = [];
  double totalHarga = 0;
  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

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

  Future<void> updatePesanan(int pesananId, int newQtt) async {
    final url = Uri.parse('http://10.0.2.2:3000/pesanan/$pesananId');
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({'qtt': newQtt}),
      );
      if (response.statusCode == 200) {
        fetchPesananData();
        print('Pesanan berhasil diperbarui');
      } else {
        print('Gagal memperbarui pesanan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error updating pesanan: $error');
    }
  }

  void _showUpdateDialog(Map<String, dynamic> pesanan) {
    showDialog<int>(
      context: context,
      builder: (context) {
        return UpdateOrderDialog(
          pesananId: pesanan['id'],
          nama: pesanan['ProdukName'],
          harga: pesanan['harga'],
          desk: pesanan['desk'],
          currentQtt: pesanan['qtt'],
          kategori: pesanan['kategori'],
        );
      },
    ).then((newQtt) {
      if (newQtt != null) {
        updatePesanan(pesanan['id'], newQtt);
      }
    });
  }

  void _onCardSelected(Map<String, dynamic> pesanan, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(pesanan);
        totalHarga += pesanan['harga'] * pesanan['qtt'];
      } else {
        selectedItems.remove(pesanan);
        totalHarga -= pesanan['harga'] * pesanan['qtt'];
      }
    });
  }

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
        child: Stack(children: [
          Column(
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
                      ListMenu(text: 'List Pesan'),
                      Gap(10),
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
                                itemCount: cardPesanan.length,
                                itemBuilder: (context, index) {
                                  final pesanan = cardPesanan[index];
                                  if (pesanan != null) {
                                    final id = pesanan['id'];
                                    final produkName = pesanan['ProdukName'];
                                    final harga = pesanan['harga'];
                                    final qtt = pesanan['qtt'];
                                    final desk = pesanan['desk'];
                                    final kategori = pesanan['kategori'];
                                    final createdAt = pesanan['createdAt'];
                                    final produkNames = produkName ??
                                        'Nama Produk Tidak Tersedia';

                                    final totalPesanan = qtt ?? 0;
                                    final hargaa = harga ?? 0;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        PesananCard(
                                          id: id,
                                          produkName: produkNames,
                                          harga: hargaa,
                                          qtt: totalPesanan,
                                          desk: desk,
                                          kategori: kategori,
                                          createdAt: createdAt,
                                          onPressed: () => deletePesanan(id),
                                          onpressedEdit: () =>
                                              _showUpdateDialog(pesanan),
                                          onSelect: (isSelected) =>
                                              _onCardSelected(
                                                  pesanan, isSelected),
                                        ),
                                        Gap(20),
                                      ],
                                    );
                                  } else {
                                    return Text('Data pesanan tidak lengkap');
                                  }
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
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: buton(
                      onPressed: () {},
                      text:
                          'Bayar (Total: ${formatHarga(totalHarga.toInt())})')))
        ]),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: cController.index,
          onItemTapped: (index) {
            cController.index.value = index;
          }),
    );
  }
}
