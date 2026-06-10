import 'package:flutter/material.dart';
import 'custom_navbar.dart';
import 'tambah.dart';
import 'hasil.dart';
import '../database/db_helper.dart';
import '../models/task.dart';

class Tugas extends StatefulWidget {
  const Tugas({super.key});

  @override
  State<Tugas> createState() => _TugasState();
}

class _TugasState extends State<Tugas> {
  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    tasks = await DBHelper.instance.getTasks();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white54 : Colors.black54;
    final cardColor = isDark ? const Color(0XFF1E1E1E) : Colors.white;

    return Scaffold(
      bottomNavigationBar: const CustomNavBar(selectedIndex: 1),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0XFF018592),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Tambah()),
          );
          if (result == true) loadTasks();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Daftar\n        Tugas",
              style: TextStyle(
                color: Color(0XFF018592),
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 28),
            tasks.isEmpty
                ? Center(
                    child: Text(
                      "Belum ada tugas",
                      style: TextStyle(color: subTextColor, fontSize: 18),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildTaskItem(task, cardColor, textColor, subTextColor, isDark),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task task, Color cardColor, Color textColor, Color subTextColor, bool isDark) {
    return InkWell(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Hasil(task: task)),
        );
        if (result == true) loadTasks();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark ? null : [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))
          ],
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
            const SizedBox(height: 4),
            Text(
              task.jenisTugas,
              style: TextStyle(color: subTextColor),
            ),
            const Divider(color: Colors.white10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Deadline: ${task.deadlineFormat}",
                  style: TextStyle(color: subTextColor, fontSize: 12),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: task.selesai 
                        ? Colors.green.withOpacity(0.2) 
                        : Colors.redAccent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    task.selesai ? "Selesai" : "Belum",
                    style: TextStyle(
                      color: task.selesai ? Colors.green : Colors.redAccent,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}