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
    Navigator.pop(context, true);
  }

  Future<void> updateChecklist(bool value) async {
    setState(() {
      selesai = value;
    });

    await DBHelper.instance.updateTask(
      Task(
        id: widget.task.id,
        mataKuliah: widget.task.mataKuliah,
        jenisTugas: widget.task.jenisTugas,
        deskripsi: widget.task.deskripsi,
        deadline: widget.task.deadline,
        selesai: value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(
        backgroundColor: const Color(0XFF161618),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              "Detail\n        Tugas",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

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
                      fontSize: 20,
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
                    "Deadline: ${task.deadline}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            CheckboxListTile(
              value: selesai,
              activeColor: const Color(0XFF018592),
              title: const Text(
                "Tugas Selesai",
                style: TextStyle(color: Colors.white),
              ),
              onChanged: (value) {
                if (value != null) {
                  updateChecklist(value);
                }
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange, // tetap seperti punyamu
                ),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Tambah(task: widget.task),
                    ),
                  );

                  if (result == true) {
                    Navigator.pop(context, true);
                  }
                },
                child: const Text("Edit"),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
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