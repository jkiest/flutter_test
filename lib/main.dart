import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// 引入你的導覽外殼
import 'main_wrapper.dart';
import 'providers/booking_provider.dart';
// 引入你的 Providers
import 'providers/hotel_provider.dart';
import 'providers/user_provider.dart'; 

void main() {
  runApp(const HotelApp());
}

class HotelApp extends StatelessWidget {
  // 這裡加上了 {super.key}，解決你看到的第二個警告
  const HotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HotelProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => BookingProvider()),
      ],
      child: MaterialApp(
        title: '金樽大飯店',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        // 讓 App 啟動時進入導覽外殼，這樣下面才會有按鈕可以切換功能
        home: const MainWrapper(), 
      ),
    );
  }
}