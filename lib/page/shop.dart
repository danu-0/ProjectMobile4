import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:tester/page/home.dart';
import 'package:tester/page/pembayaran.dart';
import 'package:tester/widget/bottomNav.dart';
import 'package:tester/widget/buton.dart';

import '../theme/theme.dart';
import '../widget/list.dart';
import '../widget/listFavorit.dart';
import 'library.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  var currentIndex = 2;
  List<Map<String, dynamic>> selectedItems = []; //tampung data select
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
                      ListMenu(text: 'Favorite'),
                      Gap(10),
                      // list
                      Container(
                        width: double.infinity,
                        height: 630,
                        color: Colors.transparent,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: cardFavorite.length,
                          itemBuilder: (context, index) {
                            final item = cardFavorite[index];
                            final bool isSelected =
                                selectedItems.contains(item);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 114,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: white,
                                      border: Border.all(
                                          color: secondary, width: 2)),
                                  child: ListKeranjang(
                                    nama: cardFavorite[index]['nama'],
                                    gambar: cardFavorite[index]['gambar'],
                                    total: cardFavorite[index]['total'],
                                    isSelected: isSelected,
                                    onItemSelected: (bool newValue) {
                                      setState(() {
                                        if (newValue) {
                                          selectedItems.add(item);
                                        } else {
                                          selectedItems.remove(item);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Gap(20),
                              ],
                            );
                          },
                        ),
                      ),
                      Gap(10),
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
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NextPage(
                                      selectedItems: selectedItems,
                                    )));
                        print(ItemCounter);
                      },
                      text: 'pesan')))
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
