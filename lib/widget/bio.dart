import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tester/theme/theme.dart';

class Bio extends StatelessWidget {
  final String Foto;
  final String nama;
  final String role;
  final String desk;

  const Bio({
    Key? key,
    required this.Foto,
    required this.nama,
    required this.role,
    required this.desk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(Foto),
            radius: 40,
            backgroundColor: Colors.transparent,
          ),
          Text(
            nama,
            style: TextStyle(color: primary, fontSize: 16, fontWeight: medium),
          ),
          Text(
            role,
            style: TextStyle(color: primary, fontSize: 10, fontWeight: medium),
          ),
          Gap(3),
          Text(
            desk,
            style: TextStyle(color: primary, fontSize: 8, fontWeight: medium),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
