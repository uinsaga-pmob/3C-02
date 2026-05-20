import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../database/db_helper.dart';
import '../models/task.dart';
import 'custom_navbar.dart';
import 'pengaturan.dart';
import 'hasil.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DateTime _focusedDay = DateTime.now();

  List<Task> _tasksHariIni = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final data = await DBHelper.instance.getTasks();

    if (!mounted) return;

    setState(() {
      _tasksHariIni = data.where((t) => t.isToday()).toList();
    });
  }

  Future<void> _openDetail(Task task) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Hasil(task: task),
      ),
    );

    if (result == true) {
      await _loadTasks();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(
        title: const Text(
          'TASKUY',
          style: TextStyle(
            color: Color(0XFF018592),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0XFF018592)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => Pengaturan()),
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Color(0XFF018592),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.white70),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon:
                  Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon:
                  Icon(Icons.chevron_right, color: Colors.white),
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Tugas Hari Ini",
                style: TextStyle(
                  color: Color(0XFF018592),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Expanded(
            child: _tasksHariIni.isEmpty
                ? const Center(
                    child: Text(
                      "Tidak ada tugas hari ini",
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasksHariIni.length,
                    itemBuilder: (context, index) {
                      final task = _tasksHariIni[index];

                      return GestureDetector(
                        onTap: () => _openDetail(task),

                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0XFF1E1E22),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0XFF018592),
                            ),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                task.selesai
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.selesai
                                    ? Colors.green
                                    : Colors.white54,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.mataKuliah,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      task.jenisTugas,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                task.deadlineFormat,
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      bottomNavigationBar:
          const CustomNavBar(selectedIndex: 0),
    );
  }
}