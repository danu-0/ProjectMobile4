import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class List_p extends StatelessWidget {
  final String nama;
  final String gambar;
  final int harga;
  final String stok;
  final int produkId;
  final String kategori;
  final bool isEven;
  final VoidCallback onDelete;

  const List_p({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.harga,
    required this.stok,
    required this.produkId,
    required this.kategori,
    required this.isEven,
    required this.onDelete,
  }) : super(key: key);

  String formatHarga(int harga) {
    final hargaFormat = NumberFormat("#,##0", "id_ID");
    return hargaFormat.format(harga);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: isEven ? Colors.white : Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              produkId.toString(),
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              nama,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Rp.${formatHarga(harga)}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              stok,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.right,
            ),
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
