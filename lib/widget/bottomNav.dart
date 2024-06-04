import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tester/theme/theme.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final RxInt currentIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar(
      {required this.currentIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 76,
      shape: const CircularNotchedRectangle(),
      color: white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
              onItemTapped(0);
            },
            icon: Obx(() => Icon(
                  Icons.home,
                  size: 30,
                  color: currentIndex.value == 0 ? primary : secondarytext,
                )),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/shop');
              onItemTapped(1);
            },
            icon: Obx(() => Icon(
                  Icons.shopping_cart_outlined,
                  size: 25,
                  color: currentIndex.value == 1 ? primary : secondarytext,
                )),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/library');
              onItemTapped(2);
            },
            icon: Obx(() => Icon(
                  Icons.library_books_outlined,
                  size: 25,
                  color: currentIndex.value == 2 ? primary : secondarytext,
                )),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profil');
              onItemTapped(3);
            },
            icon: Obx(() => Icon(
                  Icons.account_circle_outlined,
                  size: 30,
                  color: currentIndex.value == 3 ? primary : secondarytext,
                )),
          ),
        ],
      ),
    );
  }
}
