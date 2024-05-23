import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';

class CustomForm2 extends StatelessWidget {
  final String desk;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const CustomForm2({
    required this.desk,
    required this.icon,
    this.onChanged,
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
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: primary,
            ),
            hintText:
                'Enter $desk', // Menggunakan deskripsi untuk menampilkan pesan hint
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
          onChanged: onChanged, // Menangani perubahan nilai
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

class CustomForm2P extends StatelessWidget {
  final String desk;
  final IconData icon;
  final ValueChanged<String>? onChanged;

  const CustomForm2P({
    required this.desk,
    required this.icon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var _obsecure = true.obs;
    return Form(
      child: Column(
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
          Gap(15),
          Obx(
            () => TextFormField(
              maxLength: 6,
              obscureText: _obsecure.value,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  icon,
                  color: primary,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _obsecure.value = !_obsecure.value;
                  },
                  child: Icon(
                    _obsecure.value ? Icons.visibility : Icons.visibility_off,
                    color: primary,
                  ),
                ),
                hintText: 'password',
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
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  InputBorder styleBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: primary, width: 1.5));
  }
}
