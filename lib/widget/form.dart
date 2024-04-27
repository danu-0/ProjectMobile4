import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';

class CustomForm extends StatelessWidget {
  final String desk;
  final IconData icon;

  const CustomForm({
    required this.desk,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        desk,
        style: TextStyle(
          fontSize: 16,
          fontWeight: medium,
          color: primarytext,
        ),
      ),
      SizedBox(height: 18),
      TextFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: primary,
          ),
          hintText: 'username',
          hintStyle: TextStyle(
              color: secondarytext, fontWeight: regular, fontSize: 14),
          border: styleBorder(),
          enabledBorder: styleBorder(),
          focusedBorder: styleBorder(),
          disabledBorder: styleBorder(),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
        ),
      ),
    ]);
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 1.5));
  }
}
