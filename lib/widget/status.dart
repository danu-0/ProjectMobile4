import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../theme/theme.dart';

class Status extends StatelessWidget {
  const Status({
    super.key,
    required this.cardPesanan,
  });

  final List<Map<String, dynamic>> cardPesanan;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 154,
          height: 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.transparent,
            border: Border.all(
              color: secondary,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.transparent,
                        border: Border.all(
                          color: secondary,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    Gap(4),
                    Text(
                      'Pemesanan',
                      style: TextStyle(
                          fontSize: 12,
                          color: primarytext,
                          fontWeight: semiBold),
                    )
                  ],
                ),
                Gap(10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    '${cardPesanan.length}',
                    style: TextStyle(fontSize: 34, fontWeight: bold),
                  ),
                )
              ],
            ),
          ),
        ),
        Gap(26),
        Container(
          width: 154,
          height: 92,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
            color: Colors.transparent,
            border: Border.all(
              color: secondary,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 41,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Colors.transparent,
                        border: Border.all(
                          color: secondary,
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.person_outline_outlined,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                    Gap(4),
                    Text(
                      'Pelanggan',
                      style: TextStyle(
                          fontSize: 12,
                          color: primarytext,
                          fontWeight: semiBold),
                    )
                  ],
                ),
                Gap(12),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    '${cardPesanan.length}',
                    style: TextStyle(fontSize: 34, fontWeight: bold),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
