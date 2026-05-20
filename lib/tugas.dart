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
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
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
        padding: const EdgeInsets.all(20),
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
                ? const Center(
                    child: Text(
                      "Belum ada tugas",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildTaskItem(task),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
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

            const SizedBox(height: 4),

            Text(
              task.jenisTugas,
              style: const TextStyle(color: Colors.white70),
            ),

            const Divider(color: Colors.white10),

            Text(
              "Deadline: ${task.deadline}",
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}