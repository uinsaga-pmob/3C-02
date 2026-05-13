import 'package:flutter/material.dart';
import 'custom_navbar.dart';

class Saya extends StatelessWidget {
  const Saya({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 3),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            const CircleAvatar(radius: 60, backgroundColor: Color(0XFF018592), child: Icon(Icons.person, size: 80, color: Colors.white)),
            const SizedBox(height: 20),
            const Text("User Name", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
            const Divider(height: 40, color: Colors.white10),
            // Menu profil lainnya...
          ],
        ),
      ),
    );
  }
}