import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:Medaran/widget/buton.dart';
import 'package:Medaran/widget/listFavorit.dart';

import '../theme/theme.dart';

class NextPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const NextPage({
    Key? key,
    required this.selectedItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var Ongkos = selectedItems.length;
    var Pemesanan = selectedItems.length;
    var SubTotal = Ongkos + Pemesanan;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
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
                      'Menu Pesanan',
                      style: TextStyle(
                          fontSize: 18, fontWeight: semiBold, color: primary),
                    )
                  ],
                ),
              ),
              Gap(10),
              Text(
                'Rangkuman Pesanan',
                style:
                    TextStyle(fontSize: 13, fontWeight: bold, color: primary),
              ),
              Gap(10),
              Container(
                height: 455,
                color: Colors.transparent,
                child: ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    final item = selectedItems[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            height: 100,
                            child: ListB(
                              nama: item['nama'],
                              gambar: item['gambar'],
                              total: item['total'],
                              itemcounter: item['total'],
                            )),
                        Gap(20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 160,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: white,
                        border: Border.all(color: secondary, width: 1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Metode Pembayaran',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: bold,
                                  color: primary),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pilihan',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: semiBold,
                                  color: primary),
                            ),
                            Text('Gopay')
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Subtotal',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            ),
                            Text(
                              SubTotal.toString(),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ongkos Kirim',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            ),
                            Text(
                              Ongkos.toString(),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Biaya Pemesanan',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            ),
                            Text(
                              Pemesanan.toString(),
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: regular,
                                  color: primary),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Gap(10),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.transparent,
                      child: buton(onPressed: () {}, text: 'Bayar')),
                ],
              ))
        ]),
      ),
    );
  }
}
