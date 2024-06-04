import 'package:flutter/material.dart';
import 'package:tester/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        );
      },
    );
  }
}
