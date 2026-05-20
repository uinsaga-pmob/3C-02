import 'package:flutter/material.dart';
import 'tambah.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

class Hasil extends StatefulWidget {
  final Task task;

  const Hasil({super.key, required this.task});

  @override
  State<Hasil> createState() => _HasilState();
}

class _HasilState extends State<Hasil> {
  late bool selesai;

  @override
  void initState() {
    super.initState();
    selesai = widget.task.selesai;
  }

  // =========================
  // HAPUS TASK
  // =========================
  Future<void> hapusTask() async {
    await DBHelper.instance.deleteTask(widget.task.id!);

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  // =========================
  // SIMPAN STATUS CHECKLIST
  // =========================
  Future<void> simpanStatus() async {
    await DBHelper.instance.updateTask(
      Task(
        id: widget.task.id,
        mataKuliah: widget.task.mataKuliah,
        jenisTugas: widget.task.jenisTugas,
        deskripsi: widget.task.deskripsi,
        deadline: widget.task.deadline,
        selesai: selesai,
      ),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Status tugas berhasil disimpan"),
      ),
    );

    // 🔥 penting: balik ke beranda + refresh
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      backgroundColor: const Color(0XFF161618),

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: const Color(0XFF161618),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Detail\nTugas",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            // ================= DETAIL CARD =================
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0XFF1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.mataKuliah,
                    style: const TextStyle(
                      color: Color(0XFF018592),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    task.jenisTugas,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    task.deskripsi,
                    style: const TextStyle(color: Colors.white70),
                  ),

                  const Divider(color: Colors.white10),

                  Text(
                    "Deadline: ${task.deadlineFormat}",
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    selesai ? "Status: Selesai" : "Status: Belum selesai",
                    style: TextStyle(
                      color: selesai ? Colors.green : Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= CHECKBOX =================
            CheckboxListTile(
              value: selesai,
              activeColor: const Color(0XFF018592),
              title: const Text(
                "Tandai tugas selesai",
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                setState(() {
                  selesai = value ?? false;
                });
              },
            ),

            const SizedBox(height: 20),

            // ================= SIMPAN =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0XFF018592),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: simpanStatus,
                child: const Text("Simpan Status"),
              ),
            ),

            const SizedBox(height: 12),

            // ================= EDIT =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Tambah(task: widget.task),
                    ),
                  );

                  if (result == true && mounted) {
                    Navigator.pop(context, true);
                  }
                },
                child: const Text("Edit"),
              ),
            ),

            const SizedBox(height: 12),

            // ================= DELETE =================
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: hapusTask,
                child: const Text("Hapus"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}