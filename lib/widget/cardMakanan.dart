import 'package:flutter/material.dart';
import 'package:tester/theme/theme.dart';

class MakananItem extends StatelessWidget {
  final String nama;
  final String gambar;
  final int harga;

  const MakananItem({
    Key? key,
    required this.nama,
    required this.gambar,
    required this.harga,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 154,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: white,
          border: Border.all(color: primary, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 92,
            width: double.infinity,
            decoration:
                BoxDecoration(border: Border.all(color: primary, width: 2)),
            child: ClipRRect(
              child: Image.asset(
                gambar,
                fit: BoxFit.cover,
              ),
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
                      ),
                    ),
                    Text(
                      'Harga: Rp ${harga}',
                      style: TextStyle(fontSize: 10, fontWeight: regular),
                    ),
                  ],
                ),
                Icon(
                  Icons.add_box_outlined,
                  color: primary,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
