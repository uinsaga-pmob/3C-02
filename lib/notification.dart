import 'package:flutter/material.dart';
import 'custom_navbar.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

// Variabel global untuk mendeteksi status tombol notifikasi dari pengaturan
final ValueNotifier<bool> notifNotifier = ValueNotifier(true);

class Notifikasi extends StatefulWidget {
  const Notifikasi({super.key});

  @override
  State<Notifikasi> createState() => _NotifikasiState();
}

class _NotifikasiState extends State<Notifikasi> {
  List<Task> _notifTasks = [];

  @override
  void initState() {
    super.initState();
    _loadNotifTasks();
  }

  // Mengambil tugas yang perlu dinotifikasikan (Hari ini & Terlewat)
  Future<void> _loadNotifTasks() async {
    final tasks = await DBHelper.instance.getTasks();
    final now = DateTime.now();

    if (mounted) {
      setState(() {
        _notifTasks = tasks.where((t) {
          return !t.selesai && (t.isToday() || t.deadline.isBefore(now));
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- ADAPTIF WARNA TEMA ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0XFF161618) : const Color(0XFFF5F5F7);
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white54 : Colors.black54;
    final iconColor = isDark ? Colors.white24 : Colors.black12;

    return Scaffold(
      backgroundColor: bgColor,
      bottomNavigationBar: const CustomNavBar(selectedIndex: 2),
      appBar: AppBar(
        title: Text("Notifikasi", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      // Memantau perubahan tombol on/off secara real-time
      body: ValueListenableBuilder<bool>(
        valueListenable: notifNotifier,
        builder: (context, isNotifOn, child) {
          
          // KONDISI 1: Jika tombol Notifikasi OFF
          if (!isNotifOn) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_off_rounded, size: 100, color: iconColor),
                  const SizedBox(height: 20),
                  Text("Notifikasi Dinonaktifkan", style: TextStyle(color: textColor, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("Aktifkan kembali melalui Pengaturan", style: TextStyle(color: subTextColor, fontSize: 14)),
                ],
              ),
            );
          }

          // KONDISI 2: Jika tombol Notifikasi ON tapi tidak ada tugas mendesak
          if (_notifTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notifications_none_rounded, size: 100, color: iconColor),
                  const SizedBox(height: 20),
                  Text("Tidak ada notifikasi baru", style: TextStyle(color: textColor, fontSize: 18)),
                ],
              ),
            );
          }

          // KONDISI 3: Jika Notifikasi ON dan ada tugas mendesak
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _notifTasks.length,
            itemBuilder: (context, index) {
              final task = _notifTasks[index];
              // Cek apakah tugas sudah lewat tenggat waktu dan bukan hari ini
              final isOverdue = task.deadline.isBefore(DateTime.now()) && !task.isToday();

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isOverdue ? Colors.redAccent.withOpacity(0.5) : const Color(0XFF018592).withOpacity(0.5),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isOverdue ? Icons.warning_rounded : Icons.notifications_active_rounded,
                      color: isOverdue ? Colors.redAccent : const Color(0XFF018592),
                      size: 30,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isOverdue ? "Tugas Terlewat!" : "Tugas Hari Ini",
                            style: TextStyle(
                              color: isOverdue ? Colors.redAccent : const Color(0XFF018592),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(task.mataKuliah, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 2),
                          Text("Deadline: ${task.deadlineFormat}", style: TextStyle(color: subTextColor, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}