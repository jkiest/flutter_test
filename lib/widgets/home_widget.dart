import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: const Text('飯店預訂'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首頁'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: '收藏',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '預訂',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '個人'),
        ],
      ),
      body: const Center(
        child: Text('飯店列表內容'),
      ),
    );
}
