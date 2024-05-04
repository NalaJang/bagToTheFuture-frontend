import 'package:flutter/material.dart';
import 'package:rest_api_ex/design/svg_icon.dart';
import 'package:rest_api_ex/screen/favorite_list/favorite_list_screen.dart';
import 'package:rest_api_ex/screen/home/home_screen.dart';
import 'package:rest_api_ex/screen/my_page/my_page_screen.dart';

class MyBottomNavigation extends StatefulWidget {
  const MyBottomNavigation({super.key});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  int currentPage = 0;
  static const pages = [
    HomeScreen(),
    FavoriteListScreen(),
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
      items: [
        BottomNavigationBarItem(
          icon: SvgIcon.home(),
          activeIcon: SvgIcon.activatedHome(),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon.myFavorite(),
          activeIcon: SvgIcon.activatedMyFavorite(),
          label: '찜',
        ),
        BottomNavigationBarItem(
          icon: SvgIcon.myPage(),
          activeIcon: SvgIcon.activatedMyPage(),
          label: '마이페이지',
        ),
      ],
    );
  }
}
