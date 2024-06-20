import 'package:flutter/material.dart';
import 'package:Medaran/theme/theme.dart';

class DashboardCard extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const DashboardCard({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        height: 160,
        width: 160,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(10)),
              child: Icon(
                icon,
                size: 50,
                color: iconColor,
              ),
            ),
            SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                  color: Colors.white, fontSize: 21, fontWeight: semiBold),
            ),
          ],
        ),
      ),
    );
  }
}
