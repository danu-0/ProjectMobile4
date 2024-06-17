import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tester/controller/controller.dart';
import 'package:tester/page/home.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:tester/widget/list.dart';
import '../widget/cardMakanan.dart';
import '../widget/status.dart';

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
      final response = await http.get(
        Uri.parse('https://nest-js-nine.vercel.app/transaksi'),
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
                    size: 56,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userController.userData['username']}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${userController.userData['email']}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Gap(10),
            ListMenu(text: 'History'),
            SizedBox(height: 10),
            Status(cardPesanan: cardPesanan),
            Gap(10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cardPesanan.length,
                      itemBuilder: (context, index) {
                        final pesanan = cardPesanan[index];
                        return CardTransaction(
                          id: pesanan['id'],
                          orderId: pesanan['orderId'],
                          namaPemesan: pesanan['namaPemesan'],
                          jumlahProduk: pesanan['jumlahProduk'],
                          totalHarga: pesanan['totalHarga'],
                          status: pesanan['status'],
                          createdAt: DateTime.parse(pesanan['createdAt']),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: cController.index,
        onItemTapped: (index) {
          cController.index.value = index;
        },
      ),
    );
  }
}
