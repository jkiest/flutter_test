import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import '../providers/hotel_provider.dart';
import '../providers/booking_provider.dart'; // 引入預訂 Provider
import '../providers/user_provider.dart';    // 引入用戶 Provider
import '../models/booking.dart';             // 引入 Booking Model

class HomeScreenNew extends StatefulWidget {
  const HomeScreenNew({super.key});

  @override
  State<HomeScreenNew> createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<HotelProvider>().fetchHotelInfo());
    _startBannerTimer();
  }

  void _startBannerTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        _currentPage = (_currentPage + 1) % 2; // 假設有兩張主圖
        _pageController.animateToPage(_currentPage,
            duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
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
        if (hotelProvider.isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final data = hotelProvider.hotelData;
        if (data == null) return const Scaffold(body: Center(child: Text('載入失敗')));

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 280,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(data['name'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  background: PageView(
                    controller: _pageController,
                    children: [
                      Image.asset('assets/images/main.jpg', fit: BoxFit.cover),
                      Image.asset('assets/images/main02.jpg', fit: BoxFit.cover),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('推薦房型', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      // 這裡列出所有房間
                      ... (data['rooms'] as List).map((room) => _buildRoomCard(context, room)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRoomCard(BuildContext context, Map<String, dynamic> room) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.asset(
              room['roomName'].contains('雙人') ? 'assets/images/01.jpg' : 'assets/images/02.jpg',
              height: 160, width: double.infinity, fit: BoxFit.cover,
            ),
          ),
          ListTile(
            title: Text(room['roomName'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('NT\$ ${room['price']} / 晚'),
            trailing: ElevatedButton(
              onPressed: () => _showBookingSheet(context, room),
              child: const Text('選擇'),
            ),
          ),
        ],
      ),
    );
  }

  // --- 核心功能：預訂詳情彈窗 ---
  void _showBookingSheet(BuildContext context, Map<String, dynamic> room) {
    DateTimeRange? selectedRange;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) {
          int nights = selectedRange?.duration.inDays ?? 0;
          double totalPrice = nights * (room['price'] as num).toDouble();

          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    room['roomName'].contains('雙人') ? 'assets/images/great_solo_room.jpg' : 'assets/images/02.jpg',
                    height: 200, width: double.infinity, fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(room['roomName'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Divider(),
                
                // 日期選擇區
                ListTile(
                  leading: const Icon(Icons.date_range, color: Colors.blue),
                  title: Text(selectedRange == null ? "選擇日期" : "${selectedRange!.start.toString().split(' ')[0]} ~ ${selectedRange!.end.toString().split(' ')[0]}"),
                  subtitle: Text(nights > 0 ? "共 $nights 晚" : "請選擇入住與退房日期"),
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setModalState(() => selectedRange = picked);
                  },
                ),
                
                const Spacer(),
                
                // 價格顯示與確認按鈕
                if (nights > 0) 
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("總計金額", style: TextStyle(fontSize: 18)),
                        Text("NT\$ $totalPrice", style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue)),
                      ],
                    ),
                  ),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800),
                    onPressed: selectedRange == null ? null : () {
                      final user = context.read<UserProvider>().currentUser;
                      if (user == null) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("請先登入後再預訂")));
                        return;
                      }

                      // 呼叫 BookingProvider 新增預訂
                      context.read<BookingProvider>().addBooking(Booking(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        userId: user.id,
                        hotelId: "gold_hotel_001",
                        roomId: room['roomName'],
                        checkInDate: selectedRange!.start,
                        checkOutDate: selectedRange!.end,
                        numberOfGuests: 2,
                        numberOfRooms: 1,
                        totalPrice: totalPrice,
                        status: BookingStatus.confirmed,
                        bookingDate: DateTime.now(),
                      ));

                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("預訂成功！"), backgroundColor: Colors.green));
                    },
                    child: const Text('確認預訂', style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}