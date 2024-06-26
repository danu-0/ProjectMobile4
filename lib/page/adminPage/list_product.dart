import 'package:Medaran/widget/list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:Medaran/model/pesanan.dart';
import 'package:Medaran/page/adminPage/addProduct.dart';
import 'package:Medaran/theme/theme.dart';
import 'package:Medaran/widget/buton.dart';
import '../../api/product.dart';
import '../../widget/list_p.dart';
import 'package:http/http.dart' as http;

import '../../widget/popDialog.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({super.key});

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  late Future<List<Produk>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts()
        .then((data) => data.map((item) => Produk.fromJson(item)).toList());
  }

  Future<void> _deleteProduct(int id) async {
    final url = Uri.parse('https://nest-js-nine.vercel.app/product/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        setState(() {
          _futureProducts = fetchProducts().then(
              (data) => data.map((item) => Produk.fromJson(item)).toList());
        });

        print('Pesanan berhasil dihapus');
      } else {
        print('Gagal menghapus pesanan. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting pesanan: $error');
    }
  }

  void _confirmDelete(BuildContext context, int id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialoguu(
          alert: 'Konfirmasi Penghapusan',
          pesan: 'Apakah Anda yakin ingin menghapus produk ini?',
          btn: 'Hapus',
          onPressed: () {
            Navigator.of(context).pop();
            _deleteProduct(id);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Stack(
          children: [
            Column(
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
                      Gap(80),
                      Text(
                        'Semua Produk',
                        style: TextStyle(
                            fontSize: 18, fontWeight: semiBold, color: primary),
                      )
                    ],
                  ),
                ),
                Gap(20),
                Row(
                  children: [
                    Gap(10),
                    ListMenu2(text: 'Id'),
                    Gap(20),
                    ListMenu2(text: 'Nama'),
                    Gap(66),
                    ListMenu2(text: 'Harga'),
                    Gap(20),
                    ListMenu2(text: 'Stock')
                  ],
                ),
                Gap(5),
                Expanded(
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

                        return ListView.builder(
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            var product = products[index];
                            return List_p(
                              key: ValueKey(product.id),
                              nama: product.nama,
                              gambar: product.gambar.toString(),
                              harga: product.harga,
                              stok: product.stok.toString(),
                              produkId: product.id,
                              kategori: product.kategori.toString(),
                              isEven: index % 2 == 0,
                              onDelete: () =>
                                  _confirmDelete(context, product.id),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Gap(60)
              ],
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 10,
                child: buton(
                    onPressed: () => Get.to(UploadProductPage()),
                    text: 'Tambah Product'))
          ],
        ),
      ),
    );
  }
}
