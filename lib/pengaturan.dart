import 'package:flutter/material.dart';
import 'login.dart';
import 'main.dart'; 
import 'notification.dart';
import '../database/db_helper.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  bool _isDarkMode = true; 
  bool _isNotifOn = true;

  @override
  void initState() {
    super.initState();
    _isDarkMode = themeNotifier.value == ThemeMode.dark;
    _isNotifOn = notifNotifier.value; 
  }

  void _logout() {
    DBHelper.activeUserName = "User Name";
    DBHelper.activeUserEmail = "";
    DBHelper.activeUserFoto = "";
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- VARIABEL WARNA ADAPTIF ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0XFF161618) : const Color(0XFFF5F5F7);
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white54 : Colors.black54;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text(
          "Pengaturan",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'asset/images/Taskuy.jpeg',
                  height: 100,
                ),
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Preferensi Aplikasi",
              style: TextStyle(color: Color(0XFF018592), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  // --- SWITCH DARK MODE ---
                  SwitchListTile(
                    title: Text("Dark Mode", style: TextStyle(color: textColor)),
                    subtitle: Text("Tema gelap aplikasi", style: TextStyle(color: subTextColor, fontSize: 12)),
                    secondary: const Icon(Icons.dark_mode, color: Color(0XFF018592)),
                    activeColor: const Color(0XFF018592),
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                        themeNotifier.value = value ? ThemeMode.dark : ThemeMode.light;
                      });
                    },
                  ),
                  Divider(color: dividerColor, height: 1),
                  // --- SWITCH NOTIFIKASI ---
                  SwitchListTile(
                    title: Text("Notifikasi", style: TextStyle(color: textColor)),
                    subtitle: Text("Peringatan deadline tugas", style: TextStyle(color: subTextColor, fontSize: 12)),
                    secondary: const Icon(Icons.notifications_active, color: Color(0XFF018592)),
                    activeColor: const Color(0XFF018592),
                    value: _isNotifOn,
                    onChanged: (value) {
                      setState(() {
                        _isNotifOn = value;
                        notifNotifier.value = value; // Menyebarkan status notifikasi ke seluruh aplikasi
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              "Akun",
              style: TextStyle(color: Color(0XFF018592), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.lock_reset, color: textColor.withOpacity(0.7)),
                    title: Text("Ubah Kata Sandi", style: TextStyle(color: textColor)),
                    trailing: Icon(Icons.arrow_forward_ios, color: subTextColor, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur ubah kata sandi dari pengaturan belum tersedia")),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text(
                "Log Out",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF823032), 
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}