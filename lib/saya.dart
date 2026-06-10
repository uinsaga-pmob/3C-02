import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'custom_navbar.dart';
import 'pengaturan.dart';
import 'login.dart';
import '../database/db_helper.dart';

class Saya extends StatefulWidget {
  const Saya({super.key});

  @override
  State<Saya> createState() => _SayaState();
}

class _SayaState extends State<Saya> {
  int _tugasSelesai = 0;
  int _tugasBelum = 0;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final tasks = await DBHelper.instance.getTasks();
    int selesai = 0;
    int belum = 0;

    for (var t in tasks) {
      if (t.selesai) selesai++;
      else belum++;
    }

    if (mounted) {
      setState(() {
        _tugasSelesai = selesai;
        _tugasBelum = belum;
      });
    }
  }

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Update database lokal
      await DBHelper.instance.updateFotoProfile(DBHelper.activeUserEmail, pickedFile.path);
      
      // Update variabel memori dan layar
      setState(() {
        DBHelper.activeUserFoto = pickedFile.path;
      });
    }
  }

  void _logout() {
    DBHelper.activeUserName = "User Name";
    DBHelper.activeUserEmail = "";
    DBHelper.activeUserFoto = ""; // Bersihkan foto saat logout
    
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
    final subTextColor = isDark ? Colors.white70 : Colors.black54;
    final dividerColor = isDark ? Colors.white10 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: const CustomNavBar(selectedIndex: 3),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            
            // --- AVATAR FOTO PROFIL ---
            GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60, 
                    backgroundColor: const Color(0XFF018592),
                    // Jika ada path foto, tampilkan foto dari galeri. Jika tidak, tampilkan ikon person.
                    backgroundImage: DBHelper.activeUserFoto.isNotEmpty 
                        ? FileImage(File(DBHelper.activeUserFoto)) 
                        : null,
                    child: DBHelper.activeUserFoto.isEmpty
                        ? const Icon(Icons.person, size: 80, color: Colors.white)
                        : null,
                  ),
                  // Ikon kamera kecil
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: cardColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: bgColor, width: 2),
                    ),
                    child: const Icon(Icons.camera_alt, color: Color(0XFF018592), size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            Text(
              DBHelper.activeUserName, 
              style: TextStyle(color: textColor, fontSize: 24, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: 8),
            
            Text(
              DBHelper.activeUserEmail, 
              style: TextStyle(color: subTextColor, fontSize: 16)
            ),
            
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatCard("Diselesaikan", _tugasSelesai, Colors.green, cardColor, subTextColor),
                _buildStatCard("Belum Selesai", _tugasBelum, Colors.orange, cardColor, subTextColor),
              ],
            ),
            
            const SizedBox(height: 20),
            Divider(color: dividerColor),
            const SizedBox(height: 10),

            _buildProfileMenu(context, Icons.settings, "Pengaturan", cardColor, textColor, subTextColor, () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const Pengaturan())).then((_) => setState(() {}));
            }),
            _buildProfileMenu(context, Icons.help_outline, "Bantuan", cardColor, textColor, subTextColor, () {}),
            _buildProfileMenu(context, Icons.info_outline, "Tentang Aplikasi", cardColor, textColor, subTextColor, () {}),

            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Log Out", style: TextStyle(color: Colors.white, fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.withOpacity(0.8),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Menambahkan parameter cardColor dan subTextColor
  Widget _buildStatCard(String title, int count, Color color, Color cardColor, Color subTextColor) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(count.toString(), style: TextStyle(color: color, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: subTextColor, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  // Menambahkan parameter cardColor, textColor, dan trailingColor
  Widget _buildProfileMenu(BuildContext context, IconData icon, String title, Color cardColor, Color textColor, Color trailingColor, VoidCallback onTap) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: const Color(0XFF018592)),
      ),
      title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
      trailing: Icon(Icons.arrow_forward_ios, color: trailingColor, size: 16),
      onTap: onTap,
    );
  }
}