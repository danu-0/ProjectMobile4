import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/cardMakanan.dart';
import 'package:tester/widget/list.dart';
import 'package:get/get.dart';
import 'package:tester/widget/slidebanner.dart';
import '../api/product.dart';
import '../controller/controller.dart';
import '../model/product.dart';
import '../widget/bottomNav.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Produk>> _futureProducts;
  var indexKategori = 0;
  var currentIndex = 0;

  void getKategori(int index) {
    setState(() {
      indexKategori = index;
    });
  }

  void initState() {
    super.initState();
    _futureProducts = fetchProducts()
        .then((data) => data.map((item) => Produk.fromJson(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find();
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
                  size: 56,
                )),
                Gap(16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userController.userData['username']}',
                      style: TextStyle(
                        fontSize: 13,
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
            Gap(18),
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<List<Produk>>(
                    future: _futureProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Failed to load products'));
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Center(child: Text('No products available'));
                      } else {
                        var products = snapshot.data!;
                        var makanan = products
                            .where((product) => product.kategori == 'Makanan')
                            .toList();
                        var minuman = products
                            .where((product) => product.kategori == 'Minuman')
                            .toList();
                        var snack = products
                            .where((product) => product.kategori == 'Snack')
                            .toList();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: AutoScrollingBackground(imageList: [
                                'assets/banner.png',
                                'assets/banner2.png',
                                'assets/banner3.png',
                                'assets/banner4.png',
                                'assets/banner5.png',
                              ]),
                            ),
                            Gap(30),
                            ListMenu(text: 'Makanan'),
                            Gap(18),
                            Container(
                                height: 154,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: makanan.length,
                                  itemBuilder: (context, index) {
                                    return MakananItem(
                                      nama: makanan[index].nama,
                                      gambar: makanan[index].gambar,
                                      harga: makanan[index].harga,
                                      desk: makanan[index].desk,
                                      produkId: makanan[index].id,
                                      kategori: makanan[index].kategori,
                                    );
                                  },
                                )),
                            Gap(30),
                            ListMenu(text: 'Minuman'),
                            Gap(18),
                            Container(
                              height: 154,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: minuman.length,
                                itemBuilder: (context, index) {
                                  return MakananItem(
                                    nama: minuman[index].nama,
                                    gambar: minuman[index].gambar,
                                    harga: minuman[index].harga,
                                    desk: minuman[index].desk,
                                    produkId: minuman[index].id,
                                    kategori: minuman[index].kategori,
                                  );
                                },
                              ),
                            ),
                            Gap(30),
                            ListMenu(text: 'Snack'),
                            Gap(18),
                            Container(
                              height: 154,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snack.length,
                                itemBuilder: (context, index) {
                                  return MakananItem(
                                    nama: snack[index].nama,
                                    gambar: snack[index].gambar,
                                    harga: snack[index].harga,
                                    desk: snack[index].desk,
                                    produkId: snack[index].id,
                                    kategori: snack[index].kategori,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    }),
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
