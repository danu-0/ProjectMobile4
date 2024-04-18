import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.only(top: 10),
          height: 51,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: primary),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: primary,
              ),
              Gap(15),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    fontSize: 14,
                    color: secondarytext,
                    fontWeight: regular,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter Your $desk',
                    hintStyle: TextStyle(color: secondarytext),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
