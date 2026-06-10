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
    // --- Logika Warna Adaptif ---
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final secondaryTextColor = isDark ? Colors.white54 : Colors.black54;
    final itemBgColor = isDark ? const Color(0XFF1E1E22) : Colors.grey.shade200;
    final borderColor = isDark ? const Color(0XFF018592) : Colors.grey.shade400;

    return Scaffold(
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
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Color(0XFF018592),
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: textColor),
              weekendTextStyle: TextStyle(color: secondaryTextColor),
            ),
            headerStyle: HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(color: textColor),
              leftChevronIcon: Icon(Icons.chevron_left, color: textColor),
              rightChevronIcon: Icon(Icons.chevron_right, color: textColor),
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
                ? Center(
                    child: Text(
                      "Tidak ada tugas hari ini",
                      style: TextStyle(color: secondaryTextColor),
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
                            color: itemBgColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: borderColor),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                task.selesai
                                    ? Icons.check_circle
                                    : Icons.radio_button_unchecked,
                                color: task.selesai
                                    ? Colors.green
                                    : secondaryTextColor,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.mataKuliah,
                                      style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      task.jenisTugas,
                                      style: TextStyle(
                                        color: secondaryTextColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Text(
                                task.deadlineFormat,
                                style: TextStyle(
                                  color: secondaryTextColor,
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
      bottomNavigationBar: const CustomNavBar(selectedIndex: 0),
    );
  }
}