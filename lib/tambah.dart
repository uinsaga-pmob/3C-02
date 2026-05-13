import 'package:flutter/material.dart';
import 'custom_navbar.dart'; // Pastikan import ini benar

class Tambah extends StatefulWidget {
  const Tambah({super.key});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      // Gunakan bottomNavigationBar agar navbar menempel di bawah dengan rapi
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 40),
            const Text(
              "Tambah\n        Tugas",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            
            // Reusable Input Button (Contoh satu, terapkan ke yang lain)
            _buildInputButton("Mata Kuliah", "Input Mata Kuliah"),
            const SizedBox(height: 24),
            _buildInputButton("Jenis Tugas", "Input Jenis Tugas"),
            const SizedBox(height: 24),
            _buildInputButton("Deskripsi", "Input Deskripsi Tugas"),
            const SizedBox(height: 24),
            _buildInputButton("Deadline", "Input Deadline Tugas"),
            
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  backgroundColor: const Color(0XFF018592),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {},
                child: const Text("Save", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildInputButton(String title, String subtitle) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0XFF1E1E1E),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 70),
        alignment: Alignment.centerLeft,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0XFF018592))),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}