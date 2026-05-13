import 'package:flutter/material.dart';
import 'custom_navbar.dart';

class Notifikasi extends StatelessWidget {
  const Notifikasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.notifications_none_rounded, size: 100, color: Colors.white24),
            SizedBox(height: 20),
            Text("Tidak ada notifikasi", style: TextStyle(color: Colors.white, fontSize: 18)),
          ],
        ),
      ),
    );
  }
}