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
      margin: EdgeInsets.only(left: 4),
      height: 34,
      width: 130,
      decoration: BoxDecoration(
          border: Border.all(color: secondary, width: 2),
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

class ListMenu2 extends StatelessWidget {
  final String text;
  const ListMenu2({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6),
      height: 34,
      decoration: BoxDecoration(
          border: Border.all(color: secondary, width: 2),
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
