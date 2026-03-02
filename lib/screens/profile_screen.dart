import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'login_screen.dart'; // 確保有引入登入頁面

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('個人資料'),
        centerTitle: true,
      ),
      body: Consumer<UserProvider>(
        builder: (context, userProvider, _) {
          final user = userProvider.currentUser;

          // 1. 如果使用者尚未登入，顯示登入按鈕介面
          if (user == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_circle, size: 100, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    const Text(
                      '尊貴的客賓您好',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text('登入後即可查看您的預訂紀錄與會員優惠', 
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey)
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          // 跳轉至登入頁面
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text('立即登入', 
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // 2. 如果已登入，顯示原本的個人資料介面
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.blue.shade100,
                  backgroundImage: user.profileImage != null ? NetworkImage(user.profileImage!) : null,
                  child: user.profileImage == null
                      ? Icon(Icons.person, size: 50, color: Colors.blue.shade700)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 32),
                _buildInfoTile(Icons.email, '郵箱', user.email),
                _buildInfoTile(Icons.phone, '電話', user.phoneNumber ?? '未設置'),
                _buildInfoTile(Icons.calendar_today, '註冊日期', user.createdAt.toString().split(' ')[0]),
                const SizedBox(height: 48),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      userProvider.logout();
                      // 登出後可以留在原地，UI 會因為 Consumer 自動變回登入按鈕
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text('登出帳號', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 輔助小元件：資料列
  Widget _buildInfoTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue.shade700),
      title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}