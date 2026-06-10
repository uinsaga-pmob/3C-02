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

  Future<void> hapusTask() async {
    await DBHelper.instance.deleteTask(widget.task.id!);
    if (!mounted) return;
    Navigator.pop(context, true);
  }

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
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    // --- ADAPTIF WARNA TEMA ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Tugas", style: TextStyle(color: textColor)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.task.mataKuliah, style: const TextStyle(color: Color(0XFF018592), fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Jenis Tugas: ${widget.task.jenisTugas}", style: TextStyle(color: textColor, fontSize: 16)),
            const SizedBox(height: 16),
            Text("Deadline:", style: TextStyle(color: subTextColor, fontSize: 14)),
            Text(widget.task.deadlineFormat, style: const TextStyle(color: Colors.redAccent, fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            Text("Deskripsi:", style: TextStyle(color: subTextColor, fontSize: 14)),
            const SizedBox(height: 8),
            Text(widget.task.deskripsi, style: TextStyle(color: textColor, fontSize: 16, height: 1.5)),
            const SizedBox(height: 40),
            
            CheckboxListTile(
              title: Text("Tandai Selesai", style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
              value: selesai,
              activeColor: const Color(0XFF018592),
              checkColor: Colors.white,
              onChanged: (val) {
                if (val != null) setState(() => selesai = val);
              },
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0XFF015E67), padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: simpanStatus,
                child: const Text("Simpan Status", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: () async {
                  final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => Tambah(task: widget.task)));
                  if (result == true && mounted) Navigator.pop(context, true);
                },
                child: const Text("Edit", style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red, padding: const EdgeInsets.symmetric(vertical: 14)),
                onPressed: hapusTask,
                child: const Text("Hapus", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}