import 'package:flutter/material.dart';
import 'custom_navbar.dart';
import 'tambah.dart';
import 'hasil.dart';

class Tugas extends StatefulWidget {
  const Tugas({super.key});

  @override
  State<Tugas> createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF018592),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Tambah())),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Daftar\n        Tugas", style: TextStyle(color: Color(0XFF018592), fontSize: 36, fontWeight: FontWeight.bold)),
            const SizedBox(height: 28),
            _buildTaskItem("Pemrograman Mobile", "Desain + prototype aplikasi", "20 Okt 2025"),
            const SizedBox(height: 16),
            _buildTaskItem("Pemrograman Website", "HTML & CSS Dasar", "25 Okt 2025"),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(String title, String desc, String date) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Hasil())),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: const Color(0XFF1E1E1E), borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Color(0XFF018592), fontSize: 20, fontWeight: FontWeight.bold)),
            Text(desc, style: const TextStyle(color: Colors.white70)),
            const Divider(color: Colors.white10),
            Text("Deadline: $date", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}