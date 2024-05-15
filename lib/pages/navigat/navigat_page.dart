
import 'package:flutter/material.dart';

import '../favourites/favourite_page.dart';
import '../home/home_page.dart';

class NavigatPage extends StatefulWidget {
  const NavigatPage({Key? key}) : super(key: key);

  @override
  _NavigatPageState createState() => _NavigatPageState();
}

class _NavigatPageState extends State<NavigatPage> {
  int _currentPage = 0;
  final List<Widget> _pages = [HomePage(), FavouritePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Погода'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Избранное'),
        ],
        currentIndex: _currentPage,
        onTap: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
    );
  }
}