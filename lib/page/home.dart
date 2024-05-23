import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/theme/theme.dart';
import 'package:tester/widget/cardMakanan.dart';
import 'package:tester/widget/list.dart';
import 'package:get/get.dart';
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
                  size: 46,
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
            Gap(30),
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
                                  itemCount: products.length,
                                  itemBuilder: (context, index) {
                                    return MakananItem(
                                      nama: products[index].nama,
                                      gambar: products[index].gambar,
                                      harga: products[index].harga,
                                    );
                                  },
                                )),
                            Gap(30),
                            ListMenu(text: 'Minuman'),
                            Gap(30),
                            Container(
                              height: 154,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return MakananItem(
                                    nama: products[index].nama,
                                    gambar: products[index].gambar,
                                    harga: products[index].harga,
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
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  return MakananItem(
                                    nama: products[index].nama,
                                    gambar: products[index].gambar,
                                    harga: products[index].harga,
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
