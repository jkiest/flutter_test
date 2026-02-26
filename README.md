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

📂 專案結構
lib/
├── models/          # 資料模型 (Hotel, Booking, User)
├── providers/       # 狀態管理中心 (HotelProvider, UserProvider, etc.)
├── screens/         # UI 畫面
│   ├── home_screen.dart           # 飯店首頁
│   ├── login_screen.dart          # 登入頁面
│   ├── hotel_details_screen.dart  # 飯店詳細資訊
│   ├── my_bookings_screen.dart    # 訂單列表
│   └── profile_screen.dart        # 個人資料頁面
└── main.dart        # App 入口與 Provider 配置
