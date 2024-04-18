import 'package:flutter/material.dart';
import '../theme/theme.dart';

class textbuton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color requiredColor;

  textbuton({
    required this.onPressed,
    required this.text,
    required this.requiredColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum Punya Akun ? ",
              style: TextStyle(
                  color: secondarytext, fontSize: 14, fontWeight: regular),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                    color: requiredColor, fontSize: 14, fontWeight: extraBold),
              ),
            ),
          ],
        ),
        Text(
          'Atau',
          style: TextStyle(color: primary, fontSize: 14, fontWeight: extraBold),
        ),
      ],
    );
  }
}

class text2 extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color requiredColor;

  text2({
    required this.onPressed,
    required this.text,
    required this.requiredColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sudah Punya Akun ? ",
              style: TextStyle(
                  color: secondarytext, fontSize: 14, fontWeight: regular),
            ),
            TextButton(
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                    color: requiredColor, fontSize: 14, fontWeight: extraBold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
