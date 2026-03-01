import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/my_bookings_screen.dart';
import 'screens/profile_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  // 定義分頁清單
  final List<Widget> _pages = [
    const HomeScreenNew(),    // 索引 0
    const MyBookingsScreen(), // 索引 1
    const ProfileScreen(),    // 索引 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // 根據點選的 index 顯示對應頁面
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // 更新選中狀態
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: '我的預訂'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '個人資料'),
        ],
      ),
    );
  }
}