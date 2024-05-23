import 'package:flutter/material.dart';
import 'package:tester/theme/theme.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            decoration:
                BoxDecoration(border: Border.all(color: secondary, width: 2)),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: gambar,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
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
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Rp ${harga}',
                      style: TextStyle(fontSize: 10, fontWeight: regular),
                    ),
                  ],
                ),
                Icon(
                  Icons.add_box_outlined,
                  color: primary,
                  size: 15,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
