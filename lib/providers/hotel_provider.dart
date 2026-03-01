import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 讀取本地 Assets 必備

class HotelProvider with ChangeNotifier {
  // 1. 狀態變數
  bool _isLoading = false;
  Map<String, dynamic>? _hotelData;

  // 2. 讓 UI 讀取的 Getter
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get hotelData => _hotelData;

  // 3. 核心功能：讀取 JSON 資料
  Future<void> fetchHotelInfo() async {
    // 避免重複抓取
    if (_hotelData != null) return;

    _isLoading = true;
    notifyListeners(); // 告訴 UI 顯示載入中（轉圈圈）

    try {
      // 模擬從 API 抓取：讀取本地檔案
      final String response = await rootBundle.loadString('assets/data/hotel_info.json');
      final data = json.decode(response);

      // 模擬網路延遲 1 秒（讓 App 更有真實感）
      await Future.delayed(const Duration(seconds: 1));

      _hotelData = data;
    } catch (error) {
      debugPrint("讀取飯店資料失敗: $error");
    } finally {
      _isLoading = false;
      notifyListeners(); // 抓完了，叫 UI 更新畫面
    }
  }
}