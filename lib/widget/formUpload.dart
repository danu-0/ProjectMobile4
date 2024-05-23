import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';

class CustomKeyboard extends StatelessWidget {
  final String desk;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const CustomKeyboard({
    required this.desk,
    required this.keyboardType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: desk,
            hintStyle: TextStyle(
              color: secondarytext,
              fontWeight: regular,
              fontSize: 14,
            ),
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
      ],
    );
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primary, width: 1.5),
    );
  }
}
