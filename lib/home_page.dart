import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ptma/feture/history/history_page.dart';
import 'package:ptma/feture/payment/qr_pymant.dart';
import 'package:ptma/feture/user_profile/profile_page.dart';

import 'feture/home/presentation/main_home_page.dart';
import 'feture/home/presentation/widget/head_home_page.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = const [
    MainHomePage(),
    QrCodePage(),
    TripHistoryPage(),
    ProfilePage()
  ];
  int _selectedPage = 0;
  void _onTapNav(int index) {
    _selectedPage = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _selectedPage == 0 ? Colors.blue : Colors.black,
                ),
                label: 'Location'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.qr_code_scanner_outlined,
                  color: _selectedPage == 1 ? Colors.blue : Colors.black,
                ),
                label: 'Location'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.history,
                  color: _selectedPage == 2 ? Colors.blue : Colors.black,
                ),
                label: 'Location'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _selectedPage == 3 ? Colors.blue : Colors.black,
                ),
                label: 'Location'),
          ],
          onTap: (value) => _onTapNav(value),
        ),
      ),
    );
  }
}
