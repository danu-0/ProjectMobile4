import 'package:flutter/material.dart';

import '../theme/theme.dart';

class ListMenu extends StatelessWidget {
  final String text;
  const ListMenu({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      width: 106,
      decoration: BoxDecoration(
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: primary, fontSize: 13, fontWeight: semiBold),
        ),
      ),
    );
  }
}
