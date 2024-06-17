import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tester/widget/buton.dart';
import 'package:tester/widget/popDialog.dart';
import 'package:intl/intl.dart';

class MakananItem extends StatelessWidget {
  final String nama;
  final String gambar;
  final int harga;
  final String desk;
  final int produkId;
  final String kategori;

  const MakananItem({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.desk,
    required this.produkId,
    required this.kategori,
  }) : super(key: key);

  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      height: 154,
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: white,
          border: Border.all(color: secondary, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 92,
            width: double.infinity,
            child: CachedNetworkImage(
              imageUrl: gambar,
              placeholder: (context, url) => Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                          color: primary),
                    ),
                    Text(
                      'Rp ${formatHarga(harga)}',
                      style: TextStyle(
                          fontSize: 10, fontWeight: regular, color: price),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => _showOrderDialog(context),
                  child: Icon(
                    Icons.add_box_outlined,
                    color: primary,
                    size: 15,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return OrderDialog(
          nama: nama,
          harga: harga,
          desk: desk,
          produkId: produkId,
          kategori: kategori,
          gambar: gambar,
        );
      },
    );
  }
}

class CardTransaction extends StatelessWidget {
  final int id;
  final String orderId;
  final String namaPemesan;
  final int jumlahProduk;
  final int totalHarga;
  final String status;
  final DateTime createdAt;

  CardTransaction({
    required this.id,
    required this.orderId,
    required this.namaPemesan,
    required this.jumlahProduk,
    required this.totalHarga,
    required this.status,
    required this.createdAt,
  });
  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order ID: $orderId',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: primary),
          ),
          SizedBox(height: 8),
          Text(
            'Nama Pemesan: $namaPemesan',
            style: TextStyle(color: primary, fontWeight: regular, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            'Jumlah Produk: $jumlahProduk',
            style: TextStyle(color: primary, fontWeight: regular, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            'Total Harga: Rp ${formatHarga(totalHarga)}',
            style: TextStyle(color: primary, fontWeight: regular, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            'Status: $status',
            style: TextStyle(color: primary, fontWeight: regular, fontSize: 15),
          ),
          SizedBox(height: 4),
          Text(
            'Tanggal Pesanan: ${DateFormat('dd MMMM yyyy').format(createdAt)}',
            style: TextStyle(color: primary, fontWeight: regular, fontSize: 15),
          ),
          Gap(5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: primary),
                  onPressed: () {},
                  child: Text(
                    'Hapus',
                    style: TextStyle(
                      color: white,
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
