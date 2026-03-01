import 'dart:async';
// 假設你有這些 Model，若無則需建立或移除相關引用
// import '../models/booking.dart';
// import '../models/hotel.dart';

class ApiClient {
  // 模擬資料庫
  static final List<Map<String, String>> _userDb = [
    {'email': 'admin@example.com', 'password': '123', 'name': '管理員'},
    {'email': 'test@hotel.com', 'password': '456', 'name': '測試房客'},
  ];

  // 模擬登入 API
  static Future<Map<String, dynamic>> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1500)); // 模擬網路延遲
    try {
      final user = _userDb.firstWhere(
        (u) => u['email'] == email && u['password'] == password,
      );

      return {
        'status': 'success',
        'data': {
          'id': 'u_${DateTime.now().millisecondsSinceEpoch}',
          'email': user['email'],
          'firstName': user['name'],
          'lastName': '先生/小姐',
        }
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': '帳號或密碼不正確'
      };
    }
  }

  // 其他模擬方法保持結構正確
  static Future<bool> cancelBooking(String bookingId) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }
}