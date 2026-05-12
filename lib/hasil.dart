import 'package:flutter/material.dart';
import 'custom_navbar.dart';

class Hasil extends StatefulWidget {
  const Hasil({super.key});

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  bool isFinished = false; // Status checkbox sementara

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      // Tombol Kembali di AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0XFF018592)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Detail Tugas",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // JUDUL HALAMAN
            const Text(
              "Hasil",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "        Tugas",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // KARTU DETAIL UTAMA
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0XFF1E1E1E),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0XFF2A2A2C), width: 1),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama Mata Kuliah sebagai Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0XFF018592).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Pemrograman Mobile",
                      style: TextStyle(
                        color: Color(0XFF018592),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Judul Tugas
                  const Text(
                    "TUGAS DESAIN APLIKASI",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Info Pendukung (Jenis & Deadline)
                  Row(
                    children: [
                      const Icon(Icons.category_outlined, size: 16, color: Colors.grey),
                      const SizedBox(width: 6),
                      const Text("Desain + Prototype", style: TextStyle(color: Colors.grey)),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer_outlined, size: 16, color: Colors.redAccent),
                      const SizedBox(width: 6),
                      const Text("20 Okt 2025", style: TextStyle(color: Colors.redAccent)),
                    ],
                  ),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Divider(color: Color(0XFF2A2A2C)),
                  ),

                  // Deskripsi
                  const Text(
                    "Deskripsi Tugas:",
                    style: TextStyle(color: Color(0XFF018592), fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Tugas kali ini membuat desain aplikasi beserta prototype-nya sesuai arahan dosen. "
                    "Desain harus menggambarkan tampilan UI & UX dengan jelas.\n\n"
                    "Format Pengumpulan:\n"
                    "Nama_NIM_TugasDesainAplikasi.pdf",
                    style: TextStyle(color: Color(0XFFEDEDED), height: 1.5, fontSize: 15),
                  ),

                  const SizedBox(height: 25),

                  // Status Selesai
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isFinished ? Colors.green.withOpacity(0.1) : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isFinished,
                          activeColor: const Color(0XFF018592),
                          onChanged: (val) {
                            setState(() {
                              isFinished = val!;
                            });
                          },
                        ),
                        const Text(
                          "Tandai sebagai selesai",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // TOMBOL TAMBAHAN (OPSIONAL)
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit_note_rounded),
                label: const Text("Edit Catatan"),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  side: const BorderSide(color: Color(0XFF2A2A2C)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}