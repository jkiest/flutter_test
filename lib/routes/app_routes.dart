import 'package:flutter/material.dart';

class AppRoutes {
  AppRoutes._(); // 私有構造函數，防止實例化

  static const String home = '/';
  static const String hotelDetails = '/hotel-details';
  static const String booking = '/booking';
  static const String bookingConfirmation = '/booking-confirmation';
  static const String myBookings = '/my-bookings';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        // Return home screen
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case hotelDetails:
        // Return hotel details
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case booking:
        // Return booking screen
        return MaterialPageRoute(builder: (_) => const SizedBox());
      case login:
        // Return login screen
        return MaterialPageRoute(builder: (_) => const SizedBox());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('未定義的路由')),
            body: const Center(child: Text('頁面未找到')),
          ),
        );
    }
  }
}
