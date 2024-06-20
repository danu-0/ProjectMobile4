import 'package:flutter/material.dart';
import 'package:Medaran/theme/theme.dart';
import 'dart:async';

class AutoScrollingBackground extends StatefulWidget {
  final List<String> imageList;

  const AutoScrollingBackground({Key? key, required this.imageList})
      : super(key: key);

  @override
  _AutoScrollingBackgroundState createState() =>
      _AutoScrollingBackgroundState();
}

class _AutoScrollingBackgroundState extends State<AutoScrollingBackground> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < widget.imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//ini dot nya cuy
  Widget _buildPageIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (_currentPage == index) ? white : secondary,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 330,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: AssetImage(widget.imageList[index]),
                      fit: BoxFit.cover,
                      alignment: Alignment.center),
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.imageList.length,
              (int index) => _buildPageIndicator(index),
            ),
          ),
        ),
      ],
    );
  }
}
