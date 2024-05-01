import 'package:flutter/material.dart';
import 'package:rest_api_ex/screen/home/home_screen.dart';
import 'package:rest_api_ex/screen/my_page/my_page_screen.dart';
import 'package:rest_api_ex/screen/sign_in/sign_in_screen.dart';
import 'package:rest_api_ex/screen/wish_list/wish_list_screen.dart';


class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {

  int currentPage = 0;
  static const pages = [
    HomeScreen(),
    WishListScreen(),
    MyPageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }


  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: (index) => setState(() {
        currentPage = index;
      }),

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.map), label: 'map'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'setting'),
      ],
    );
  }
}
