import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async'; // 用於計時器輪播
import '../providers/hotel_provider.dart';

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}// 在 _HomeScreenNewState 類別內的最下方加入：

void _showBookingSheet(BuildContext context, Map<String, dynamic> room) {
  // 先定義一個變數來儲存選擇的日期（預設為今天）
  DateTimeRange? selectedRange;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent, // 讓背景透明以套用圓角
    builder: (context) => StatefulBuilder( // 使用 StatefulBuilder 讓視窗內日期可以即時更新
      builder: (context, setModalState) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              // 1. 頂部裝飾條
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12),
                width: 40, height: 4,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. 房間大圖預覽
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          room['roomName'].contains('雙人') ? 'assets/images/01.jpg' : 'assets/images/02.jpg',
                          height: 220, width: double.infinity, fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 3. 標題與價格
                      Text(room['roomName'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('NT\$ ${room['price']} / 晚', style: TextStyle(fontSize: 18, color: Colors.blue.shade700)),
                      const Divider(height: 40),

                      // 4. 日期選擇器區域
                      const Text('預訂行程', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          final DateTimeRange? picked = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(days: 365)),
                            builder: (context, child) => Theme(data: ThemeData.light(), child: child!),
                          );
                          if (picked != null) {
                            setModalState(() => selectedRange = picked); // 更新視窗內的狀態
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue.shade100),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.blue.shade50.withOpacity(0.3),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.date_range, color: Colors.blue),
                              const SizedBox(width: 15),
                              Text(
                                selectedRange == null 
                                  ? '點擊選擇入住與退房日期' 
                                  : '${selectedRange!.start.toString().split(' ')[0]}  至  ${selectedRange!.end.toString().split(' ')[0]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 5. 底部確認按鈕
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade800,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: selectedRange == null ? null : () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${room['roomName']} 預訂成功！'), backgroundColor: Colors.green),
                      );
                    },
                    child: const Text('確認預訂並付款', style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    ),
  );
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  // 首頁輪播圖清單
  final List<String> _bannerImages = [
    'assets/images/main.jpg',
    'assets/images/main02.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // 1. 抓取資料
    Future.microtask(() =>
        context.read<HotelProvider>().fetchHotelInfo());

    // 2. 設定自動輪播計時器
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HotelProvider>(
      builder: (context, hotelProvider, _) {
        // 載入中狀態
        if (hotelProvider.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final data = hotelProvider.hotelData;

        // 錯誤處理
        if (data == null) {
          return const Scaffold(
            body: Center(child: Text('找不到金樽大飯店的資料')),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              // --- 頂部輪播大圖區 ---
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: Colors.blue.shade900,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(data['name'], 
                    style: const TextStyle(
                      color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                    )),
                  background: Stack(
                    children: [
                      // 輪播組件
                      PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) => setState(() => _currentPage = index),
                        itemCount: _bannerImages.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            _bannerImages[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                      // 輪播指示點
                      Positioned(
                        bottom: 10,
                        right: 20,
                        child: Row(
                          children: List.generate(_bannerImages.length, (index) => 
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentPage == index ? Colors.white : Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // --- 飯店資訊介紹 ---
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('五星級尊榮體驗', 
                              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                          Text('★ ${data['rating']}', 
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(data['description'], 
                          style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87)),
                      const SizedBox(height: 25),
                      
                      const Text('飯店設施', 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: (data['amenities'] as List).map((item) => Chip(
                          label: Text(item),
                          backgroundColor: Colors.blue.shade50,
                          side: BorderSide.none,
                        )).toList(),
                      ),
                      
                      const SizedBox(height: 30),
                      const Text('精選房型', 
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      // 房間列表渲染
                      ... (data['rooms'] as List).map((room) => _buildRoomCard(room)).toList(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: _buildBottomBar(data['minPrice']),
        );
      },
    );
  }

  // 房間卡片組件
  Widget _buildRoomCard(Map<String, dynamic> room) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () { /* 跳轉房間詳情預覽 */ },
        child: Column(
          children: [
            // 這裡可以根據房間名稱動態載入你之前的 01.jpg 或 02.jpg
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.asset(
                room['roomName'].contains('雙人') ? 'assets/images/01.jpg' : 'assets/images/02.jpg',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.all(15),
              title: Text(room['roomName'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('NT\$ ${room['price']} / 晚', style: const TextStyle(color: Colors.blueGrey)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade700,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _showBookingSheet(context, room), // 呼叫下方抽離的方法
        child: const Text('選擇'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 底部預訂導覽列
  Widget _buildBottomBar(dynamic price) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 25),
      decoration: BoxDecoration(
        color: Colors.white, 
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('最低起價', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('NT\$ $price', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue.shade800, 
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () { /* 立即預訂邏輯 */ },
            child: const Text('立即預訂', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}