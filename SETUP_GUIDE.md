# 飯店預訂應用 - 快速開始指南

## 項目設置

### 1. 安裝 Flutter
確保已安裝 Flutter SDK。如果未安裝，請訪問 [flutter.dev](https://flutter.dev/docs/get-started/install)

檢查 Flutter 版本：
```bash
flutter --version
```

### 2. 克隆或打開項目
```bash
cd hotel_app
```

### 3. 獲取依賴
```bash
flutter pub get
```

### 4. 生成代碼
本項目使用 `json_serializable` 進行 JSON 序列化。生成必要的文件：
```bash
flutter pub run build_runner build
```

或者在開發過程中使用 watch 模式：
```bash
flutter pub run build_runner watch
```

## 運行應用

### 開發模式
```bash
flutter run
```

### 運行特定設備
列出所有可用設備：
```bash
flutter devices
```

在特定設備上運行：
```bash
flutter run -d <device_id>
```

### Web 版本
```bash
flutter run -d chrome
```

## 項目結構

```
lib/
├── main.dart                    # 應用入口點
├── models/                      # 數據模型
│   ├── hotel.dart              # 飯店模型
│   ├── booking.dart            # 預訂模型
│   └── user.dart               # 用戶模型
├── providers/                   # 狀態管理 (Provider)
│   ├── hotel_provider.dart      # 飯店狀態
│   ├── booking_provider.dart    # 預訂狀態
│   └── user_provider.dart       # 用戶狀態
├── screens/                     # UI 頁面
│   ├── home_screen.dart         # 首頁
│   ├── hotel_details_screen.dart # 飯店詳情
│   ├── login_screen.dart        # 登入頁面
│   ├── my_bookings_screen.dart  # 我的預訂
│   └── profile_screen.dart      # 個人資料
├── services/                    # 業務邏輯和 API
│   └── api_client.dart          # API 客戶端
├── routes/                      # 路由配置
│   └── app_routes.dart          # 應用路由
└── widgets/                     # 可重用的小部件
    └── home_widget.dart         # 首頁小部件
```

## 功能模塊

### 1. 飯店搜索和瀏覽
- 顯示所有可用飯店列表
- 搜索飯店名稱和城市
- 篩選功能（價格、評分等）

**相關文件：**
- `lib/screens/home_screen.dart`
- `lib/providers/hotel_provider.dart`
- `lib/models/hotel.dart`

### 2. 飯店詳情
- 查看飯店完整信息
- 查看房間類型和價格
- 查看設施和評論

**相關文件：**
- `lib/screens/hotel_details_screen.dart`
- `lib/models/hotel.dart`

### 3. 預訂管理
- 創建新預訂
- 查看我的預訂
- 取消預訂

**相關文件：**
- `lib/providers/booking_provider.dart`
- `lib/models/booking.dart`
- `lib/screens/my_bookings_screen.dart`

### 4. 用戶認證
- 用戶登入
- 用戶註冊
- 用戶個人資料

**相關文件：**
- `lib/providers/user_provider.dart`
- `lib/models/user.dart`
- `lib/screens/login_screen.dart`
- `lib/screens/profile_screen.dart`

## API 集成

### 配置 API 端點

編輯 `lib/services/api_client.dart`：
```dart
static const String baseUrl = 'https://your-api.com';
```

### 實現 API 調用

示例：獲取飯店列表
```dart
static Future<List<Hotel>> fetchHotels() async {
  try {
    final response = await http.get(Uri.parse('$baseUrl/hotels'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Hotel.fromJson(json)).toList();
    }
    throw Exception('Failed to load hotels');
  } catch (e) {
    throw Exception('Error: $e');
  }
}
```

## 依賴管理

### 主要依賴

| 包名 | 版本 | 用途 |
|------|------|------|
| provider | ^6.0.0 | 狀態管理 |
| http | ^1.1.0 | HTTP 請求 |
| google_fonts | ^6.0.0 | 字體 |
| json_serializable | ^6.0.0 | JSON 序列化 |
| intl | ^0.19.0 | 國際化和日期格式 |

添加新依賴：
```bash
flutter pub add <package_name>
```

## 構建應用

### Android APK
```bash
flutter build apk --release
```

### iOS IPA
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 測試

運行所有測試：
```bash
flutter test
```

運行特定測試文件：
```bash
flutter test test/unit/models/hotel_test.dart
```

## 常見問題和解決方案

### 1. 依賴問題
```bash
flutter pub get
flutter pub upgrade
```

### 2. 構建緩存問題
```bash
flutter clean
flutter pub get
flutter run
```

### 3. JSON 序列化代碼未生成
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. 設備連接問題
```bash
flutter devices          # 列出設備
flutter devices -v       # 詳細信息
adb devices              # 查看 Android 設備
```

## 開發最佳實踐

1. **狀態管理**：使用 Provider 進行狀態管理
2. **模型驗證**：在發送數據前驗證數據
3. **錯誤處理**：實現適當的錯誤處理和用戶提示
4. **代碼風格**：遵循 Dart 風格指南
5. **代碼分離**：將 UI、邏輯和 API 分離
6. **測試**：為重要功能編寫單元測試和集成測試

## 性能優化

1. **圖片優化**：使用 `Image.network` 或 `Image.asset` 時指定大小
2. **列表優化**：使用 `ListView.builder` 而非 `ListView`
3. **狀態優化**：使用 `Consumer` 而非在整個頁面上使用 `MultiProvider`
4. **構建優化**：使用 `const` 構造函數

## 資源和文檔

- [Flutter 官方文檔](https://flutter.dev/docs)
- [Dart 官方文檔](https://dart.dev/guides)
- [Provider 包文檔](https://pub.dev/packages/provider)
- [HTTP 包文檔](https://pub.dev/packages/http)

## 支持和反饋

如有問題或建議，請提交 Issue 或發送郵件至 support@hotelapp.com

---

**最後更新**: 2026-02-25
