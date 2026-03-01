<<<<<<< HEAD
# flutter_test
Hotel app demo
金樽大飯店 (Gold Hotel) - Flutter 飯店預訂 App
這是一個使用 Flutter 開發的精美飯店預訂應用程式，專為「金樽大飯店」打造。本 App 展示了如何處理動態資料、狀態管理以及流暢的使用者介面設計。

🌟 功能亮點
動態資料驅動：透過 HotelProvider 從本地 JSON 檔案同步讀取飯店資訊、設施與房型資料。

優雅的 UI 設計：

使用 SliverAppBar 實現視差滾動效果的大圖頂欄。

動態產生的設施標籤 (Chips) 與房間資訊卡片。

完整預訂流程：

使用者認證：包含登入頁面與個人資料管理。

飯店詳情：提供詳細的飯店描述、地址與評分展示。

訂單管理：使用者可以查看「我的預訂」狀態，並支援取消預訂功能。

狀態管理：全面採用 Provider 模式，將 UI 與業務邏輯分離，確保代碼易於維護。

🛠️ 技術棧
Framework: Flutter

State Management: Provider

Data Format: JSON (Local Asset)

Font: Google Fonts (Poppins)

=======
# 飯店預訂應用 (Hotel Booking App)

一個由 Flutter 建置的飯店預訂應用，提供飯店搜索、預訂和管理功能。

## 功能

- ✅ 飯店搜索和篩選
- ✅ 飯店詳情查看
- ✅ 房間預訂
- ✅ 用戶認證（登入/註冊）
- ✅ 預訂管理
- ✅ 用戶個人資料

## 技術棧

- **Framework**: Flutter 3.0+
- **Language**: Dart
- **State Management**: Provider
- **API**: HTTP/Dio
- **Database**: SharedPreferences (本地存儲)
- **JSON 序列化**: json_serializable

## 項目結構

```
lib/
├── main.dart                 # 應用入口
├── models/                   # 數據模型
│   ├── hotel.dart
│   ├── booking.dart
│   └── user.dart
├── providers/                # State management
│   ├── hotel_provider.dart
│   ├── booking_provider.dart
│   └── user_provider.dart
├── screens/                  # UI 頁面
│   ├── home_screen.dart
│   └── hotel_details_screen.dart
└── routes/                   # 路由配置
    └── app_routes.dart
```

## 安裝

### 前置條件
- Flutter SDK 3.0 或更高版本
- Dart SDK 3.0 或更高版本

### 步驟

1. 克隆項目或進入項目目錄
   ```bash
   cd hotel_app
   ```

2. 獲取依賴
   ```bash
   flutter pub get
   ```

3. 生成 JSON 序列化代碼
   ```bash
   flutter pub run build_runner build
   ```

4. 運行應用
   ```bash
   flutter run
   ```

## 使用

### 運行應用
```bash
flutter run
```

### 構建 APK (Android)
```bash
flutter build apk --release
```

### 構建 IPA (iOS)
```bash
flutter build ios --release
```

### 運行測試
```bash
flutter test
```

## 主要頁面

### 首頁 (Home Screen)
- 顯示飯店列表
- 搜索功能
- 飯店篩選

### 飯店詳情頁 (Hotel Details)
- 顯示飯店完整信息
- 設施列表
- 開始預訂按鈕

## API 集成 (待實現)

目前應用使用模擬數據。要集成真實 API，請修改以下文件：
- `lib/providers/hotel_provider.dart` - 飯店 API 調用
- `lib/providers/booking_provider.dart` - 預訂 API 調用
- `lib/providers/user_provider.dart` - 用戶認證 API

## 配置

在 `pubspec.yaml` 中修改依賴和版本號。

## 貢獻

歡迎貢獻代碼！請確保：
1. 遵循 Dart 風格指南
2. 為新功能添加測試
3. 更新文檔

## 許可證

MIT License

## 聯絡方式

如有問題或建議，請通過以下方式聯絡：
- Email: support@hotelapp.com
- Issues: GitHub Issues
>>>>>>> 3f0e83c (Initial commit: 金樽大飯店 App 基本架構與 JSON 串接)
