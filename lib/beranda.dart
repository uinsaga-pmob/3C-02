import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'pengaturan.dart';
import 'tugas.dart';
import 'notification.dart';
import 'saya.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF161618),
      appBar: AppBar(
        title: const Text('TASKUY', style: TextStyle(color: Color(0XFF015E67), fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0XFF015E67)),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Pengaturan())),
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
              todayDecoration: BoxDecoration(color: Color(0XFF015E67), shape: BoxShape.circle),
            ),
          ),
          const Spacer(),
          // Bottom Navigation Dummy
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: const BoxDecoration(
              color: Color(0XFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.home, color: Color(0XFF018592), size: 30),
                IconButton(icon: const Icon(Icons.book, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Tugas()))),
                IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Notifikasi()))),
                IconButton(icon: const Icon(Icons.person, color: Colors.white), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Saya()))),
              ],
            ),
          )
        ],
      ),
    );
  }
}