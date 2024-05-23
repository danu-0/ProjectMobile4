import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../theme/theme.dart';

class CustomForm extends StatelessWidget {
  final String desk;
  final IconData icon;
  final TextEditingController controller;

  const CustomForm({
    required this.desk,
    required this.icon,
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
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: primary,
            ),
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

class CustomFormP extends StatelessWidget {
  final String desk;
  final IconData icon;
  final TextEditingController controller;

  const CustomFormP({
    required this.desk,
    required this.icon,
    required this.controller,
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
          SizedBox(height: 18),
          Obx(
            () => TextFormField(
              controller: controller,
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
